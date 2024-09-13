<#
.SYNOPSIS
    Get Fast Startup
.DESCRIPTION
    Return 0 to skip remediation, 1 to perform remediation. Return the registry
    key value for the HiberbootEnabled DWORD.
.LINK
    https://learn.microsoft.com/en-us/mem/intune/fundamentals/remediations
#>

[int32]$SkipRemediate = 0
[int32]$Remediate = 1

$Path = "HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager\Power"
$Name = "HiberbootEnabled"
$Value = 0
$Registry = Get-ItemProperty -Path $Path -Name $Name -ErrorAction SilentlyContinue | Select-Object -ExpandProperty $Name

try
{
    if ($Registry -ne $Value)
    {
        Write-Host "$Name -ne $Value. Remediate."
        exit $Remediate
    }
    else
    {
        Write-Host "$Name -eq $Value. Skip Remediate."
        exit $SkipRemediate
    }
}
catch
{
    Write-Host $_.Exception.Message
    exit $Remediate
}
