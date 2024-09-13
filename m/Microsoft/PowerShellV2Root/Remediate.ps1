<#
.SYNOPSIS
    Disable PowerShell V2
.DESCRIPTION
    Disable the Windows Optional Feature MicrosoftWindowsPowerShellV2Root
.LINK
    https://learn.microsoft.com/en-us/mem/intune/fundamentals/remediations
#>

[int32]$Success = 0
[int32]$Failure = 1

try {
    Disable-WindowsOptionalFeature -Online -FeatureName 'MicrosoftWindowsPowerShellV2Root' -NoRestart
    exit $Success
}
catch
{
    Write-Host $_.Exception.Message
    exit $Failure
}
