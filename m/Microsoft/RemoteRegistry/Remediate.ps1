<#
.SYNOPSIS
    Disable Remote Registry
.DESCRIPTION
    Disable the RemoteRegistry Service
.LINK
    https://learn.microsoft.com/en-us/mem/intune/fundamentals/remediations
#>

[int32]$Success = 0
[int32]$Failure = 1

try {
    Get-Service -Name RemoteRegistry | Set-Service -StartupType Disabled -PassThru | Stop-Service
    exit $Success
}
catch
{
    Write-Host $_.Exception.Message
    exit $Failure
}
