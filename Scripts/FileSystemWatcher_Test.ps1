<#	
	.NOTES
	===========================================================================
	 Created with: 	SAPIEN Technologies, Inc., PowerShell Studio 2017 v5.4.135
	 Created on:   	2/20/2017 9:39 PM
	 Created by:   	Alcha
	 Organization: 	
	 Filename:     	
	===========================================================================
	.DESCRIPTION
		A description of the file.
#>

Function Start-FileSystemWatcher {
	[CmdletBinding()]
	Param (
		[parameter()]
		[string]
		$Path,
		
		[parameter()]
		[ValidateSet('Changed', 'Created', 'Deleted', 'Renamed')]
		[string[]]
		$EventName,
		
		[parameter()]
		[string]
		$Filter,
		
		[parameter()]
		[System.IO.NotifyFilters]
		$NotifyFilter,
		
		[parameter()]
		[switch]
		$Recurse,
		
		[parameter()]
		[scriptblock]
		$Action
		
	)
	
	#region Build  FileSystemWatcher
	
	$FileSystemWatcher = New-Object  System.IO.FileSystemWatcher
	
	If (-NOT $PSBoundParameters.ContainsKey('Path')) {
		
		$Path = $PWD
		
	}
	
	$FileSystemWatcher.Path = $Path
	
	If ($PSBoundParameters.ContainsKey('Filter')) {
		
		$FileSystemWatcher.Filter = $Filter
		
	}
	
	If ($PSBoundParameters.ContainsKey('NotifyFilter')) {
		
		$FileSystemWatcher.NotifyFilter = $NotifyFilter
		
	}
	
	If ($PSBoundParameters.ContainsKey('Recurse')) {
		
		$FileSystemWatcher.IncludeSubdirectories = $True
		
	}
	
	If (-NOT $PSBoundParameters.ContainsKey('EventName')) {
		
		$EventName = 'Changed', 'Created', 'Deleted', 'Renamed'
		
	}
	
	If (-NOT $PSBoundParameters.ContainsKey('Action')) {
		
		$Action = {
			
			Switch ($Event.SourceEventArgs.ChangeType) {
				
				'Renamed'  {
					
					$Object = "{0} was  {1} to {2} at {3}" -f $Event.SourceArgs[-1].OldFullPath,
					
					$Event.SourceEventArgs.ChangeType,
					
					$Event.SourceArgs[-1].FullPath,
					
					$Event.TimeGenerated
					
				}
				
				Default {
					
					$Object = "{0} was  {1} at {2}" -f $Event.SourceEventArgs.FullPath,
					
					$Event.SourceEventArgs.ChangeType,
					
					$Event.TimeGenerated
					
				}
				
			}
			
			$WriteHostParams = @{
				
				ForegroundColor = 'Green'
				
				BackgroundColor = 'Black'
				
				Object = $Object
				
			}
			
			Write-Host  @WriteHostParams
			
		}
		
	}
	
	#endregion  Build FileSystemWatcher
	#region  Initiate Jobs for FileSystemWatcher
	
	$ObjectEventParams = @{
		
		InputObject = $FileSystemWatcher
		
		Action = $Action
		
	}
	
	ForEach ($Item in $EventName) {
		
		$ObjectEventParams.EventName = $Item
		
		$ObjectEventParams.SourceIdentifier = "File.$($Item)"
		
		Write-Verbose  "Starting watcher for Event: $($Item)"
		
		$Null = Register-ObjectEvent  @ObjectEventParams
		
	}
	
	#endregion  Initiate Jobs for FileSystemWatcher
	
}



$FileSystemWatcherParams = @{
	Path = 'D:\Temp'
	Recurse = $True
	NotifyFilter = 'FileName'
	Verbose = $True
	Action = {
		$Item = Get-Item $Event.SourceEventArgs.FullPath
		
		$WriteHostParams = @{
			ForegroundColor = 'Green'
			BackgroundColor = 'Black'
		}
		
		Switch -regex ($Item.Extension) {
			'\.(ps1|psm1|psd1)'  { $WriteHostParams.Object = "Processing  PowerShell file: $($Item.Name)" }
			'\.(docx|doc)'  { $WriteHostParams.Object = "Processing  Word document: $($Item.Name)" }
			'\.(xlsx|xls)'  { $WriteHostParams.Object = "Processing  Excel spreadsheet: $($Item.Name)" }
			'\.csv'  { $WriteHostParams.Object = "Processing  CSV spreadsheet: $($Item.Name)" }
			'\.xml'  { $WriteHostParams.Object = "Processing  XML document: $($Item.Name)" }
			'\.exe'  { $WriteHostParams.Object = "Processing  Executable: $($Item.Name)" }
			'\.onepkg'  { $WriteHostParams.Object = "Processing  OneNote package: $($Item.Name)" }
			'\.lnk'  { $WriteHostParams.Object = "Processing  Link: $($Item.Name)" }
			'\.cer|\.pfx'  { $WriteHostParams.Object = "Processing  Certificate File: $($Item.Name)" }
			Default {
				$WriteHostParams.Object = "Processing  File: $($Item.Name)"
				if ($Item.Name -contains ' ') {
					Replace-FilenameCharacter -Path $Item.FullName -OldValues ' ' -NewValue '_'
				}
			}
		}
		$Item | Remove-Item
		Write-Host  @WriteHostParams
	}
}

@('Created') | ForEach-Object {
	$FileSystemWatcherParams.EventName = $_
	Start-FileSystemWatcher  @FileSystemWatcherParams
}

@('Changed') | ForEach-Object {
	$FileSystemWatcherParams.EventName = $_
	Start-FileSystemWatcher  @FileSystemWatcherParams
}

@('Deleted') | ForEach-Object {
	$FileSystemWatcherParams.EventName = $_
	Start-FileSystemWatcher  @FileSystemWatcherParams
}