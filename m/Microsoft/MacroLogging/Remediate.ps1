<#
.SYNOPSIS
    Set EnableLogging
.DESCRIPTION
    Set the registry key value for the EnableLogging DWORD to the required
    value ensuring EnableLogging is enabled.
.LINK
    https://learn.microsoft.com/en-us/mem/intune/fundamentals/remediations
.LINK
    https://learn.microsoft.com/en-us/office/troubleshoot/diagnostic-logs/how-to-enable-office-365-proplus-uls-logging
#>

[int32]$Success = 0
[int32]$Failure = 1

try {
    $OfficeRegistry = "HKCU:\SOFTWARE\Microsoft\Office\"
    $OfficeSubKey = Get-ChildItem -Path $OfficeRegistry
    foreach ($SubKey in $OfficeSubKey) {
        $SubPath = ($($SubKey.Name) -split "\\" | Select-Object -Last 1)
        $RegKey = "HKCU:\SOFTWARE\Microsoft\Office\$SubPath\Common\TrustCenter"
        If (Test-Path -Path $RegKey) {
           $Path = "$RegKey"
           $Name = "EnableLogging"
           $Value = 1
           New-ItemProperty -LiteralPath "$Path" -Name "$Name" -Value $Value -PropertyType DWord -Force
        }
    }
    exit $Success
} catch {
    Write-Host $_.Exception.Message
    exit $Failure
}
