# Description: Boxstarter Script for personall use
# Author: Ryan Spletzer <ryanspletzer@gmail.com> customized and extended with a mix of my own past scripts plus Jess Frazelle's <jess@linux.com> wonderful script at https://gist.github.com/jessfraz/7c319b046daa101a4aaef937a20ff41f
# Last Updated: 2018-06-08
#
# NOTE: should be on Windows 10 1709 build minimum for the Windows Subsystem for Linux features
# 
# Change execution policy:
#   Set-ExecutionPolicy -ExecutionPolicy Bypass -Force
#
# Install chocolatey:
#   iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
#
# Install boxstarter:
# 	. { iwr -useb http://boxstarter.org/bootstrapper.ps1 } | iex; get-boxstarter -Force
# OR (preferably)
#   choco install boxstarter --yes
#
# Run this boxstarter by calling the following from an **elevated** command-prompt:
# 	start http://boxstarter.org/package/nr/url?<URL-TO-RAW-GIST>
# OR
# 	Install-BoxstarterPackage -PackageName <URL-TO-RAW-GIST> -DisableReboots
#
# OR you can import the Boxstarter module into your PowerShell session to get the cmdlets, then invoke the script, or run pieces ad hoc line by line (note this doesn't handle all the fancy restart logistics of a full boxstarter run)
#	BoxstarterShell.bat
#	.\boxstarter.ps1 -GitUserName 'John Doe' -GitEmail 'john.doe@autodesk.com' # This script -- can download manually from git.autodesk.com prior to having Git installed via this script
#
# Learn more: http://boxstarter.org/Learn/WebLauncher

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

#--- Set Execution Policy --- Note: this is not a security boundary, so relax.
Set-ExecutionPolicy -ExecutionPolicy Bypass -Force

#--- Install Chocolatey ---
iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))

#--- Install Boxstarter ---
choco install boxstarter --yes

#--- Import Boxstarter Module ---
BoxstarterShell.bat

#---- TEMPORARY ---
Disable-UAC

#---- PowerShellGet Package Manager Config ---
Write-Host -Object "Configuring PowershellGet package manager..."
Install-PackageProvider -Name NuGet -MinimumVersion 2.8.5.201 -Force
Set-PackageSource -Name PSGallery -Trusted -ForceBootstrap

#---- Set Public NetConnectionProfiles to Private
Write-Host -Object "Ensuring Public NetConnectionProfiles are set to Private..."
Get-NetConnectionProfile |
Where-Object -FilterScript { $_.NetworkCategory -eq "Public" } |
Set-NetConnectionProfile -NetworkCategory Private

#---- Disabling PowerShell beeping ---
Write-Host -Object "Disabling PowerShell beeping..."
Set-PSReadlineOption -BellStyle None

#--- Fonts ---
choco install inconsolata -y # Don't need this
  
#--- Windows Settings ---
Disable-BingSearch
Disable-GameBarTips

Set-WindowsExplorerOptions -EnableShowHiddenFilesFoldersDrives -EnableShowFileExtensions -DisableShowFrequentFoldersInQuickAccess -DisableShowRecentFilesInQuickAccess
Set-TaskbarOptions -Size Large -Dock Bottom -Combine Always -Lock # Prefer Large icons and always combining icons
# Set-TaskbarOptions -Size Large -Dock Bottom -Combine Always -AlwaysShowIconsOn # Prefer icon tray

#--- Set Time Server ---
# Get
$timeServer = Get-ItemProperty -Path HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\DateTime\Servers -Name '0' -ErrorAction SilentlyContinue
# Test
if ($timeServer -eq $null) {
	# Set
	New-ItemProperty -Path HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\DateTime\Servers -Name '0' -PropertyType String -Value 'us.pool.ntp.org'
}
Set-ItemProperty -Path HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\DateTime\Servers -Name '(default)' -Value '0'

#--- Windows Subsystems/Features ---
choco install Microsoft-Hyper-V-All -source windowsFeatures
choco install Microsoft-Windows-Subsystem-Linux -source windowsfeatures

#--- Tools ---
choco install git -params '"/WindowsTerminal /NoShellIntegration"' --yes # The only bash.exe I want on my path is the WSL one...
Install-Module -Name posh-git -Force
choco install sysinternals --yes
# choco install vim # Why?

