<#
.SYNOPSIS
  Exports a list of all currently installed Visual Studio Code (VSCode)
  extensions and outputs them to a text file.

.DESCRIPTION
  By analayzing the default install location for VSCode
  (%USERPROFILE%\.vscode\extensions), generate a list of all extension names and
  output them to a text file at the location provided to the -OutFile parameter
  (if one was provided). If no -OutFile parameter is provided, the output text
  file is stored in the same directory the script is called from.

.EXAMPLE
  .\Export-VSCodeExtensions.ps1 -OutFile .\Extensions_List.txt
#>

param (
  # Specifies a path to one or more locations.
  [Parameter(Mandatory=$true,
             Position=0,
             ParameterSetName="FileData",
             ValueFromPipeline=$true,
             ValueFromPipelineByPropertyName=$true,
             HelpMessage="Path to one or more locations.")]
  [Alias("Path", "OutPath")]
  [ValidateNotNullOrEmpty()]
  [string[]]
  $OutFile
)

Write-Host $OutFile
