<#	
	.NOTES
	===========================================================================
	 Created with: 	SAPIEN Technologies, Inc., PowerShell Studio 2016 v5.2.118
	 Created on:   	4/3/2016 7:07 PM
	 Created by:   	dleam
	 Organization: 	SAPIEN Technologies, Inc.
	 Filename:     	
	===========================================================================
	.DESCRIPTION
		A description of the file.
#>

function Generate-DefaultPSBuild {
	
}
$TempStr = 'Test man..'
$PSBuildPackageText = @"
[Package]
Output=Generate-PSBuild
IconFile=C:\Program Files\SAPIEN Technologies, Inc\PowerShell Studio 2016\ScriptPackage.ico
Manifest=
ManifestType=1
STA=1
GenerateConfigFile=1
Password2=
Username=
Engine=SAPIEN PowerShell V3 Host (Command line) x64
UseRunAs=0
PFX=
TimeStamp=http://timestamp.globalsign.com/scripts/timstamp.dll
PFXPassword2=
RestrictUser=
RestrictMAC=
RestrictMachine=
RestrictDomain=
RestrictInstance=0
RestrictedOS=
FileVersion=1.0.0.1
ProductVersion=1.0.0.1
ProductName=Generate-PSBuild
Description=
Company=SAPIEN Technologies, Inc.
Copyright=Copyright (c) 2016 All rights reserved
InternalName=
OriginalName=$TempStr
Comments=
AutoIncrementVersion=0
"@

$PSBuildPackageText