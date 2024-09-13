<#
.SYNOPSIS
    Get winget 7zip update
.DESCRIPTION
    Return 0 to skip remediation, 1 to perform remediation. Return winget
    7zip update information.
.LINK
    https://learn.microsoft.com/en-us/mem/intune/fundamentals/remediations
#>

[int32]$SkipRemediate = 0
[int32]$Remediate = 1

try
{
    $Update = (winget list --id "7zip.7zip" --exact | Select-String '\bVersion\s+Available\b' -Quiet)
    if ($Update)
    {
        Write-Host "7zip update available. Remediate."
        exit $Remediate
    }
    else
    {
        Write-Host "7zip update not available. Skip Remediate."
        exit $SkipRemediate
    }
}
catch
{
    Write-Host $_.Exception.Message
    exit $Remediate
}
