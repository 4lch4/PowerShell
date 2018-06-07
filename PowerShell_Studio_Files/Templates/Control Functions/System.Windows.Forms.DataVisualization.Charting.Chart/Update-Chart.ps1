<#
.SYNOPSIS
	This functions helps you plot points on a chart

.DESCRIPTION
	Use the function to plot points on a chart or add more charts to a chart control

.PARAMETER ChartControl
	The Chart Control you when to add points to

.PARAMETER XPoints
	Set the X Axis Points. These can be strings or numerical values.

.PARAMETER YPoints
	Set the Y Axis Points. These can be strings or numerical values.

.PARAMETER XTitle
	Set the Title for the X Axis.

.PARAMETER YTitle
	Set the Title for the Y Axis.

.PARAMETER Title
	Set the Title for the chart.

.PARAMETER ChartType
	Set the Style of the chart. See System.Windows.Forms.DataVisualization.Charting.SeriesChartType Enum

.PARAMETER SeriesIndex
	Set the settings of a particular Series and corresponding ChartArea

.PARAMETER TitleIndex
	Set the settings of a particular Title

.PARAMETER SeriesName
	Set the settings of a particular Series using its name and corresponding ChartArea.
	The Series will be created if not found.
	If SeriesIndex is set, it will replace the Series' name if the Series does not exist

.PARAMETER Enable3D
	The chart will be rendered in 3D.

.PARAMETER Disable3D
	The chart will be rendered in 2D.

.PARAMETER AppendNew
	When this switch is used, a new ChartArea is added to Chart Control.

.NOTES
	Additional information about the function.

.LINK
	http://www.sapien.com/blog/2011/05/05/primalforms-2011-designing-charts-for-powershell/
#>
function Update-Chart {
  param (
    [Parameter(Mandatory = $true,
               Position = 1)]
    [ValidateNotNull()]
    [System.Windows.Forms.DataVisualization.Charting.Chart]$ChartControl,
    
    [Parameter(Mandatory = $true,
               Position = 2)]
    [ValidateNotNull()]
    $XPoints,
    
    [Parameter(Mandatory = $true,
               Position = 3)]
    $YPoints,
    
    [Parameter(Mandatory = $false,
               Position = 4)]
    [string]$XTitle,
    
    [Parameter(Mandatory = $false,
               Position = 5)]
    [string]$YTitle,
    
    [Parameter(Mandatory = $false,
               Position = 6)]
    [string]$Title,
    
    [Parameter(Mandatory = $false,
               Position = 7)]
    [System.Windows.Forms.DataVisualization.Charting.SeriesChartType]$ChartType,
    
    [Parameter(Mandatory = $false,
               Position = 8)]
    $SeriesIndex = '-1',
    
    [Parameter(Mandatory = $false,
               Position = 9)]
    $TitleIndex = '0',
    
    [Parameter(Mandatory = $false)]
    [string]$SeriesName = $null,
    
    [switch]$Enable3D,
    
    [switch]$Disable3D,
    
    [switch]$AppendNew
  )
  
  $ChartAreaIndex = 0
  if ($AppendNew) {
    $Name = "ChartArea " + ($ChartControl.ChartAreas.Count + 1).ToString();
    $ChartArea = $ChartControl.ChartAreas.Add($Name)
    $ChartAreaIndex = $ChartControl.ChartAreas.Count - 1
    
    $Name = "Series " + ($ChartControl.Series.Count + 1).ToString();
    $Series = $ChartControl.Series.Add($Name)
    $SeriesIndex = $ChartControl.Series.Count - 1
    
    $Series.ChartArea = $ChartArea.Name
    
    if ($Title) {
      $Name = "Title " + ($ChartControl.Titles.Count + 1).ToString();
      $TitleObj = $ChartControl.Titles.Add($Title)
      $TitleIndex = $ChartControl.Titles.Count - 1
      $TitleObj.DockedToChartArea = $ChartArea.Name
      $TitleObj.IsDockedInsideChartArea = $false
    }
  } else {
    if ($ChartControl.ChartAreas.Count -eq 0) {
      $Name = "ChartArea " + ($ChartControl.ChartAreas.Count + 1).ToString();
      [void]$ChartControl.ChartAreas.Add($Name)
      $ChartAreaIndex = $ChartControl.ChartAreas.Count - 1
    }
    
    if ($ChartControl.Series.Count -eq 0) {
      if (-not $SeriesName) {
        $SeriesName = "Series " + ($ChartControl.Series.Count + 1).ToString();
      }
      
      $Series = $ChartControl.Series.Add($SeriesName)
      $SeriesIndex = $ChartControl.Series.Count - 1
      $Series.ChartArea = $ChartControl.ChartAreas[$ChartAreaIndex].Name
    } elseif ($SeriesName) {
      $Series = $ChartControl.Series.FindByName($SeriesName)
      
      if ($null -eq $Series) {
        if (($SeriesIndex -gt -1) -and ($SeriesIndex -lt $ChartControl.Series.Count)) {
          $Series = $ChartControl.Series[$SeriesIndex]
          $Series.Name = $SeriesName
        } else {
          $Series = $ChartControl.Series.Add($SeriesName)
          $SeriesIndex = $ChartControl.Series.Count - 1
        }
        
        $Series.ChartArea = $ChartControl.ChartAreas[$ChartAreaIndex].Name
      } else {
        $SeriesIndex = $ChartControl.Series.IndexOf($Series)
        $ChartAreaIndex = $ChartControl.ChartAreas.IndexOf($Series.ChartArea)
      }
    }
  }
  
  if (($SeriesIndex -lt 0) -or ($SeriesIndex -ge $ChartControl.Series.Count)) {
    $SeriesIndex = 0
  }
  
  $Series = $ChartControl.Series[$SeriesIndex]
  $Series.Points.Clear()
  $ChartArea = $ChartControl.ChartAreas[$Series.ChartArea]
  
  if ($Enable3D) {
    $ChartArea.Area3DStyle.Enable3D = $true
  } elseif ($Disable3D) {
    $ChartArea.Area3DStyle.Enable3D = $false
  }
  
  if ($Title) {
    if ($ChartControl.Titles.Count -eq 0) {
      #$name = "Title " + ($ChartControl.Titles.Count + 1).ToString();
      $TitleObj = $ChartControl.Titles.Add($Title)
      $TitleIndex = $ChartControl.Titles.Count - 1
      $TitleObj.DockedToChartArea = $ChartArea.Name
      $TitleObj.IsDockedInsideChartArea = $false
    }
    
    $ChartControl.Titles[$TitleIndex].Text = $Title
  }
  
  if ($ChartType) {
    $Series.ChartType = $ChartType
  }
  
  if ($XTitle) {
    $ChartArea.AxisX.Title = $XTitle
  }
  
  if ($YTitle) {
    $ChartArea.AxisY.Title = $YTitle
  }
  
  if ($XPoints -isnot [Array] -or $XPoints -isnot [System.Collections.IEnumerable]) {
    $Array = New-Object System.Collections.ArrayList
    $Array.Add($XPoints)
    $XPoints = $Array
  }
  
  if ($YPoints -isnot [Array] -or $YPoints -isnot [System.Collections.IEnumerable]) {
    $Array = New-Object System.Collections.ArrayList
    $Array.Add($YPoints)
    $YPoints = $Array
  }
  
  $Series.Points.DataBindXY($XPoints, $YPoints)
}
