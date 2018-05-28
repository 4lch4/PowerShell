# ===========================================================================
# Created on:   5/22/2018 @ 19:30
# Created by:   Alcha
# Organization: HassleFree Solutions, LLC.
# Filename:     New-NodeModule.ps1
# ===========================================================================

<#
.SYNOPSIS
    Creates a new Node.js module using some preferred default values.

.DESCRIPTION
    Creates a new Node module using some default values that I prefer in each of
my projects. Such as license type, the license file itself, etc. Returns true or
false if the module was created without problem. If false is returned, there
should also be some more information regarding *why* it failed.

.PARAMETER ModuleName
    The name of the new module you wish to create.

.PARAMETER ModulePath
    The path of where you would like the module to be created. If none is
provided, D:\Development\Projects\NodeJS_Packages is used.

.PARAMETER OpenInVSCode
    A switch parameter indicating if you'd like to open the newly created module
in Visual Studio Code. Defaults to $true.

.EXAMPLE
    PS C:\> New-NodeModule -ModuleName 'Test Module 1' -ModulePath C:\Temp

This will create a new module called Test Module 1 and place the new files for
it in C:\Temp\Test Module 1\.

.EXAMPLE
    PS C:\> New-NodeModule outside-cli C:\Dev\node_packages $false

This will create a new module called outside-cli so long as there isn't already
a file or directory with the name in C:\Dev\node_packages\. Adds all new files
to the newly created C:\Dev\node_packages\outside-cli directory, and on
completion, does *not* open the directory in Visual Studio Code.

.EXAMPLE
    PS C:\> New-NodeModule temp-cli-test -Open $False

This will create a new module called temp-cli-test so long as there isn't
already a file or directory with the name in D:\Devel..\Projects\NodeJS_Packages
and adds all new files to the newly created temp-cli-test directory, and on
completion, does *not* open the directory in Visual Studio Code.

.NOTES
    The easiest way to add this to your profile is to copy this file to your
WindowsPowerShell profile path ($ENV:HOMEPATH\Documents\WindowsPowerShell) and
then add the following line somewhere in your Profile.ps1 file (if you're unsure
what this is, see http://bit.ly/poshprofiles):

. $ENV:HOMEDRIVE\$ENV:HOMEPATH\Documents\WindowsPowerShell\New-NodeModule.ps1
#>
function New-NodeModule {
  [CmdletBinding()]
  [Alias('nodemod', 'new-nodemod', 'newmod', 'newmodule', 'newnpm')]
  param (
    [Parameter(Mandatory = $true,
               Position = 1,
               HelpMessage = 'The name of the module to create.')]
    [ValidateScript({
        if ($_ -match '^(?:@[a-z0-9-~][a-z0-9-._~]*/)?[a-z0-9-~][a-z0-9-._~]*$') {
          return $true
        } else {
          throw "Your module name must match the following pattern: ^(?:@[a-z0-9-~][a-z0-9-._~]*/)?[a-z0-9-~][a-z0-9-._~]*`$`nSee https://docs.npmjs.com/files/package.json#name for more info."
        }
      })]
    [Alias('Name', 'Module')]
    [String]$ModuleName,
    
    [Parameter(Mandatory = $false,
               Position = 2,
               HelpMessage = 'The path where the module is created.')]
    [ValidateScript({
        if (Test-Path $_) {
          return $true
        } else {
          throw 'The provided path does not exist.'
        }
      })]
    [Alias('Path')]
    [System.IO.FileInfo]$ModulePath = 'D:\Development\Projects\NodeJS_Packages',
    
    [Parameter(Mandatory = $false,
               Position = 3,
               HelpMessage = 'Do you wish to open this module in VSCode after creation?')]
    [Alias('Open')]
    [bool]$OpenInVSCode = $true
  )
  
  $AuthorInfo = Get-AuthorInfo
  $ScriptsInfo = Get-ScriptsInfo
  $DevDependencies = Get-DevDependencies
  $PackageInfo = Get-PackageInfo -ModuleName $ModuleName
  
  $FullModulePath = Join-Path -Path $ModulePath -ChildPath $ModuleName
  $PackageJson = Join-Path -Path $FullModulePath -ChildPath 'package.json'
  
  if (Test-Path -Path $FullModulePath) {
    # There is a folder at the provided path with the same name as the $ModuleName
    throw 'A folder with the same name exists at the provided path. Please choose a different module name or path.'
  } else {
    # Create directory for the module
    Write-Debug 'Creating module directory...'
    New-Item -Path $FullModulePath -ItemType Directory | Out-Null
    
    # Create the new package.json file
    Write-Debug 'Creating modules package.json...'
    New-Item -Path $PackageJson -ItemType File | Out-Null
    
    # Create the main index.js for most code logic
    Write-Debug 'Creating modules index.js...'
    New-Item -Path $FullModulePath\index.js -ItemType File | Out-Null
    
    # Create the LICENSE file that will contain the MIT License
    Write-Debug 'Creating modules empty LICENSE file...'
    New-Item -Path $FullModulePath\LICENSE -ItemType File | Out-Null
    
    # Convert the $PackageInfo to JSON
    Write-Debug 'Converting package info to JSON...'
    $JsonData = ConvertTo-Json -InputObject $PackageInfo
    
    # Store all package info to the module's package.json
    Write-Debug 'Adding package info to package.json...'
    Out-File -FilePath $PackageJson -InputObject $JsonData
    
    # Add the MIT License text to the LICENSE file
    Write-Debug 'Adding MIT license content to LICENSE file...'
    Out-File -FilePath $FullModulePath\LICENSE -InputObject $MITLicense
    
    Write-Verbose "The $ModuleName module has been successfuly created."
    
    # Open the folder containing the module as long as $OpenInVSCode is true and
    # the code command is available
    if ($OpenInVSCode -and (Get-Command code -ErrorAction SilentlyContinue)) {
      Write-Debug 'Opening the module directory in Visual Studio Code...'
      code $FullModulePath
    }
  }
}

function Get-AuthorInfo() {
  return @{
    name = 'Alcha'
    email = 'alcha@hasslefree.solutions'
    url = 'https://hasslefree.solutions'
  }
}

function Get-ScriptsInfo() {
  return @{
    start = 'node ./index.js'
    test = 'jest'
  }
}

function Get-DevDependencies() {
  return @{
    jest = ''
    standard = ''
  }
}

function Get-PackageInfo() {
  param (
    [parameter(Mandatory = $true)]
    [String]$ModuleName
  )
  
  return @{
    name = $ModuleName.ToLower()
    displayName = $ModuleName.Substring(0, 1).ToUpper() + $ModuleName.Substring(1).toLower()
    version = '0.0.1'
    description = 'This is a placeholder description to be updated at a later date.'
    main = 'index.js'
    license = 'MIT'
    scripts = $ScriptsInfo
    author = $AuthorInfo
    devDependencies = $DevDependencies
  }
}

$MITLicense = @"
Copyright $(Get-Date -UFormat "%Y") HassleFree Solutions, LLC.

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
"@