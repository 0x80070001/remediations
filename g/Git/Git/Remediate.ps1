<#
.SYNOPSIS
    Update git
.DESCRIPTION
    Using winget update git when available
.LINK
    https://learn.microsoft.com/en-us/mem/intune/fundamentals/remediations
#>

[int32]$Success = 0
[int32]$Failure = 1

try {
    # Detect a running git to avoid disrupting the USER
    $RunningProcess = 0
    $ProcessNames = @("git", "git-bash", "git-cmd")
    foreach ($ProcessName in $ProcessNames) {
        if ($null -ne (Get-Process -Name $ProcessName -ErrorAction SilentlyContinue)) {
            $RunningProcess = $RunningProcess + 1
        }
    }

    if ( $RunningProcess -eq 0) {
        & winget install --id "Git.Git" --exact --silent --accept-source-agreements --accept-package-agreements | Out-Default
        exit $Success
    } else {
        Write-Host "Git in use, skipping update."
        exit $Failure
    }
}
catch {
    Write-Host $_.Exception.Message
    exit $Failure
}
