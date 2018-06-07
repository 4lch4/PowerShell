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
function Clear-Chart {
  param (
    [ValidateNotNull()]
    [Parameter(Position = 1, Mandatory = $true)]
    [System.Windows.Forms.DataVisualization.Charting.Chart]$ChartControl
     ,
    
    [Parameter(Position = 2, Mandatory = $false)]
    [Switch]$LeaveSingleChart
  )
  
  $Count = 0
  if ($LeaveSingleChart) {
    $Count = 1
  }
  
  while ($ChartControl.Series.Count -gt $Count) {
    $ChartControl.Series.RemoveAt($ChartControl.Series.Count - 1)
  }
  
  while ($ChartControl.ChartAreas.Count -gt $Count) {
    $ChartControl.ChartAreas.RemoveAt($ChartControl.ChartAreas.Count - 1)
  }
  
  while ($ChartControl.Titles.Count -gt $Count) {
    $ChartControl.Titles.RemoveAt($ChartControl.Titles.Count - 1)
  }
  
  if ($ChartControl.Series.Count -gt 0) {
    $ChartControl.Series[0].Points.Clear()
  }
}