<#
.SYNOPSIS
    Enable a LAPS account
.DESCRIPTION
    Enable local administrator password solution account to be used
    in conjunction with an Account Protectio LAPS configuration policy.
.LINK
    https://learn.microsoft.com/en-us/mem/intune/fundamentals/remediations
#>

[int32]$Success = 0
[int32]$Failure = 1

$Name = "xxxxxxxxxxx"
$Random = ([System.Guid]::NewGuid()).ToString()
$Password = ConvertTo-SecureString -String $Random -AsPlainText -Force

try {
    New-LocalUser "${Name}" -Password $Password -FullName "Local Administrator" -Description "LAPS Local Administrator"
    Add-LocalGroupMember -Group "Administrators" -Member "${Name}"
    exit $Success
} catch {
    Write-Host $_.Exception.Message
    exit $Failure
}
