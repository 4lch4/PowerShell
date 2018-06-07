<#	
	.NOTES
	===========================================================================
	 Created with: 	SAPIEN Technologies, Inc., PowerShell Studio 2016 v5.2.109
	 Created on:   	2/17/2016 11:17 AM	
	 Organization: 	SAPIEN Technologies, Inc.
	 Filename:     	GetProcess_Name.ps1
	===========================================================================
	.DESCRIPTION
		Save the process names for custom PrimalSense.
#>

Get-Process | Select-Object -ExpandProperty Name -Unique > "$CustomSensePath\GetProcess_Name.csv"