<#
.SYNOPSIS
    Remove built-in Teams Personal
.DESCRIPTION
    Remove the built-in Teams Personal App
.LINK
    https://learn.microsoft.com/en-us/mem/intune/fundamentals/remediations
#>

[int32]$Success = 0
[int32]$Failure = 1

$App = "MicrosoftTeams"

try
{
    Get-AppxPackage -Name "$App" -AllUsers | Remove-AppxPackage -AllUsers
    Get-AppxProvisionedPackage -Online | Where-Object {$_.displayname -eq "$App"} | Remove-AppxProvisionedPackage -Online
    exit $Success
}
catch
{
    Write-Host $_.Exception.Message
    exit $Failure
}
