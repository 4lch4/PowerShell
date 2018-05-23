<#	
	.NOTES
	===========================================================================
	 Created with: 	SAPIEN Technologies, Inc., PowerShell Studio 2016 v5.2.118
	 Created on:   	4/1/2016 5:52 PM
	 Created by:   	 DevinL
	 Organization: 	SAPIEN Technologies, Inc.
	 Filename:     	Practice-Script.ps1
	===========================================================================
	.DESCRIPTION
		A description of the file.
#>
function Build-Item
{
	param (
		$ProjectDir,
		$PSBuildOpts
	)
	
	$PSBuildPath = Find-Install
	Write-Verbose $PSBuildPath
	
	$PSBuildSettingsFile = Get-ChildItem -Path $ProjectDir -Filter *.psbuild | ForEach-Object { $_.FullName }
	
	if (($PSBuildSettingsFile -ne $null) -and (Test-Path $PSBuildSettingsFile))
	{
		$Builder = New-Object System.Diagnostics.Process
		$Builder.StartInfo.WorkingDirectory = $ProjectDir
		$Builder.StartInfo.FileName = $PSBuildPath
		$Builder.StartInfo.Arguments = "/$PSBuildOpts $PSBuildSettingsFile"
		$Builder.StartInfo.UseShellExecute = $false
		$Builder.StartInfo.RedirectStandardOutput = $true
		
		if ($Builder.Start())
		{
			[String]$Output = $Builder.StandardOutput.ReadToEnd()
		}
		
		Write-Output $Output
	}
	else
	{
		Write-Warning "No psbuild file could be located."
		Write-Warning "If this is your first time building an exe, do so from PowerShell Studio or PrimalScript first."
	}
}

function Find-Install
{
	try
	{
		$RegPath = 'HKLM:\SOFTWARE\SAPIEN Technologies, Inc.\'
		$SPSPath = Get-ChildItem $RegPath -ErrorAction Stop | Select-Object PSPath | ForEach-Object { if ($_.PSPath -match "PowerShell Studio") { $_.PSPath } }
		$PSRPath = Get-ChildItem $RegPath -ErrorAction Stop | Select-Object PSPath | ForEach-Object { if ($_.PSPath -match "PrimalScript") { $_.PSPath } }
		if (($SPSPath -ne $null) -and (Test-Path $SPSPath))
		{
			$PSBuildPath = Split-Path (Get-ItemProperty $SPSPath).Path -Parent
		}
		elseif (($PSRPath -ne $null) -and (Test-Path $PSRPath))
		{
			$PSBuildPath = Split-Path (Get-ItemProperty $PSRPath).Path -Parent
		}
		else
		{
			Write-Warning 'You do not have PowerShell Studio or PrimalScript installed.'
			Write-Warning 'Please install one or the other to continue.'
		}
		$PSBuildPath += "\psbuild.exe"
		Resolve-Path $PSBuildPath
	}
	catch [System.Management.Automation.ItemNotFoundException] {
		Write-Warning 'You do not have any SAPIEN Software installed.'
		Write-Warning 'Please install PowerShell Studio or PrimalScript and try again.'
	}
}

function Invoke-Deploy
{
	param
	(
		[Parameter(Mandatory = $true,
				   Position = 0)]
		[String]$ProjectDir
	)
	
	try
	{
		$ProjectDir = Resolve-Path $ProjectDir
		Build-Item -ProjectDir $ProjectDir -PSBuildOpts "DEPLOY"
	}
	catch [System.Management.Automation.ItemNotFoundException] {
		Write-Warning 'The specified directory does not exist.'
		Write-Debug 'ItemNotFoundException'
	}
	catch [System.Management.Automation.ParameterBindingException] {
		Write-Warning 'The specified directory does not exist.'
		Write-Debug 'ParameterBindingException'
	}
}

Invoke-Deploy 'DD'