#--- Apps ---
Write-Host -Object "Installing miscellaneous applications..."
choco install googlechrome --yes
choco install kindle --yes
choco install docker --yes
choco install docker-compose --yes
choco install lastpass --yes
choco install lastpass-for-applications --yes
choco install packer --yes
choco install vault --yes
choco install terraform --yes
choco install rdcman --yes
choco install slack --yes
choco install zoom --yes
choco install sql-operations-studio --yes
choco install sql-server-management-studio --yes
choco install servicebusexplorer --yes
choco install microsoftazurestorageexplorer --yes
choco install notepadplusplus --yes
choco install keybase --yes
choco install firefox --yes
choco install visualstudiocode --yes
choco install rsat --yes
choco install dotnetfx --yes
choco install visualstudio2017enterprise --yes
choco install dotnetcore-sdk --yes
choco install visualstudio2017-workload-azure --yes
choco install visualstudio2017-workload-data --yes
choco install visualstudio2017-workload-manageddesktop --yes
choco install visualstudio2017-workload-netcoretools --yes
choco install visualstudio2017-workload-netweb --yes
choco install visualstudio2017-workload-universal --yes
choco install windows-sdk-10.1 --yes
choco install atom --yes
choco install awscli --yes
Install-Module -Name AWSPowerShell -Force
choco install drobo-dashboard --yes

#--- Configure CredSSP Client ---
Write-Host -Object "Enabling WSManCredSSP as a client for *.ads.autodesk.com"
Enable-WSManCredSSP -Role Client -DelegateComputer * -Force

#--- Configure Git ---
Write-Host -Object "Checking git config user.name and user.email..."
if ([String]::IsNullOrWhiteSpace($(& "${env:ProgramFiles}\Git\cmd\git.exe" config --global --get user.name)) -or
    [String]::IsNullOrWhiteSpace($(& "${env:ProgramFiles}\Git\cmd\git.exe" config --global --get user.email))) {
	Write-Host -Object "Setting git config user.name and user.email."
    & "${env:ProgramFiles}\Git\cmd\git.exe" config --global user.name $GitUserName
    & "${env:ProgramFiles}\Git\cmd\git.exe" config --global user.email $GitEmail
} else {
    Write-Host -Object "git config user.name and user.email is already set for this user."
}

#--- Uninstall unecessary applications that come with Windows out of the box ---

# 3D Builder
Get-AppxPackage Microsoft.3DBuilder | Remove-AppxPackage

# Alarms
# Get-AppxPackage Microsoft.WindowsAlarms | Remove-AppxPackage I like and use this app

# Code Writer
Get-AppxPackage *ActiproSoftwareLLC* | Remove-AppxPackage

# Adobe
Get-AppxPackage *Adobe* | Remove-AppxPackage

# Autodesk
Get-AppxPackage *Autodesk* | Remove-AppxPackage # Shedding a tear :'(

# Bing Weather, News, Sports, and Finance (Money):
Get-AppxPackage Microsoft.BingFinance | Remove-AppxPackage
Get-AppxPackage Microsoft.BingNews | Remove-AppxPackage
Get-AppxPackage Microsoft.BingSports | Remove-AppxPackage
Get-AppxPackage Microsoft.BingWeather | Remove-AppxPackage

# BubbleWitch
Get-AppxPackage *BubbleWitch* | Remove-AppxPackage

# Candy Crush
Get-AppxPackage king.com.CandyCrush* | Remove-AppxPackage

# Comms Phone
Get-AppxPackage Microsoft.CommsPhone | Remove-AppxPackage

# Dell
Get-AppxPackage *Dell* | Remove-AppxPackage

# Dropbox
Get-AppxPackage *Dropbox* | Remove-AppxPackage

# Eclipse Manager (no, it has nothing to do with the Eclipse IDE)
Get-AppxPackage *EclipseManager* | Remove-AppxPackage

# Facebook
Get-AppxPackage *Facebook* | Remove-AppxPackage

# Feedback Hub
Get-AppxPackage Microsoft.WindowsFeedbackHub | Remove-AppxPackage

