<#
.SYNOPSIS
    Get EnableLogging state
.DESCRIPTION
    Return 0 to skip remediation, 1 to perform remediation. Return the registry
    key value for the EnableLogging DWORD.
.LINK
    https://learn.microsoft.com/en-us/mem/intune/fundamentals/remediations
#>

[int32]$SkipRemediate = 0
[int32]$Remediate = 1

try {
    $OfficeRegistry = "HKCU:\SOFTWARE\Microsoft\Office\"
    $OfficeSubKey = Get-ChildItem -Path $OfficeRegistry
    foreach ($SubKey in $OfficeSubKey) {
        $SubPath = ($($SubKey.Name) -split "\\" | Select-Object -Last 1)
        $RegKey = "HKCU:\SOFTWARE\Microsoft\Office\$SubPath\Common\TrustCenter"
        If (Test-Path -Path $RegKey -ErrorAction SilentlyContinue) {
            $Registry += (Get-ItemProperty -Path $RegKey -Name "EnableLogging" -ErrorAction SilentlyContinue).EnableLogging
            Get-ItemProperty -Path $RegKey -Name "EnableLogging"
        }
    }
    if ($Registry -lt 1 -And $OfficeSubKey) {
        Write-Host "EnableLogging is not enabled. Remediate."
        exit $Remediate
    } else {
        Write-Host "EnableLogging is enabled. Skip Remediate."
        exit $SkipRemediate
    }
} catch {
    Write-Host $_.Exception.Message
    exit $Remediate
}
