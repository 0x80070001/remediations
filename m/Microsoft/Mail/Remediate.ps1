<#
.SYNOPSIS
    Remove built-in Mail
.DESCRIPTION
    Remove the built-in Mail App
.LINK
    https://learn.microsoft.com/en-us/mem/intune/fundamentals/remediations
#>

[int32]$Success = 0
[int32]$Failure = 1

$Name = "Microsoft.windowscommunicationsapps"

try
{
    Get-AppxPackage -Name "$Name" | Remove-AppxPackage
    exit $Success
}
catch
{
    Write-Host $_.Exception.Message
    exit $Failure
}
