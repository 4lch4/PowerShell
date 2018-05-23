<#
.SYNOPSIS
  Initializes my *Great Wall* by killing _all_ active connections, disabling any
  ethernet interfaces and blocks all network actions until specified otherwise.
#>

Disable-NetAdapter -Name *