# Prereq: Execution Policy: Set-ExecutionPolicy Bypass
# Prereq: Chocolatey: @"%SystemRoot%\System32\WindowsPowerShell\v1.0\powershell.exe" -NoProfile -InputFormat None -ExecutionPolicy Bypass -Command "iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))" && SET "PATH=%PATH%;%ALLUSERSPROFILE%\chocolatey\bin"
# Note: Geforce Experience chocolatey package out of date, get manually
# Note: Update PowerShell help manually (sometimes hangs during these scripts)
# TODO: Perform symlink command for D:\Scripts -> D:\Users\<User>\Scripts
[CmdletBinding()]
param (
    [Parameter(Mandatory=$false)]
    [ValidateNotNullOrEmpty()]
    [string]
    $GitUserName = 'Ryan Spletzer',

    [Parameter(Mandatory=$false)]
    [ValidateNotNullOrEmpty()]
    [string]
    $GitEmail = 'ryanspletzer@gmail.com'
)

Write-Host -Object "Configuring Power Options"
powercfg.exe /change -monitor-timeout-ac 0
powercfg.exe /change -monitor-timeout-dc 0
powercfg.exe /change -disk-timeout-ac 0
powercfg.exe /change -disk-timeout-dc 0
powercfg.exe /change -standby-timeout-ac 0
powercfg.exe /change -standby-timeout-dc 0
powercfg.exe /change -hibernate-timeout-ac 0
powercfg.exe /change -hibernate-timeout-dc 0

Write-Host -Object "Configuring System Clock to Set Time Zone to Eastern (setting automatically doesn't always work)"
Set-TimeZone -Name "Eastern Standard Time"

Write-Host -Object "Configuring PowershellGet and Chocolatey package manager..."
Install-PackageProvider -Name NuGet -MinimumVersion 2.8.5.201 -Force
Set-PackageSource -Name PSGallery -Trusted -ForceBootstrap
Write-Host -Object "Package managers set!"

Write-Host -Object "Configuring Windows Explorer to show hidden folders and file extensions"
$key = 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced'
Set-ItemProperty -Path $key -Name Hidden -Value 1
Set-ItemProperty -Path $key -Name HideFileExt -Value 0
Get-Process -Name 'explorer' | Stop-Process | Invoke-Item
$key = ''
Write-Host -Object "Windows Explorer configured!"

Write-Host -Object "Ensuring Public NetConnectionProfiles are set to Private..."
Get-NetConnectionProfile |
Where-Object -FilterScript { $_.NetworkCategory -eq "Public" } |
Set-NetConnectionProfile -NetworkCategory Private

Write-Host -Object  "Enabling remote desktop and PowerShell remoting..."
Enable-PSRemoting -Force
Set-Item -Path wsman:\localhost\client\trustedhosts -Value * -Force
Enable-WSManCredSSP -Role Server -Force
Enable-WSManCredSSP -Role Client -DelegateComputer * -Force
Set-ItemProperty -Path 'HKLM:System\CurrentControlSet\Control\Terminal Server'-name "fDenyTSConnections" -Value 0
Enable-NetFirewallRule -DisplayGroup "Remote Desktop"
Set-ItemProperty -Path 'HKLM:System\CurrentControlSet\Control\Terminal Server\WinStations\RDP-Tcp' -name "UserAuthentication" -Value 1
Write-Host -Object "Remote desktop and PowerShell remoting enabled!"

Write-Host -Object "Disabling PowerShell beeping..."
Set-PSReadlineOption -BellStyle None

Write-Host -Object "Installing miscellaneous applications..."
choco install notepadplusplus --yes
choco install firefox --yes
choco install googlechrome --yes
choco install visualstudiocode --yes
choco install keepass --yes
choco install sysinternals --yes
choco install git --yes
choco install rsat --yes
choco install sql-server-management-studio --yes
choco install visualstudio2017enterprise --yes
choco install dotnetcore-sdk --yes

