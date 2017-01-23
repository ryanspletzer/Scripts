# TODO: Parameterize Script for Certain Installer Paths / Tokens
# TODO: Perform symlink command for D:\Scripts -> D:\Users\<User>\Scripts

Write-Host -Object "Checking execution policy..."
if (-not (Get-ExecutionPolicy) -eq 'Bypass') {
    Set-ExecutionPolicy -ExecutionPolicy Bypass -Force
    Write-Host -Object "Execution policy has been changed to bypass."
} else {
    Write-Host -Object "Execution policy is already set to bypass."
}

Write-Host -Object "Configuring PowershellGet and Chocolatey package manager..."
Get-PackageProvider -Name chocolatey -Force
Set-PackageSource -Name chocolatey -Trusted -Force
Set-PackageSource -Name PSGallery -Trusted -Force
Write-Host -Object "Package managers set!"

Write-Host -Object "Updating Help..."
Update-Help
Write-Host -Object "Help updated!"

Write-Host -Object "Configuring Windows Explorer to show hidden folders and file extensions"
$key = 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced'
Set-ItemProperty -Path $key -Name Hidden -Value 1
Set-ItemProperty -Path $key -Name HideFileExt -Value 0
Get-Process -Name 'explorer' | Stop-Process | Invoke-Item
$key = ''
Write-Host -Object "Windows Explorer configured!"

Write-Host -Object  "Enabling remote desktop and PowerShell remoting..."
Enable-PSRemoting -Force
Set-Item -Path wsman:\localhost\client\trustedhosts -Value * -Force
Set-ItemProperty -Path 'HKLM:System\CurrentControlSet\Control\Terminal Server'-name "fDenyTSConnections" -Value 0
Enable-NetFirewallRule -DisplayGroup "Remote Desktop"
Set-ItemProperty -Path 'HKLM:System\CurrentControlSet\Control\Terminal Server\WinStations\RDP-Tcp' -name "UserAuthentication" -Value 1
Write-Host -Object "Remote desktop and PowerShell remoting enabled!"

Write-Host -Object "Disabling PowerShell beeping..."
Set-PSReadlineOption -BellStyle None

Write-Host -Object "Enabling Windows Features"
Write-Host -Object "Enabling Hyper-V (will restart)"
Enable-WindowsOptionalFeature -FeatureName 'Microsoft-Hyper-V-All' -Online
# Invoke-Reboot
Enable-WindowsOptionalFeature -FeatureName 'Microsoft-Windows-Subsystem-Linux' -Online # After Developer Mode Enabled
# Invoke-Reboot

# TODO: Add to list
Write-Host -Object "Installing miscellaneous applications..."
Start-Process -FilePath "\\resources.intranet.dow.com\Putty\putty-0.67-installer.msi" -ArgumentList /passive -Wait
Install-Package -Name git.install -Force # Invoke Installer Manually
Install-Package -Name notepadplusplus.install -Force
Install-Package -Name GoogleChrome -Force # Invoke Installer Manually
Install-Package -Name Firefox -Force # Invoke Installer Manually: 
Install-Package -Name Slack -Force
Install-Package -Name visualstudiocode -Force
Install-package -Name nodejs.install -Force
Install-Package -Name f.lux -Force
Install-Package -Name sysinternals -Force
Install-Package -Name spotify -Force
Install-Package -Name rdcman -Force
Install-Package -Name steam -Force

Write-Host -Object "Installing PowerShell modules of interest..."
Install-Module -Name 'posh-git' -Force

Write-Host -Object "Checking for Visual Studio..."
if (-not (Get-Package | Where-Object{$_.Name -like "*Visual Studio 2015*"}).Count -gt 0) {
    Write-Host -Object "Installing Visual Studio."
    # TODO: Visual Studio install via OneDrive
} else {
    Write-Host -Object "Visual Studio is already installed!"
}

Write-Host -Object "Checking for Microsoft Office..."
if (-not (Get-Package | Where-Object{$_.Name -like "Microsoft Office Professional Plus 2016*"}).Count -gt 0) {
    Write-Host -Object "Installing Microsoft Office."
    # TODO: Microsoft Office install via OneDrive
} else {
    Write-Host -Object "Microsoft Office is already installed!"
}

Write-Host -Object "Checking for Microsoft Visio..."
if (-not (Get-Package | Where-Object{$_.Name -like "Microsoft Visio Professional 2016*"}).Count -gt 0) {
    Write-Host -Object "Installing Visio."
    # TODO: Visio install via OneDrive
} else {
    Write-Host -Object "Visio is already installed!"
}

Write-Host -Object "Checking for Microsoft Project..."
if (-not (Get-Package | Where-Object{$_.Name -like "Microsoft Project Professional 2016*"}).Count -gt 0) {
    Write-Host -Object "Installing Project."
    # TODO: Project install via OneDrive
} else {
    Write-Host -Object "Project is already installed!"
}

Write-Host -Object "Checking for SQL Server Management Studio..."
if (-not (Get-Package | Where-Object{$_.Name -eq "SQL Server 2016 Management Studio"}).Count -gt 0) {
    Write-Host -Object "Installing SQL Server Management Studio."
    # TODO: SSMS install via OneDrive
} else {
    Write-Host -Object "SQL Server Management Studio is already installed!"
}

Write-Host -Object "Checking for .NET Framework 3.5.1 feature for Windows..."
if (-not ((Get-WindowsOptionalFeature -Online -FeatureName NetFx3).State -eq 'Enabled')) {
    Write-Host -Object "Installing .NET Framework 3.5.1 from latest Windows 10 media."
    # TODO: .NET Framework 3.5.1 install via OneDrive
    #$imagePath = ""
    #$image = Mount-DiskImage -ImagePath $imagePath -Access ReadOnly -StorageType ISO -PassThru
    #$driveLetter = ($image | Get-Volume).DriveLetter
    #Enable-WindowsOptionalFeature -Online -FeatureName NetFx3 -Source "$driveLetter`:\sources\sxs" -LimitAccess
    #Dismount-DiskImage -ImagePath $imagePath
} else {
    Write-Host -Object ".NET Framework 3.5.1 is already installed!"
}

Write-Host -Object "Installing Windows updates..."
#Install-WindowsUpdate -acceptEula -SuppressReboots # TODO: check for boxstarter

# TODO: Shortcut icons on taskbar

Write-Host -Object "Done! (:"
