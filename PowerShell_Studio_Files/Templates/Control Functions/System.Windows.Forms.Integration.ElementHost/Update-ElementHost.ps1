function Update-ElementHost
{
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
	
	param
	(
		[Parameter(Mandatory = $true)]
		[ValidateNotNull()]
		[System.Windows.Forms.Integration.ElementHost]
		$Elementhost,
		[Parameter(Mandatory = $true)]
		[ValidateNotNull()]
		[Xml]
		$XAML
	)
	
	$reader = New-Object System.Xml.XmlNodeReader $XAML
	
	if (-not $reader)
	{
		return
	}
	
	$WPFControl = [Windows.Markup.XamlReader]::Load($reader)
	$elementhost1.Child = $WPFControl
	
	return $WPFControl
}
