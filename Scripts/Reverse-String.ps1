#	===========================================================================
#	Created on:   5/28/2018 @ 19:17
#	Created by:   Alcha
#	Organization: HassleFree Solutions, LLC
#	Filename:     Reverse-String.ps1
#	===========================================================================

<#
.SYNOPSIS
  A simple script for reversing a String.

.DESCRIPTION
  A simple script for reversing a String in PowerShell in order to show some
  basics of how to use the language.

.PARAMETER Input
  The string to reverse.

.EXAMPLE
  .\Reverse-String.ps1 -Input 'Hello, World'

.NOTES
  This is for the sample-programs repo available here on GitHub:
https://github.com/jrg94/sample-programs
#>
param
(
  [Parameter(Mandatory = $true,
             Position = 0)]
  [ValidateNotNullOrEmpty()]
  [string]$Args
)

$InputArray = $Args.ToCharArray()
[System.Array]::Reverse($InputArray)
$ReversedString = -join($InputArray)

Write-Host $ReversedString
