$parentProfilePath = Split-Path -Path $profile -Parent
Get-ChildItem -Path . -Filter '*_profile.ps1' | ForEach-Object -Process {
    Copy-Item -Path $_ -Destination "$parentProfilePath\$($_.Name)" -Force
}
