# ===========================================================================
# Created on:   5/27/2018 @ 23:13
# Created by:   Alcha
# Organization: HassleFree Solutions, LLC
# Filename:     GUI_Test.ps1
# ===========================================================================

<#
.DESCRIPTION
	A simple test of some GUI shit based off this article: http://bit.ly/2xkyxTx

.EXAMPLE
	.\GUI_Test.ps1
#>

. .\Controls.ps1
Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

$Form = New-Object -TypeName System.Windows.Forms.Form
$Form.Text = 'Data Entry Form'
$Form.Size = New-Object -TypeName System.Drawing.Size(300, 200)
$Form.StartPosition = 'CenterScreen'
$Form.Icon = New-Object -TypeName System.Drawing.Icon(".\Assets\HassleFree_Solutions.ico")

$Label = Get-Label
$OKButton = Get-OKButton
$CancelButton = Get-CancelButton
$TextBox = Get-TextBox

$Form.AcceptButton = $OKButton
$Form.Controls.Add($OKButton)

$Form.CancelButton = $CancelButton
$Form.Controls.Add($CancelButton)

$Form.Controls.Add($Label)
$Form.Controls.Add($TextBox)

$Form.TopMost = $true

$Form.add_Shown({$TextBox.Select()})

$Result = $Form.ShowDialog()

if ($Result -eq [System.Windows.Forms.DialogResult]::OK) {
  Write-Host 'Here is some text for you bastards...'
  Write-Host $TextBox.Text
} else {
  Write-Host 'Script was canceled.'
}
