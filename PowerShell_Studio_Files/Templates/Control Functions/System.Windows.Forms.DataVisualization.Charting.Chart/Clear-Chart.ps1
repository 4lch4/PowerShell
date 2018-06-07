function Clear-Chart
{
<#
	.SYNOPSIS
		This function clears the contents of the chart

	.DESCRIPTION
		Use the function to remove contents from the chart control

	.PARAMETER  ChartControl
		The Chart Control to clear

	.PARAMETER  LeaveSingleChart
		Leaves the first chart and removes all others from the control
	
	.LINK
		http://www.sapien.com/blog/2011/05/05/primalforms-2011-designing-charts-for-powershell/
#>
	Param (	
	[ValidateNotNull()]
	[Parameter(Position=1,Mandatory=$true)]
  	[System.Windows.Forms.DataVisualization.Charting.Chart]$ChartControl
	,
	[Parameter(Position=2, Mandatory=$false)]
	[Switch]$LeaveSingleChart
	)
	
	$count = 0	
	if($LeaveSingleChart)
	{
		$count = 1
	}
	
	while($ChartControl.Series.Count -gt $count)
	{
		$ChartControl.Series.RemoveAt($ChartControl.Series.Count - 1)
	}
	
	while($ChartControl.ChartAreas.Count -gt $count)
	{
		$ChartControl.ChartAreas.RemoveAt($ChartControl.ChartAreas.Count - 1)
	}
	
	while($ChartControl.Titles.Count -gt $count)
	{
		$ChartControl.Titles.RemoveAt($ChartControl.Titles.Count - 1)
	}
	
	if($ChartControl.Series.Count -gt 0)
	{
		$ChartControl.Series[0].Points.Clear()
	}
}