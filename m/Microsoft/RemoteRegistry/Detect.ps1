<#
.SYNOPSIS
    Get Remote Registry Status
.DESCRIPTION
    Return 0 to skip remediation, 1 to perform remediation. Return Remote Registry Service Status.
.LINK
    https://learn.microsoft.com/en-us/mem/intune/fundamentals/remediations
#>

[int32]$SkipRemediate = 0
[int32]$Remediate = 1

$Service = Get-Service RemoteRegistry | Select-Object StartType -ErrorAction SilentlyContinue

try
{
    if ($Service.StartType -ne 'Disabled' -and $Service.Status -ne 'Stopped')
    {
        Write-Host "Remote Registry Service -ne Disabled and -ne Stopped. Remediate"
        exit $Remediate
    }
    else
    {
        Write-Host "Remote Registry Service Disabled and Stopped. Skip Remediate"
        exit $SkipRemediate
    }
}
catch
{
    Write-Host $_.Exception.Message
    exit $Remediate
}
