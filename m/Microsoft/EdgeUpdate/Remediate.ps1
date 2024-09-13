<#
.SYNOPSIS
    Update Edge
.DESCRIPTION
    Force update Microsoft Edge
.LINK
    https://learn.microsoft.com/en-us/mem/intune/fundamentals/remediations
#>

[int32]$Success = 0
[int32]$Failure = 1

try {
    Start-Process -FilePath "C:\Program Files (x86)\Microsoft\EdgeUpdate\MicrosoftEdgeUpdate.exe" -ArgumentList "/install appguid={56EB18F8-B008-4CBD-B6D2-8C97FE7E9062}&appname=Microsoft%20Edge&needsadmin=True" -Wait
    $Latest = (Get-ChildItem -Directory -Path "C:\Program Files (x86)\Microsoft\Edge\Application\" | Where-Object { $_.Name -match '\d' } | Sort-Object LastWriteTime -Descending | Select-Object -First 1).Name
    Write-Host "C:\Program Files (x86)\Microsoft\Edge\Application\$Latest"
    exit $Success
} catch {
    Write-Host $_.Exception.Messaage
    exit $Failure
}
