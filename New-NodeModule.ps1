param (
  # Specifies a path to one or more locations. Wildcards are permitted.
  [Parameter(Mandatory = $true,
    Position = 0,
    ValueFromPipeline = $true,
    ValueFromPipelineByPropertyName = $true,
    HelpMessage = "Path to one or more locations.")]
  [ValidateNotNullOrEmpty()]
  [SupportsWildcards()]
  [string[]]
  $ModulePath
)

Write-Output $ModulePath