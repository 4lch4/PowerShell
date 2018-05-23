##############################
#.SYNOPSIS
#Gets a list of Achievement ids from the internet.
#
#.DESCRIPTION
#Queries the wow-stats.com website and parses their list
#of achievement ids into an ArrayList and returns it.
##############################
function Get-AchievementIdList() {
  $AchievementIds = New-Object -TypeName System.Collections.ArrayList

  $BaseUrl = "http://wow-stats.com/allAchList.html"
  $WebData = Invoke-WebRequest -Uri $BaseUrl

  $HtmlDoc = $WebData.ParsedHtml
  $AchievementIdRows = $HtmlDoc.getElementsByClassName('Talt')

  foreach ($AchievementRow in $AchievementIdRows) {
    $FirstTd = $AchievementRow.getElementsByTagName('td')[0]
    $Link = $FirstTd.getElementsByTagName('a')[0]
    $Number = $Link.innerText.substring(1)
    $AchievementIds.Add($Number)
  }

  Save-AchievementList $AchievementIds
  return $AchievementIds
}

function Save-AchievementList() {
  param (
    $AchievementList,
    $Path = ".\Achievement_Ids.txt"
  )

  foreach($Achievement in $AchievementList) {
    Add-Content -Path $Path -Value $Achievement
  }
}

function Save-AchievementData() {
  param (
    $AchievementId,
    $ApiKey,
    $Path = ".\Achievements\Achievement-$AchievementId.json"
  )
  $AchievementId

  $Url = "https://us.api.battle.net/wow/achievement/"
  $Url += "$AchievementId"
  $Url += "?locale=en_US&apikey=$ApiKey"
  $WebData = Invoke-WebRequest -Uri $Url

  if($WebData.Content.Length -gt 0) {
    $Json = ConvertFrom-Json $WebData.Content
    Set-Content -Path $Path -Value (ConvertTo-Json $Json)
  }
}

function Save-AchievementDataList() {
  param (
    $Ids,
    $ApiKey
  )

  ForEach($Id in $Ids) {
    Save-AchievementData -AchievementId $Id -ApiKey $ApiKey
    Start-Sleep -Milliseconds 100
  }
}

function Save-SpellDataList() {
  param (
    $Ids,
    $ApiKey
  )
  foreach($Id in $Ids) {
    Save-SpellData $Id $ApiKey
    Start-Sleep -Milliseconds 100
  }
}

function Save-SpellData() {
  param (
    $SpellId,
    $ApiKey
  )

  Write-Output "Saving Spell-$SpellId..."

  $Url = "https://us.api.battle.net/wow/spell/"
  $Url += "$SpellId"
  $Url += "?locale=en_US&apikey=$ApiKey"

  $WebData = Invoke-WebRequest $Url
  if ($WebData.Content.Length -gt 0) {
    $Json = ConvertFrom-Json $WebData.Content
    Set-Content ".\Spells\Spell-$SpellId.json" -Value (ConvertTo-Json $Json)
  }
}

