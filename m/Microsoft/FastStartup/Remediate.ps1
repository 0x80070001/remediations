<#
.SYNOPSIS
    Set Fast Startup
.DESCRIPTION
    Set the registry key value for the HiberbootEnabled DWORD to the required
    value ensuring Fast Startup is disabled.
.LINK
    https://learn.microsoft.com/en-us/mem/intune/fundamentals/remediations
#>

[int32]$Success = 0
[int32]$Failure = 1

try
{
    $Path = "HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager\Power"
    $Name = "HiberbootEnabled"
    $Value = 0
    New-ItemProperty -LiteralPath "$Path" -Name "$Name" -Value $Value -PropertyType DWord -Force -ErrorAction SilentlyContinue
    exit $Success
}
catch
{
    Write-Host $_.Exception.Message
    exit $Failure
}
