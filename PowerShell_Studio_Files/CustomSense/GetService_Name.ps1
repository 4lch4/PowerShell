<#	
	.NOTES
	===========================================================================
	 Created with: 	SAPIEN Technologies, Inc., PowerShell Studio 2016 v5.2.109
	 Created on:   	2/17/2016 11:16 AM
	 Organization: 	SAPIEN Technologies, Inc.
	 Filename:     	GetService_Name.ps1
	===========================================================================
	.DESCRIPTION
		Save the service names for custom PrimalSense.
#>


Get-Service | Select-Object -ExpandProperty Name > $CustomSensePath\GetService_Name.csv