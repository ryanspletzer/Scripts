# Script Summary
Boxstarter setup script(s) that I use to provision my home machines.

# Script Operations
* Sets Execution policy to bypass so that unsigned scripts can be ran.
* Configures PowerShell package managers.
* Updates help documentation for PowerShell.
* Configures Windows Explorer to show hidden folders and file extensions.
* Enables remote desktop and PowerShell remoting.
* Disables strange beeping in PowerShell...
* Enables Windows Features
    * Hyper-V
    * Windows Subsystem for Linux (once Developer Mode is enabled)
* Installs miscellaneous applications through package management:
    * Git for Windows
    * Notepad++
    * Google Chrome
    * Firefox
    * Slack
    * Visual Studio Code
    * NodeJS
    * f.lux
    * Sysinternals
    * Spotify
    * Remote Desktop Connection Manager
    * Steam
* Installs PowerShell modules of interest
    * Posh-Git
* Installs main applications through hosted media:
    * Visual Studio TODO: Install via OneDrive
    * Microsoft Office TODO: Install via OneDrive
    * Microsoft Visio TODO: Install via OneDrive
    * Microsoft Project TODO: Install via OneDrive
    * SQL Server Management Studio TODO: Install via OneDrive
* Installs .NET Framework 3.5.1 Feature TODO: Install via OneDrive
* Installs Windows updates. 

# Prerequisites/Assumptions
* The machine must have a fresh install of the latest release of Windows 10 x64 Enterprise ISO.
* The machine has network access to the Internet.
* Your account is an administrator on the machine.
* This script will (at some point) installs Visual Studio and Office / Project / Visio software, which assumes that you have the
  appropriate licenses to activate via your own MSDN account.

# Instructions

1. Login to your account which is an administrator on the machine.
2. Download the MachineSetupScript.ps1 file in this repository (the script) to your desktop.
3. Open PowerShell in **Administrator mode** (right-click, run as administrator).
4. Run code snippet below in the PowerShell session, replacing the local path in the query string with the local
   path that leads to your downloaded MachineSetupScript.ps1 file.

```{Powershell}
  START http://boxstarter.org/package/url?C:\Users\Ryan\Desktop\leonardoSetupScript.ps1
```
5. Follow the prompts to download the Boxstarter ClickOnce application and wait until the script starts running.
6. Within a minute or so you should be prompted for your password so that the script can automatically log back in
   to your account after restarts. Your password will be saved as an encrypted secure string for the duration of the
   script.
7. Once your password is entered, you should be able to let the script run. It will require no more interaction,
   though you may have to click OK on the legal notice that is presented by Windows prior to signing in again after
   a reboot. The duration of the script will vary based on system specifications (i.e. if you have an SSD it will go
   faster) and network speed.

# Notes

This script will restart your computer after certain installations and windows updates. Therefore, you might see the
same output a few times. This is because after a restart, the script will start from the beginning. It will not,
however, attempt to install software that is already installed.
