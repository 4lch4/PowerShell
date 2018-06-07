<#
.SYNOPSIS
	This functions helps you load items into a DataGridView.

.DESCRIPTION
	Use this function to dynamically load items into the DataGridView control.

.PARAMETER  DataGridView
	The DataGridView control you want to add items to.

.PARAMETER  Item
	The object or objects you wish to load into the DataGridView's items collection.
 
.PARAMETER  DataMember
	Sets the name of the list or table in the data source for which the DataGridView is displaying data.

.PARAMETER AutoSizeColumns
    Resizes DataGridView control's columns after loading the items.
#>
function Update-DataGridView {
  param (
    [ValidateNotNull()]
    [Parameter(Mandatory = $true)]
    [System.Windows.Forms.DataGridView]$DataGridView,
    
    [ValidateNotNull()]
    [Parameter(Mandatory = $true)]
    $Item,
    
    [Parameter(Mandatory = $false)]
    [string]$DataMember,
    
    [System.Windows.Forms.DataGridViewAutoSizeColumnMode]$AutoSizeColumns = 'None'
  )
  $DataGridView.SuspendLayout()
  $DataGridView.DataMember = $DataMember
  
  if ($Item -is [System.Data.DataSet] -and $Item.Tables.Count -gt 0) {
    $DataGridView.DataSource = $Item.Tables[0]
  } elseif ($Item -is [System.ComponentModel.IListSource] `
    -or $Item -is [System.ComponentModel.IBindingList] -or $Item -is [System.ComponentModel.IBindingListView]) {
    $DataGridView.DataSource = $Item
  } else {
    $array = New-Object System.Collections.ArrayList
    
    if ($Item -is [System.Collections.IList]) {
      $array.AddRange($Item)
    } else {
      $array.Add($Item)
    }
    $DataGridView.DataSource = $array
  }
  
  if ($AutoSizeColumns -ne 'None') {
    $DataGridView.AutoResizeColumns($AutoSizeColumns)
  }
  
  $DataGridView.ResumeLayout()
}