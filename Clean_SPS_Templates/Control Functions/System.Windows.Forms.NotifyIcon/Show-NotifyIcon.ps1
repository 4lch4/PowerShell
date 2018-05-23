function Show-NotifyIcon
{
<#
	.SYNOPSIS
		Displays a NotifyIcon's balloon tip message in the taskbar's notification area.
	
	.DESCRIPTION
		Displays a NotifyIcon's a balloon tip message in the taskbar's notification area.
		
	.PARAMETER NotifyIcon
     	The NotifyIcon control that will be displayed.
	
	.PARAMETER BalloonTipText
     	Sets the text to display in the balloon tip.
	
	.PARAMETER BalloonTipTitle
		Sets the Title to display in the balloon tip.
	
	.PARAMETER BalloonTipIcon	
		The icon to display in the ballon tip.
	
	.PARAMETER Timeout	
		The time the ToolTip Balloon will remain visible in milliseconds. 
		Default: 0 - Uses windows default.
#>
	 param(
	  [Parameter(Mandatory = $true, Position = 0)]
	  [ValidateNotNull()]
	  [System.Windows.Forms.NotifyIcon]$NotifyIcon,
	  [Parameter(Mandatory = $true, Position = 1)]
	  [ValidateNotNullOrEmpty()]
	  [String]$BalloonTipText,
	  [Parameter(Position = 2)]
	  [String]$BalloonTipTitle = '',
	  [Parameter(Position = 3)]
	  [System.Windows.Forms.ToolTipIcon]$BalloonTipIcon = 'None',
	  [Parameter(Position = 4)]
	  [int]$Timeout = 0
 	)
	
	if($null -eq $NotifyIcon.Icon)
	{
		#Set a Default Icon otherwise the balloon will not show
		$NotifyIcon.Icon = [System.Drawing.Icon]::ExtractAssociatedIcon([System.Windows.Forms.Application]::ExecutablePath)
	}
	
	$NotifyIcon.ShowBalloonTip($Timeout, $BalloonTipTitle, $BalloonTipText, $BalloonTipIcon)
}