# Get Started
Get-AppxPackage Microsoft.Getstarted | Remove-AppxPackage

# Keeper
Get-AppxPackage *Keeper* | Remove-AppxPackage

# Mail & Calendar
Get-AppxPackage microsoft.windowscommunicationsapps | Remove-AppxPackage

# Maps
Get-AppxPackage Microsoft.WindowsMaps | Remove-AppxPackage

# March of Empires
Get-AppxPackage *MarchofEmpires* | Remove-AppxPackage

# McAfee Security
Get-AppxPackage *McAfee* | Remove-AppxPackage

# Uninstall McAfee Security App
$mcafee = gci "HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall" | foreach { gp $_.PSPath } | ? { $_ -match "McAfee Security" } | select UninstallString
if ($mcafee) {
	$mcafee = $mcafee.UninstallString -Replace "C:\Program Files\McAfee\MSC\mcuihost.exe",""
	Write "Uninstalling McAfee..."
	start-process "C:\Program Files\McAfee\MSC\mcuihost.exe" -arg "$mcafee" -Wait
}

# Messaging
Get-AppxPackage Microsoft.Messaging | Remove-AppxPackage

# Minecraft
Get-AppxPackage *Minecraft* | Remove-AppxPackage

# Netflix
Get-AppxPackage *Netflix* | Remove-AppxPackage

# Office Hub
Get-AppxPackage Microsoft.MicrosoftOfficeHub | Remove-AppxPackage

# One Connect
Get-AppxPackage Microsoft.OneConnect | Remove-AppxPackage

# OneNote
Get-AppxPackage Microsoft.Office.OneNote | Remove-AppxPackage

# People
Get-AppxPackage Microsoft.People | Remove-AppxPackage

# Phone
Get-AppxPackage Microsoft.WindowsPhone | Remove-AppxPackage

# Photos
# Get-AppxPackage Microsoft.Windows.Photos | Remove-AppxPackage # Photos is useful

# Plex
Get-AppxPackage *Plex* | Remove-AppxPackage

# Skype (Metro version)
Get-AppxPackage Microsoft.SkypeApp | Remove-AppxPackage

# Sound Recorder
Get-AppxPackage Microsoft.WindowsSoundRecorder | Remove-AppxPackage

# Solitaire
Get-AppxPackage *Solitaire* | Remove-AppxPackage

# Sticky Notes
Get-AppxPackage Microsoft.MicrosoftStickyNotes | Remove-AppxPackage

# Sway
Get-AppxPackage Microsoft.Office.Sway | Remove-AppxPackage

# Twitter
Get-AppxPackage *Twitter* | Remove-AppxPackage

# Xbox
Get-AppxPackage Microsoft.XboxApp | Remove-AppxPackage
Get-AppxPackage Microsoft.XboxIdentityProvider | Remove-AppxPackage

# Zune Music, Movies & TV
Get-AppxPackage Microsoft.ZuneMusic | Remove-AppxPackage
Get-AppxPackage Microsoft.ZuneVideo | Remove-AppxPackage

#--- Windows Settings ---
# Some from: @NickCraver's gist https://gist.github.com/NickCraver/7ebf9efbfd0c3eab72e9

