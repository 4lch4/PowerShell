<#
.SYNOPSIS
	This function collects a list of checked nodes in a TreeView

.DESCRIPTION
	This function collects a list of checked nodes in a TreeView

.PARAMETER  $NodeCollection
	The collection of nodes to search

.PARAMETER  $CheckedNodes
	The ArrayList that will contain the all the checked items

.EXAMPLE
	$CheckedNodes = New-Object System.Collections.ArrayList
	Get-CheckedNode $treeview1.Nodes $CheckedNodes
	foreach($node in $CheckedNodes)
	{	
		Write-Host $node.Text
	}
#>
function Get-CheckedNode {
  param (
    [ValidateNotNull()]
    [System.Windows.Forms.TreeNodeCollection]$NodeCollection,
    
    [ValidateNotNull()]
    [System.Collections.ArrayList]$CheckedNodes
  )
  
  foreach ($Node in $NodeCollection) {
    if ($Node.Checked) {
      [void]$CheckedNodes.Add($Node)
    }
    Get-CheckedNode $Node.Nodes $CheckedNodes
  }
}
