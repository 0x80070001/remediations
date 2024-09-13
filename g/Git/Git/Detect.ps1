<#
.SYNOPSIS
    Get winget git update
.DESCRIPTION
    Return 0 to skip remediation, 1 to perform remediation. Return winget
    git update information.
.LINK
    https://learn.microsoft.com/en-us/mem/intune/fundamentals/remediations
#>

[int32]$SkipRemediate = 0
[int32]$Remediate = 1

try
{
    $Update = (winget list --id "Git.Git" --exact | Select-String '\bVersion\s+Available\b' -Quiet)
    if ($Update)
    {
        Write-Host "Git update available. Remediate."
        exit $Remediate
    }
    else
    {
        Write-Host "Git update not available. Skip Remediate."
        exit $SkipRemediate
    }
}
catch
{
    Write-Host $_.Exception.Message
    exit $Remediate
}
