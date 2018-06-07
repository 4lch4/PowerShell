<#
.SYNOPSIS
	Loads XAML into a ElementHost

.DESCRIPTION
	Loads XAML into a ElementHost, which then displays the WPF control.
	
	.RETURNS
	Returns the WPF control

.PARAMETER ElementHost
	The ElementHost control to load the XAML.

.PARAMETER XAML
	The XAML to create the WPF Control

.EXAMPLE
	Update-ElementHost -Elementhost $elementhost1 -XAML $xaml | Out-Null

.NOTES
	Additional information about the function.
#>
function Update-ElementHost {
  param (
    [Parameter(Mandatory = $true)]
    [ValidateNotNull()]
    [System.Windows.Forms.Integration.ElementHost]$Elementhost,
    
    [Parameter(Mandatory = $true)]
    [ValidateNotNull()]
    [Xml]$XAML
  )
  
  $Reader = New-Object System.Xml.XmlNodeReader $XAML
  
  if (-not $Reader) {
    return
  }
  
  $WPFControl = [Windows.Markup.XamlReader]::Load($Reader)
  $ElementHost1.Child = $WPFControl
  
  return $WPFControl
}
