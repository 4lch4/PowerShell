<#
.SYNOPSIS
	Converts objects into a DataTable.

.DESCRIPTION
	Converts objects into a DataTable, which are used for DataBinding.

.PARAMETER  InputObject
	The input to convert into a DataTable.

.PARAMETER  Table
	The DataTable you wish to load the input into.

.PARAMETER RetainColumns
	This switch tells the function to keep the DataTable's existing columns.

.PARAMETER FilterWMIProperties
	This switch removes WMI properties that start with an underline.

.EXAMPLE
	$DataTable = ConvertTo-DataTable -InputObject (Get-Process)
#>
function ConvertTo-DataTable {
  [OutputType([System.Data.DataTable])]
  param (
    [ValidateNotNull()]
    $InputObject,
    
    [ValidateNotNull()]
    [System.Data.DataTable]$Table,
    
    [switch]$RetainColumns,
    
    [switch]$FilterWMIProperties)
  
  if ($null -eq $Table) {
    $Table = New-Object System.Data.DataTable
  }
  
  if ($InputObject -is [System.Data.DataTable]) {
    $Table = $InputObject
  } elseif ($InputObject -is [System.Data.DataSet] -and $InputObject.Tables.Count -gt 0) {
    $Table = $InputObject.Tables[0]
  } else {
    if (-not $RetainColumns -or $Table.Columns.Count -eq 0) {
      #Clear out the Table Contents
      $Table.Clear()
      
      if ($null -eq $InputObject) { return } #Empty Data
      
      $object = $null
      #find the first non null value
      foreach ($item in $InputObject) {
        if ($null -ne $item) {
          $object = $item
          break
        }
      }
      
      if ($null -eq $object) { return } #All null then empty
      
      #Get all the properties in order to create the columns
      foreach ($prop in $object.PSObject.Get_Properties()) {
        if (-not $FilterWMIProperties -or -not $prop.Name.StartsWith('__')) #filter out WMI properties
{
          #Get the type from the Definition string
          $type = $null
          
          if ($null -ne $prop.Value) {
            try { $type = $prop.Value.GetType() } catch { Out-Null }
          }
          
          if ($null -ne $type) # -and [System.Type]::GetTypeCode($type) -ne 'Object')
{
            [void]$table.Columns.Add($prop.Name, $type)
          } else #Type info not found
{
            [void]$table.Columns.Add($prop.Name)
          }
        }
      }
      
      if ($object -is [System.Data.DataRow]) {
        foreach ($item in $InputObject) {
          $Table.Rows.Add($item)
        }
        return @( ,$Table)
      }
    } else {
      $Table.Rows.Clear()
    }
    
    foreach ($item in $InputObject) {
      $row = $table.NewRow()
      
      if ($item) {
        foreach ($prop in $item.PSObject.Get_Properties()) {
          if ($table.Columns.Contains($prop.Name)) {
            $row.Item($prop.Name) = $prop.Value
          }
        }
      }
      [void]$table.Rows.Add($row)
    }
  }
  
  return @( ,$Table)
}