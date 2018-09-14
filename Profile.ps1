. $PSScriptRoot\Server_Functions.ps1
. $PSScriptRoot\Private-Environment-Variables.ps1

if (Get-IsAdmin) {
  Write-Verbose "Admin shell detected, don't get weather info to save time."
} else {
  . $PSScriptRoot\Get-Weather.ps1
  Get-Weather -City 'Fort%20Smith' -Country 'USA'
}

function Get-ServerList() {
  Import-Clixml -Path $PSScriptRoot\Saved_Servers.xml
}

if (Get-Module -ListAvailable -Name Gamgee) { Import-Module -Name Gamgee -Global }

function global:Prompt {
  # Set the title the current date and time
  $Host.UI.RawUI.WindowTitle = (Get-Date -UFormat '%y/%m/%d %R').Tostring()

  Write-Host "$env:USERNAME@$env:COMPUTERNAME " -ForegroundColor Cyan -NoNewline
  Write-Host (Get-Location) -ForegroundColor Green
  Write-Host '[' -NoNewline
  Write-Host (Get-Date -UFormat '%T') -ForegroundColor Yellow -NoNewline
  Write-Host ']:' -NoNewline
  return "$ "
}


function Open-ProjectFolder () {
  [CmdletBinding()]
  [Alias('projects', 'Open-Projects')]
  param ()

  Set-Location "D:\Development\Projects" 
}

function Format-Json([Parameter(Mandatory, ValueFromPipeline)][String]$json) {
  $json | ConvertFrom-Json | ConvertTo-Json
}

function gimp() {
  param (
    $Version = '2.8'
  )
  if (Get-Command "gimp-$Version.exe" -ErrorAction SilentlyContinue) {
    gimp-2.8.exe
  }
  else {
    Write-Error "The previously stored gimp executable is no longer available. Please verify the version number is correct."
  }
}