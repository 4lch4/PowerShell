<#
    .SYNOPSIS
        Create a new Node module using some default values.
    
    .DESCRIPTION
        Creates a new Node module using some default values that I prefer in each of my projects. Such as license type, the license file itself, etc. Returns true or false if the module was created without problem. If false is returned, there should also be some more information regarding *why* it failed.
    
    .PARAMETER ModuleName
        A description of the ModuleName parameter.
    
    .PARAMETER ModulePath
        The path of where you would like the module to be created. If none is provided, the current directory is used.
    
    .NOTES
        ===========================================================================
        Created on:   	5/22/2018 @ 19:30
        Created by:   	Alcha
        Organization: 	HassleFree Solutions, LLC
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
# SIG # Begin signature block
# MIIPAwYJKoZIhvcNAQcCoIIO9DCCDvACAQExCzAJBgUrDgMCGgUAMGkGCisGAQQB
# gjcCAQSgWzBZMDQGCisGAQQBgjcCAR4wJgIDAQAABBAfzDtgWUsITrck0sYpfvNR
# AgEAAgEAAgEAAgEAAgEAMCEwCQYFKw4DAhoFAAQU7oQSGTPAZInCiF4czDgZ1qlg
# ORKgggqMMIIBzTCCATagAwIBAgIQYeG/usf7BJlL3IZJ43LhJjANBgkqhkiG9w0B
# AQsFADAlMSMwIQYDVQQDHhoATABJAE4AQwBMAEUAUgBcAEEAbABjAGgAYTAeFw0x
# NzEyMTYwNjE4MDlaFw0xODEyMTYxMjE4MDlaMCUxIzAhBgNVBAMeGgBMAEkATgBD
# AEwARQBSAFwAQQBsAGMAaABhMIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQCx
# iM3K0iayVn4aOYtg1m4Wj1OecPOy3LS/psofYoEK0thlaJ8FeH5l5W26zmf6x9FL
# IwK2yCFqa9EsD9f8CmTVChNClUxZdSA05+1bNDer1HMTdJ28E3qupFWvi0uA7Tzh
# Gu5wKJ9FEYBHQaJH4VBfiguskUVi9TQ8SuZUWwphoQIDAQABMA0GCSqGSIb3DQEB
# CwUAA4GBAG+ijOXFtae+yY2NMYYwNR8YpgDeAcCXUXZOYWlEnS0f6GVyAdUhejg6
# gZrWgg+PDcGXA2LGFZS2oAJOShmJynv+AGo26K7Io3EMmwS9+zAwJz8TlmN9IY1A
# EYKbVknIvT6gpMmJCcSla7slBNGarBOcvCzkqoMDtZ4ioJVwDTLzMIIEFDCCAvyg
# AwIBAgILBAAAAAABL07hUtcwDQYJKoZIhvcNAQEFBQAwVzELMAkGA1UEBhMCQkUx
# GTAXBgNVBAoTEEdsb2JhbFNpZ24gbnYtc2ExEDAOBgNVBAsTB1Jvb3QgQ0ExGzAZ
# BgNVBAMTEkdsb2JhbFNpZ24gUm9vdCBDQTAeFw0xMTA0MTMxMDAwMDBaFw0yODAx
# MjgxMjAwMDBaMFIxCzAJBgNVBAYTAkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52
# LXNhMSgwJgYDVQQDEx9HbG9iYWxTaWduIFRpbWVzdGFtcGluZyBDQSAtIEcyMIIB
# IjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAlO9l+LVXn6BTDTQG6wkft0cY
# asvwW+T/J6U00feJGr+esc0SQW5m1IGghYtkWkYvmaCNd7HivFzdItdqZ9C76Mp0
# 3otPDbBS5ZBb60cO8eefnAuQZT4XljBFcm05oRc2yrmgjBtPCBn2gTGtYRakYua0
# QJ7D/PuV9vu1LpWBmODvxevYAll4d/eq41JrUJEpxfz3zZNl0mBhIvIG+zLdFlH6
# Dv2KMPAXCae78wSuq5DnbN96qfTvxGInX2+ZbTh0qhGL2t/HFEzphbLswn1KJo/n
# Vrqm4M+SU4B09APsaLJgvIQgAIMboe60dAXBKY5i0Eex+vBTzBj5Ljv5cH60JQID
# AQABo4HlMIHiMA4GA1UdDwEB/wQEAwIBBjASBgNVHRMBAf8ECDAGAQH/AgEAMB0G
# A1UdDgQWBBRG2D7/3OO+/4Pm9IWbsN1q1hSpwTBHBgNVHSAEQDA+MDwGBFUdIAAw
# NDAyBggrBgEFBQcCARYmaHR0cHM6Ly93d3cuZ2xvYmFsc2lnbi5jb20vcmVwb3Np
# dG9yeS8wMwYDVR0fBCwwKjAooCagJIYiaHR0cDovL2NybC5nbG9iYWxzaWduLm5l
# dC9yb290LmNybDAfBgNVHSMEGDAWgBRge2YaRQ2XyolQL30EzTSo//z9SzANBgkq
# hkiG9w0BAQUFAAOCAQEATl5WkB5GtNlJMfO7FzkoG8IW3f1B3AkFBJtvsqKa1pku
# QJkAVbXqP6UgdtOGNNQXzFU6x4Lu76i6vNgGnxVQ380We1I6AtcZGv2v8Hhc4EvF
# GN86JB7arLipWAQCBzDbsBJe/jG+8ARI9PBw+DpeVoPPPfsNvPTF7ZedudTbpSeE
# 4zibi6c1hkQgpDttpGoLoYP9KOva7yj2zIhd+wo7AKvgIeviLzVsD440RZfroveZ
# MzV+y5qKu0VN5z+fwtmK+mWybsd+Zf/okuEsMaL3sCc2SI8mbzvuTXYfecPlf5Y1
# vC0OzAGwjn//UYCAp5LUs0RGZIyHTxZjBzFLY7Df8zCCBJ8wggOHoAMCAQICEhEh
# 1pmnZJc+8fhCfukZzFNBFDANBgkqhkiG9w0BAQUFADBSMQswCQYDVQQGEwJCRTEZ
# MBcGA1UEChMQR2xvYmFsU2lnbiBudi1zYTEoMCYGA1UEAxMfR2xvYmFsU2lnbiBU
# aW1lc3RhbXBpbmcgQ0EgLSBHMjAeFw0xNjA1MjQwMDAwMDBaFw0yNzA2MjQwMDAw
# MDBaMGAxCzAJBgNVBAYTAlNHMR8wHQYDVQQKExZHTU8gR2xvYmFsU2lnbiBQdGUg
# THRkMTAwLgYDVQQDEydHbG9iYWxTaWduIFRTQSBmb3IgTVMgQXV0aGVudGljb2Rl
# IC0gRzIwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQCwF66i07YEMFYe
# WA+x7VWk1lTL2PZzOuxdXqsl/Tal+oTDYUDFRrVZUjtCoi5fE2IQqVvmc9aSJbF9
# I+MGs4c6DkPw1wCJU6IRMVIobl1AcjzyCXenSZKX1GyQoHan/bjcs53yB2AsT1iY
# AGvTFVTg+t3/gCxfGKaY/9Sr7KFFWbIub2Jd4NkZrItXnKgmK9kXpRDSRwgacCwz
# i39ogCq1oV1r3Y0CAikDqnw3u7spTj1Tk7Om+o/SWJMVTLktq4CjoyX7r/cIZLB6
# RA9cENdfYTeqTmvT0lMlnYJz+iz5crCpGTkqUPqp0Dw6yuhb7/VfUfT5CtmXNd5q
# heYjBEKvAgMBAAGjggFfMIIBWzAOBgNVHQ8BAf8EBAMCB4AwTAYDVR0gBEUwQzBB
# BgkrBgEEAaAyAR4wNDAyBggrBgEFBQcCARYmaHR0cHM6Ly93d3cuZ2xvYmFsc2ln
# bi5jb20vcmVwb3NpdG9yeS8wCQYDVR0TBAIwADAWBgNVHSUBAf8EDDAKBggrBgEF
# BQcDCDBCBgNVHR8EOzA5MDegNaAzhjFodHRwOi8vY3JsLmdsb2JhbHNpZ24uY29t
# L2dzL2dzdGltZXN0YW1waW5nZzIuY3JsMFQGCCsGAQUFBwEBBEgwRjBEBggrBgEF
# BQcwAoY4aHR0cDovL3NlY3VyZS5nbG9iYWxzaWduLmNvbS9jYWNlcnQvZ3N0aW1l
# c3RhbXBpbmdnMi5jcnQwHQYDVR0OBBYEFNSihEo4Whh/uk8wUL2d1XqH1gn3MB8G
# A1UdIwQYMBaAFEbYPv/c477/g+b0hZuw3WrWFKnBMA0GCSqGSIb3DQEBBQUAA4IB
# AQCPqRqRbQSmNyAOg5beI9Nrbh9u3WQ9aCEitfhHNmmO4aVFxySiIrcpCcxUWq7G
# vM1jjrM9UEjltMyuzZKNniiLE0oRqr2j79OyNvy0oXK/bZdjeYxEvHAvfvO83YJT
# qxr26/ocl7y2N5ykHDC8q7wtRzbfkiAD6HHGWPZ1BZo08AtZWoJENKqA5C+E9kdd
# lsm2ysqdt6a65FDT1De4uiAO0NOSKlvEWbuhbds8zkSdwTgqreONvc0JdxoQvmcK
# AjZkiLmzGybu555gxEaovGEzbM9OuZy5avCfN/61PU+a003/3iCOTpem/Z8JvE3K
# GHbJsE2FUPKA0h0G9VgEB7EYMYID4TCCA90CAQEwOTAlMSMwIQYDVQQDHhoATABJ
# AE4AQwBMAEUAUgBcAEEAbABjAGgAYQIQYeG/usf7BJlL3IZJ43LhJjAJBgUrDgMC
# GgUAoFowGAYKKwYBBAGCNwIBDDEKMAigAoAAoQKAADAZBgkqhkiG9w0BCQMxDAYK
# KwYBBAGCNwIBBDAjBgkqhkiG9w0BCQQxFgQU9pZ3b9IjZ7pQJoo/Od61FRUoTcgw
# DQYJKoZIhvcNAQEBBQAEgYBJ5Jp2VyTfqmfxuZH/zapPhyyE2lrYANKyCV1/xz7c
# xIXcxY8J+qfEohPfsv0aUNo5sEkV3cqYdlBNlupKFUK9NSbdDw1OMGbNmFd3nC/0
# m1/RgbGHtzOiO+JPRF/uhLFPh7LJN9Wyy666ZQGB+jOw437SKNAwehuhWRwuE1vS
# h6GCAqIwggKeBgkqhkiG9w0BCQYxggKPMIICiwIBATBoMFIxCzAJBgNVBAYTAkJF
# MRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMSgwJgYDVQQDEx9HbG9iYWxTaWdu
# IFRpbWVzdGFtcGluZyBDQSAtIEcyAhIRIdaZp2SXPvH4Qn7pGcxTQRQwCQYFKw4D
# AhoFAKCB/TAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEP
# Fw0xODA1MjMwMTA5MThaMCMGCSqGSIb3DQEJBDEWBBSM7PUGS/lG4T4vuGYgRRVB
# FMxl6TCBnQYLKoZIhvcNAQkQAgwxgY0wgYowgYcwgYQEFGO4L6th9YOQlpUFCwAk
# nFApM+x5MGwwVqRUMFIxCzAJBgNVBAYTAkJFMRkwFwYDVQQKExBHbG9iYWxTaWdu
# IG52LXNhMSgwJgYDVQQDEx9HbG9iYWxTaWduIFRpbWVzdGFtcGluZyBDQSAtIEcy
# AhIRIdaZp2SXPvH4Qn7pGcxTQRQwDQYJKoZIhvcNAQEBBQAEggEAcEFbaMf22vFK
# sZk8+ksgTQemh92d795rCWo2oEBgITpq/iDsuEL9ixEA3WslQiFYZ++b2dQb0h7h
# mStGsc5hdtGsHBkIBVh5EiDZnV80GsO019oihFM94UcXO11hKvvz8juNIljpdiWN
# HapQDa3PJb151Q9USsRZh8HvE76jiQ19h8A1pJPDUlONIW0HchbEmT9usotxWC1+
# 0H2OmcQVLeYTzSYqtTq6o8gwhTMXYBodDJejNe3Yo5uNFSzeodnmoOSy68I3KefF
# ROC0Ws4af6IUeGQI9aExQNdu/cZZX38YQt9+aEXBzz1Y0d2V+XxkEtYtQxUQ8mgC
# lGXG1LYtQw==
# SIG # End signature block
