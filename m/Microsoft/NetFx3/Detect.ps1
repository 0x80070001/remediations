<#
.SYNOPSIS
    Get NetFx3
.DESCRIPTION
    Return 0 to skip remediation, 1 to perform remediation. Return NetFx3 
    state.
.LINK
    https://learn.microsoft.com/en-us/mem/intune/fundamentals/remediations
#>

[int32]$SkipRemediate = 0
[int32]$Remediate = 1

$Feature = Get-WindowsOptionalFeature -Online -FeatureName 'NetFx3' -ErrorAction SilentlyContinue

try
{
    if ($Feature.State -eq 'Enabled')
    {
        Write-Host "NetFx3 is Enabled. Remediate."
        exit $Remediate
    }
    else
    {
        Write-Host "NetFx3 is not Enabled. Skip Remediate."
        exit $SkipRemediate
    }
}
catch
{
    Write-Host $_.Exception.Message
    exit $Remediate
}
