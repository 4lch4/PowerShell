﻿<#	
.NOTES
===============================================================================
 Created on:   	%Date% @ %Time%
 Created by:   	%Username%
 Organization: 	%Company%
 Filename:     	%FileName%
===============================================================================
.DESCRIPTION
	The Test-Module.ps1 script lets you test the functions and other features of
your module in your PowerShell Studio module project. It's part of your project,
but it is not included in your module.

	In this test script, import the module (be careful to import the correct version)
and write commands that test the module features. You can include Pester
tests, too.

	To run the script, click Run or Run in Console. Or, when working on any file
in the project, click Home\Run or Home\Run in Console, or in the Project pane, 
right-click the project name, and then click Run Project.
#>


#Explicitly import the module for testing
Import-Module '%ProjectName%'

#Run each module function
Write-HelloWorld

#Sample Pester Test
#Describe "Test %ProjectName%" {
#	It "tests Write-HellowWorld" {
#		Write-HelloWorld | Should BeExactly "Hello World"
#	}	
#}