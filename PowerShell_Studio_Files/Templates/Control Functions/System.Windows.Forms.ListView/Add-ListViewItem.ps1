<#
.SYNOPSIS
	Adds the item(s) to the ListView and stores the object in the ListViewItem's Tag property.

.DESCRIPTION
	Adds the item(s) to the ListView and stores the object in the ListViewItem's Tag property.

.PARAMETER ListView
	The ListView control to add the items to.

.PARAMETER Items
	The object or objects you wish to load into the ListView's Items collection.
	
.PARAMETER  ImageIndex
	The index of a predefined image in the ListView's ImageList.

.PARAMETER  SubItems
	List of strings to add as Subitems.

.PARAMETER Group
	The group to place the item(s) in.

.PARAMETER Clear
	This switch clears the ListView's Items before adding the new item(s).

.EXAMPLE
	Add-ListViewItem -ListView $listview1 -Items "Test" -Group $listview1.Groups[0] -ImageIndex 0 -SubItems "Installed"
#>
function Add-ListViewItem {
  param (
    [ValidateNotNull()]
    [Parameter(Mandatory = $true)]
    [System.Windows.Forms.ListView]$ListView,
    
    [ValidateNotNull()]
    [Parameter(Mandatory = $true)]
    $Items,
    
    [int]$ImageIndex = -1,
    
    [string[]]$SubItems,
    
    $Group,
    
    [switch]$Clear)
  
  if ($Clear) {
    $ListView.Items.Clear();
  }
  
  $LVGroup = $null
  if ($Group -is [System.Windows.Forms.ListViewGroup]) {
    $LVGroup = $Group
  } elseif ($Group -is [string]) {
    #$lvGroup = $ListView.Group[$Group] # Case sensitive
    foreach ($GroupItem in $ListView.Groups) {
      if ($GroupItem.Name -eq $Group) {
        $LVGroup = $GroupItem
        break
      }
    }
    
    if ($null -eq $LVGroup) {
      $LVGroup = $ListView.Groups.Add($Group, $Group)
    }
  }
  
  if ($Items -is [Array]) {
    $ListView.BeginUpdate()
    foreach ($item in $Items) {
      $ListItem = $ListView.Items.Add($item.ToString(), $ImageIndex)
      #Store the object in the Tag
      $ListItem.Tag = $item
      
      if ($null -ne $SubItems) {
        $ListItem.SubItems.AddRange($SubItems)
      }
      
      if ($null -ne $LVGroup) {
        $ListItem.Group = $LVGroup
      }
    }
    $ListView.EndUpdate()
  } else {
    #Add a new item to the ListView
    $ListItem = $ListView.Items.Add($Items.ToString(), $ImageIndex)
    #Store the object in the Tag
    $ListItem.Tag = $Items
    
    if ($null -ne $SubItems) {
      $ListItem.SubItems.AddRange($SubItems)
    }
    
    if ($null -ne $LVGroup) {
      $ListItem.Group = $LVGroup
    }
  }
}
