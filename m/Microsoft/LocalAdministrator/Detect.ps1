<#
.SYNOPSIS
    Get Local Administrator
.DESCRIPTION
    Return 0 to skip remediation, 1 to perform remediation. Get the 
    enabled local administrator account.
.LINK
    https://learn.microsoft.com/en-us/mem/intune/fundamentals/remediations
#>

[int32]$SkipRemediate = 0
[int32]$Remediate = 1

$Name = "Administrator"

try
{
    if (Get-LocalUser -Name "${Name}" | Where-Object { $_.Enabled -eq $True })
    {
        Write-Host "Local administrator account enabled. Remediate."
        exit $Remediate
    }
    else
    {
        Write-Host "Local administrator not enabled. Skip Remediate."
        exit $SkipRemediate
    }
}
catch
{
    Write-Host $_.Exception.Message
    exit $Remediate
}
