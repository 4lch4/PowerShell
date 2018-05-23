<#	
	.NOTES
	===========================================================================
	 Created with: 	SAPIEN Technologies, Inc., PowerShell Studio 2016 v5.3.130
	 Created on:   	11/19/2016 10:07 AM
	 Created by:   	DevinL
	 Organization: 	SAPIEN Technologies, Inc.
	 Filename:     	
	===========================================================================
	.DESCRIPTION
		A description of the file.
	
	.NOTES
		I don't turn these into Cmdlets because of the way I export files.
#>
function Get-MortyFront {
	param
	(
		[Parameter(Position = 0)]
		[String]
		$StorageDir = "D:\Media\Pictures\Morty\"
	)
	
	for ($x = 2; $x -le 168; $x++) {
		$MortyCounter = "{0:D3}" -f $x
		$Url = "https://pocketmortys.net/images/large/$MortyCounter-Front.png"
		
		$FileName = "$StorageDir\Morty-$MortyCounter-Front.png"
		
		if ($null -eq (Get-ChildItem $FileName)) {
			$WebClient = New-Object -TypeName System.Net.WebClient
			$WebClient.DownloadFile($Url, $FileName)
			Write-Output "Downloaded " + $FileName
		}
	}
}

function Get-MortyBack {
	param
	(
		[Parameter(Position = 0)]
		[String]
		$StorageDir = "D:\Media\Pictures\Morty\"
	)
	
	for ($x = 2; $x -le 158; $x++) {
		$MortyCounter = "{0:D3}" -f $x
		$Url = "https://pocketmortys.net/images/large/$MortyCounter-Back.png"
		
		$FileName = "$StorageDir\Morty-$MortyCounter-Back.png"
		
		$WebClient = New-Object -TypeName System.Net.WebClient
		$WebClient.DownloadFile($Url, $FileName)
	}
}

function Get-Sprites {
	param
	(
		[Parameter(Position = 0)]
		[String]
		$StorageDir = "D:\Media\Pictures\Morty\"
	)
	
	
	for ($x = 2; $x -le 158; $x++) {
		$MortyCounter = "{0:D3}" -f $x
		$WebClient = New-Object -TypeName System.Net.WebClient
		
		for ($y = 1; $y -le 3; $y++) {
			[System.String]$Url = "https://pocketmortys.net/images/sprites/sprites_" + "$MortyCounter" + "_" + $y + ".png"
			[System.String]$FileName = "$StorageDir\Sprite_" + "$MortyCounter" + "_" + $y + ".png"
			
			$WebClient.DownloadFile($Url, $FileName)
		}
	}
}