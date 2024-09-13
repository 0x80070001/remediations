<#
.SYNOPSIS
    Get built-in Mail
.DESCRIPTION
    Return 0 to skip remediation, 1 to perform remediation. Detect built-in Mail App
.LINK
    https://learn.microsoft.com/en-us/mem/intune/fundamentals/remediations
#>

[int32]$SkipRemediate = 0
[int32]$Remediate = 1

$Name = "Microsoft.windowscommunicationsapps"
$Appx = Get-AppxPackage -Name "$Name" -ErrorAction SilentlyContinue

try
{
    if ($Appx.Name -eq "$Name")
    {
        Write-Host "Microsoft.windowscommunicationsapps is installed. Remediate"
        exit $Remediate
    }
    else
    {
        Write-Host "Microsoft.windowscommunicationsapps is not installed. Skip Remediate"
        exit $SkipRemediate
    }
}
catch
{
    Write-Host $_.Exception.Message
    exit $Remediate
}
