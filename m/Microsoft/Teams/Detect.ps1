<#
.SYNOPSIS
    Get built-in Teams Personal
.DESCRIPTION
    Return 0 to skip remediation, 1 to perform remediation. Detect built-in Teams Personal app.
.LINK
    https://learn.microsoft.com/en-us/mem/intune/fundamentals/remediations
#>

[int32]$SkipRemediate = 0
[int32]$Remediate = 1

$Appx = Get-AppxPackage -Name "MicrosoftTeams" -AllUsers -ErrorAction SilentlyContinue

try
{
    if ($Appx.Name -eq "MicrosoftTeams")
    {
        Write-Host "MicrosoftTeams is installed. Remediate"
        exit $Remediate
    }
    else
    {
        Write-Host "MicrosoftTeams is not installed. Skip Remediate"
        exit $SkipRemediate
    }
}
catch
{
    Write-Host $_.Exception.Message
    exit $Remediate
}
