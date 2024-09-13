<#
.SYNOPSIS
    Get LAPS User
.DESCRIPTION
    Return 0 to skip remediation, 1 to perform remediation. Get the enabled
    local administrator password solution account.
.LINK
    https://learn.microsoft.com/en-us/mem/intune/fundamentals/remediations
#>

[int32]$SkipRemediate = 0
[int32]$Remediate = 1

$Name = "xxxxxxxxxxx"

try
{
    if ($(Get-LocalUser -Name "${Name}" | Where-Object { $_.Enabled -eq $True }).Count -ne 1)
    {
        Write-Host "LAPS account $Name not enabled. Remediate."
        exit $Remediate
    }
    else
    {   Write-Host "LAPS account $Name enabled. Skip Remediate."
        exit $SkipRemediate
    }
}
catch
{
    Write-Host $_.Exception.Message
    exit $Remediate
}