# Privacy: Let apps use my advertising ID: Disable
If (-Not (Test-Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\AdvertisingInfo")) {
    New-Item -Path HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\AdvertisingInfo | Out-Null
}
Set-ItemProperty -Path HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\AdvertisingInfo -Name Enabled -Type DWord -Value 0

# WiFi Sense: HotSpot Sharing: Disable
If (-Not (Test-Path "HKLM:\Software\Microsoft\PolicyManager\default\WiFi\AllowWiFiHotSpotReporting")) {
    New-Item -Path HKLM:\Software\Microsoft\PolicyManager\default\WiFi\AllowWiFiHotSpotReporting | Out-Null
}
Set-ItemProperty -Path HKLM:\Software\Microsoft\PolicyManager\default\WiFi\AllowWiFiHotSpotReporting -Name value -Type DWord -Value 0

# WiFi Sense: Shared HotSpot Auto-Connect: Disable
Set-ItemProperty -Path HKLM:\Software\Microsoft\PolicyManager\default\WiFi\AllowAutoConnectToWiFiSenseHotspots -Name value -Type DWord -Value 0

# Start Menu: Disable Bing Search Results
Set-ItemProperty -Path HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Search -Name BingSearchEnabled -Type DWord -Value 0
# To Restore (Enabled):
# Set-ItemProperty -Path HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Search -Name BingSearchEnabled -Type DWord -Value 1

# Disable Telemetry (requires a reboot to take effect)
# Note this may break Insider builds for your organization
Set-ItemProperty -Path HKLM:\SOFTWARE\Policies\Microsoft\Windows\DataCollection -Name AllowTelemetry -Type DWord -Value 0
Get-Service DiagTrack,Dmwappushservice | Stop-Service | Set-Service -StartupType Disabled

# Change Explorer home screen back to "This PC"
Set-ItemProperty -Path HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced -Name LaunchTo -Type DWord -Value 1
# Change it back to "Quick Access" (Windows 10 default)
# Set-ItemProperty -Path HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced -Name LaunchTo -Type DWord -Value 2

# Better File Explorer
Set-ItemProperty -Path HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced -Name NavPaneExpandToCurrentFolder -Value 1
Set-ItemProperty -Path HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced -Name NavPaneShowAllFolders -Value 1
Set-ItemProperty -Path HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced -Name MMTaskbarMode -Value 2

# These make "Quick Access" behave much closer to the old "Favorites"
# Disable Quick Access: Recent Files
Set-ItemProperty -Path HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer -Name ShowRecent -Type DWord -Value 0
# Disable Quick Access: Frequent Folders
Set-ItemProperty -Path HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer -Name ShowFrequent -Type DWord -Value 0
# To Restore:
# Set-ItemProperty -Path HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer -Name ShowRecent -Type DWord -Value 1
# Set-ItemProperty -Path HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer -Name ShowFrequent -Type DWord -Value 1

# Disable the Lock Screen (the one before password prompt - to prevent dropping the first character)
If (-Not (Test-Path HKLM:\SOFTWARE\Policies\Microsoft\Windows\Personalization)) {
	New-Item -Path HKLM:\SOFTWARE\Policies\Microsoft\Windows -Name Personalization | Out-Null
}
Set-ItemProperty -Path HKLM:\SOFTWARE\Policies\Microsoft\Windows\Personalization -Name NoLockScreen -Type DWord -Value 1
# To Restore:
# Set-ItemProperty -Path HKLM:\SOFTWARE\Policies\Microsoft\Windows\Personalization -Name NoLockScreen -Type DWord -Value 1

# Lock screen (not sleep) on lid close
# Set-ItemProperty -Path 'HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager\Power' -Name AwayModeEnabled -Type DWord -Value 1 # Uh why would you do this
# To Restore:
# Set-ItemProperty -Path 'HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager\Power' -Name AwayModeEnabled -Type DWord -Value 0

# Use the Windows 7-8.1 Style Volume Mixer
# If (-Not (Test-Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\MTCUVC")) {
# 	New-Item -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion" -Name MTCUVC | Out-Null
# }
# Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\MTCUVC" -Name EnableMtcUvc -Type DWord -Value 0
# To Restore (Windows 10 Style Volume Control):
# Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\MTCUVC" -Name EnableMtcUvc -Type DWord -Value 1

# Disable Xbox Gamebar
Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\GameDVR" -Name AppCaptureEnabled -Type DWord -Value 0
Set-ItemProperty -Path "HKCU:\System\GameConfigStore" -Name GameDVR_Enabled -Type DWord -Value 0

# Turn off People in Taskbar
If (-Not (Test-Path "HKCU:SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced\People")) {
    New-Item -Path HKCU:SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced\People | Out-Null
}
Set-ItemProperty -Path "HKCU:SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced\People" -Name PeopleBand -Type DWord -Value 0

#--- Update PowerShell Help ---
Update-Help # This will throw errors at the end, don't worry -- also, run this as admin to update more modules
Update-Help -Module * # To try and catch more stuff -- also, run this as admin to update more modules

#--- Restore Temporary Settings ---
Enable-UAC
Enable-MicrosoftUpdate
Install-WindowsUpdate -acceptEula