Write-Host -Object "Checking git config user.name and user.email..."
if ([String]::IsNullOrWhiteSpace($(& "${env:ProgramFiles}\Git\cmd\git.exe" config --global --get user.name)) -or
    [String]::IsNullOrWhiteSpace($(& "${env:ProgramFiles}\Git\cmd\git.exe" config --global --get user.email))) {
    Write-Host -Object "Setting git config user.name and user.email."
    & "${env:ProgramFiles}\Git\cmd\git.exe" config --global user.name $GitUserName
    & "${env:ProgramFiles}\Git\cmd\git.exe" config --global user.email $GitEmail
} else {
    Write-Host -Object "git config user.name and user.email is already set for this user."
}

Write-Host -Object "Checking for posh-git PowerShell module..."
Install-Module -Name posh-git -Force

Write-Host -Object "Checking for presence of PowerShell profile files for user (primarily to import posh-git)..."
if (-not (Test-Path -Path $profile)) {
    Write-Host -Object "Creating PowerShell profiles for user (primarily to import posh-git)."
    'Import-Module -Name posh-git' | Out-File -FilePath $profile
    'Import-Module -Name posh-git' | Out-File -FilePath (Join-Path -Path (Split-Path -Path $profile -Parent) -ChildPath "Microsoft.PowerShellISE_profile.ps1")
} else {
    Write-Host -Object "PowerShell profiles already exist for this user (if they don't have posh-git yet, have them hand-edit their profile)."
}

Write-Host -Object "Enabling Windows Features"
Write-Host -Object "Enabling Windows Subsystem for Linux"
Enable-WindowsOptionalFeature -FeatureName 'Microsoft-Windows-Subsystem-Linux' -Online # After Developer Mode Enabled
Write-Host -Object "Enabling Hyper-V (will restart)"
Enable-WindowsOptionalFeature -FeatureName 'Microsoft-Hyper-V-All' -Online

Write-Host -Object 'Checking for user folder path and sub folders on the D: drive and setting reg keys for folder mappings'
$userShellFoldersRegKeyPath = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\User Shell Folders"  
$shellFoldersRegKeyPath = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders"
$userShellFolderRegKeyPropertyMappings = @(
    @{
        'Desktop'     = @{
            'FolderName'       = 'Desktop'
            'FolderParentPath' = "D:\Users\$($env:USERNAME)"
        }
    },
    @{
        'Downloads'   = @{
            'FolderName'       = 'Downloads'
            'FolderParentPath' = "D:\Users\$($env:USERNAME)"
        }
    },
    @{
        'My Music'    = @{
            'FolderName'       = 'Music'
            'FolderParentPath' = "D:\Users\$($env:USERNAME)\OneDrive"
        }
    },
    @{
        'My Pictures' = @{
            'FolderName'       = 'Pictures'
            'FolderParentPath' = "D:\Users\$($env:USERNAME)\OneDrive"
        }
    },
    @{
        'Personal'    = @{
            'FolderName'       = 'Documents'
            'FolderParentPath' = "D:\Users\$($env:USERNAME)\OneDrive"
        }
    },
    @{
        'My Video'    = @{
            'FolderName'       = 'Video'
            'FolderParentPath' = "D:\Users\$($env:USERNAME)\OneDrive"
        }
    }
)
$userShellFolderRegKeyPropertyMappings | ForEach-Object -Process {
    $regKeyName = $_.Keys | Select-Object -First 1
    $currentItem = $_[$regKeyName]
    if (-not (Test-Path -Path $currentItem.FolderParentPath -PathType Container)) {
        New-Item -Path $currentItem.FolderParentPath -ItemType Directory
    }
    if (-not (Test-Path -Path $currentItem.FolderParentPath -PathType Container)) {
        New-Item -Path "$($currentItem.FolderParentPath)\$($currentItem.FolderName)" -ItemType Directory
    }
    Set-ItemProperty -Path $userShellFoldersRegKeyPath -Name $regKeyName -Value "$($currentItem.FolderParentPath)\$($currentItem.FolderName)"
    Set-ItemProperty -Path $shellFoldersRegKeyPath -Name $regKeyName -Value "$($currentItem.FolderParentPath)\$($currentItem.FolderName)"
}
