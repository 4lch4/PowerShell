<#
    .SYNOPSIS
        Create a new Node module using some default values.
    
    .DESCRIPTION
        Creates a new Node module using some default values that I prefer in each of my projects. Such as license type, the license file itself, etc. Returns true or false if the module was created without problem. If false is returned, there should also be some more information regarding *why* it failed.
    
    .PARAMETER ModuleName
        The name of the new module you wish to create.
    
    .PARAMETER ModulePath
        The path of where you would like the module to be created. If none is provided, the current directory is used.

    .OUTPUTS
        Returns a boolean that represents whether or not the operation was successful. If it fails,
    more information is provided.
    
    .NOTES
        ===========================================================================
        Created on:   	5/22/2018 @ 19:30
        Created by:   	Alcha
        Organization: 	HassleFree Solutions, LLC.
        Filename:     	New-NodeModule.ps1
        ===========================================================================
#>
[CmdletBinding()]
[OutputType([bool])]
param
(
    [Parameter(ParameterSetName = 'ModuleInfo',
               Mandatory = $true,
               Position = 0)]
    [String]$ModuleName,
    
    [Parameter(ParameterSetName = 'ModuleInfo',
               ValueFromPipeline = $true,
               ValueFromPipelineByPropertyName = $true,
               ValueFromRemainingArguments = $true,
               Position = 1,
               HelpMessage = 'The path where the module is created.')]
    [SupportsWildcards()]
    [ValidateScript({
        if (-not ($_ | Test-path)) {
            throw 'File or folder does not exist.'
        }
    })]
    [Alias('Path')]
    [System.IO.FileInfo]$ModulePath = $PSScriptRoot
)

Begin {
    
}
Process {
    switch ($PsCmdlet.ParameterSetName) {
        'ModuleInfo' {
            #TODO: Place script here
            break
        }
    }
    
}
End {
    
}
