<#
.SYNOPSIS
    Disable NetFx3
.DESCRIPTION
    Disable the Windows Optional Feature NetFx3
.LINK
    https://learn.microsoft.com/en-us/mem/intune/fundamentals/remediations
#>

[int32]$Success = 0
[int32]$Failure = 1

try {
    Disable-WindowsOptionalFeature -Online -FeatureName 'NetFx3' -NoRestart
    exit $Success
}
catch
{
    Write-Host $_.Exception.Message
    exit $Failure
}
