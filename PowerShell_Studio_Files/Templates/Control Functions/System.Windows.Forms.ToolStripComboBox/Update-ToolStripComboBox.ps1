<#
.SYNOPSIS
	This functions helps you load items into a ToolStripComboBox.

.DESCRIPTION
	Use this function to dynamically load items into the ToolStripComboBox control.

.PARAMETER ToolStripComboBox
	The ToolStripComboBox control you want to add items to.

.PARAMETER Items
	The object or objects you wish to load into the ToolStripComboBox's Items collection.

.PARAMETER Append
	Adds the item(s) to the ToolStripComboBox without clearing the Items collection.

.EXAMPLE
	Update-ToolStripComboBox $toolStripComboBox1 "Red", "White", "Blue"

.EXAMPLE
	Update-ToolStripComboBox $toolStripComboBox1 "Red" -Append
	Update-ToolStripComboBox $toolStripComboBox1 "White" -Append
	Update-ToolStripComboBox $toolStripComboBox1 "Blue" -Append

.NOTES
	Additional information about the function.
#>
function Update-ToolStripComboBox {
  param
  (
    [Parameter(Mandatory = $true)]
    [ValidateNotNull()]
    [System.Windows.Forms.ToolStripComboBox]$ToolStripComboBox,
    
    [Parameter(Mandatory = $true)]
    [ValidateNotNull()]
    $Items,
    
    [switch]$Append
  )
  
  if (-not $Append) {
    $ToolStripComboBox.Items.Clear()
  }
  
  if ($Items -is [Object[]]) {
    $ToolStripComboBox.Items.AddRange($Items)
  } elseif ($Items -is [Array]) {
    $ToolStripComboBox.BeginUpdate()
    foreach ($obj in $Items) {
      $ToolStripComboBox.Items.Add($obj)
    }
    $ToolStripComboBox.EndUpdate()
  } else {
    $ToolStripComboBox.Items.Add($Items)
  }
}
