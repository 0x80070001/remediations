<#
.SYNOPSIS
    Disable Local Administrator
.DESCRIPTION
    Disable local administrator account and randomise the password.
.LINK
    https://learn.microsoft.com/en-us/mem/intune/fundamentals/remediations
#>

[int32]$Success = 0
[int32]$Failure = 1

$Name = "Administrator"
$Random = ([System.Guid]::NewGuid()).ToString()
$Password = ConvertTo-SecureString -String $Random -AsPlainText -Force

try {
    Get-LocalUser -Name "${Name}" | Set-LocalUser -Password $Password
    Get-LocalUser -Name "${Name}" | Where-Object { $_.Enabled -eq $True } | Disable-LocalUser
    exit $Success
} catch {
    Write-Host $_.Exception.Message
    exit $Failure
}
