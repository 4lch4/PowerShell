#	===========================================================================
#	Created on:   5/27/2018 @ 23:59
#	Created by:   Alcha
#	Organization: HassleFree Solutions, LLC
#	Filename:     Get-Controls.ps1
#	===========================================================================

function Get-TextBox () {
  $TextBox = New-Object -TypeName System.Windows.Forms.TextBox
  $TextBox.Location = New-Object -TypeName System.Drawing.Point(10, 40)
  $TextBox.Size = New-Object System.Drawing.Size(260, 20)
  
  return $TextBox
}

function Get-OKButton () {
  $OKButton = New-Object -TypeName System.Windows.Forms.Button
  $OKButton.Location = New-Object -TypeName System.Drawing.Point(75, 120)
  $OKButton.Size = New-Object -TypeName System.Drawing.Size(75, 23)
  $OKButton.Text = 'OK'
  $OKButton.DialogResult = [System.Windows.Forms.DialogResult]::OK
  
  return $OKButton
}

function Get-CancelButton () {
  $CancelButton = New-Object -TypeName System.Windows.Forms.Button
  $CancelButton.Location = New-Object -TypeName System.Drawing.Point(150, 120)
  $CancelButton.Size = New-Object -TypeName System.Drawing.Size(75, 23)
  $CancelButton.Text = 'Cancel'
  $CancelButton.DialogResult = [System.Windows.Forms.DialogResult]::Cancel
  
  return $CancelButton
}

function Get-Label () {
  $Label = New-Object -TypeName System.Windows.Forms.Label
  $Label.Location = New-Object -TypeName System.Drawing.Point(10, 20)
  $Label.Size = New-Object -TypeName System.Drawing.Size(280, 20)
  $Label.Text = 'Please enter the requested information below.'
  
  return $Label
}
