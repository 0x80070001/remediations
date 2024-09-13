<#
.SYNOPSIS
    Get Edge version
.DESCRIPTION
    Return 0 to skip remediation, 1 to perform remediation. Return Microsoft Edge
    file version.
.LINK
    https://learn.microsoft.com/en-us/mem/intune/fundamentals/remediations
#>

[int32]$SkipRemediate = 0
[int32]$Remediate = 1

try {
    if (Test-Path -Path "C:\Program Files (x86)\Microsoft\EdgeUpdate\MicrosoftEdgeUpdate.exe") {
        [string]$FilePath = "C:\Program Files (x86)\Microsoft\Edge\Application\msedge.exe"
        [version]$FileVersion = (Get-ChildItem "$FilePath").VersionInfo.FileVersionRaw
        Write-Host "C:\Program Files (x86)\Microsoft\Edge\Application\msedge.exe $FileVersion. Remediate"
        exit $Remediate
    } else {
        Write-Host "Skip Remediate C:\Program Files (x86)\Microsoft\Edge\Application\msedge.exe missing. Skip Remediate."
        exit $SkipRemediate
    }
} catch {
    Write-Host $_.Exception.Message
    exit $Remediate
}
