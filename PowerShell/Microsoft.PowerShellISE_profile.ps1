#Script Browser Begin
#Version: 1.3.2
Add-Type -Path 'C:\Program Files (x86)\Microsoft Corporation\Microsoft Script Browser\System.Windows.Interactivity.dll'
Add-Type -Path 'C:\Program Files (x86)\Microsoft Corporation\Microsoft Script Browser\ScriptBrowser.dll'
Add-Type -Path 'C:\Program Files (x86)\Microsoft Corporation\Microsoft Script Browser\BestPractices.dll'
$scriptBrowser = $psISE.CurrentPowerShellTab.VerticalAddOnTools.Add('Script Browser', [ScriptExplorer.Views.MainView], $true)
$scriptAnalyzer = $psISE.CurrentPowerShellTab.VerticalAddOnTools.Add('Script Analyzer', [BestPractices.Views.BestPracticesView], $true)
$psISE.CurrentPowerShellTab.VisibleVerticalAddOnTools.SelectedAddOnTool = $scriptBrowser
#Script Browser End

Set-Location -Path "D:\Scripts"
Import-Module -Name posh-git

function Enter-ElevatedPSSession {
    #requires -Version 2.0

    <#
    .SYNOPSIS
        Enters a new elevated powershell process.

    .DESCRIPTION
        Enters a new elevated powershell process. You can optionally close your existing session.

    .PARAMETER CloseExisting
        If specified, the existing powershell session will be closed.

    .NOTES
        UAC will prompt you if it is enabled.

        Starts new administrative session.

        Will do nothing if you are already running elevated.

    .EXAMPLE
        # Running as normal user
        C:\Users\Joe> Enter-ElevatedPSSession
        # Starts new PowerShell process / session as administrator, keeping current session open.

    .EXAMPLE
        # Running as normal user
        C:\Users\Joe> Enter-ElevatedPSSession -CloseExisting
        # Starts new PowerShell process / session as administrator, exiting the current session.

    .EXAMPLE
        # Running already as administrator
        C:\Windows\System32> Enter-ElevatedPSSession
        Already running as administrator.
        # Message is written to host.
    #>
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$false,
                   Position=0)]
        [Alias('c')]
        [switch]
        $CloseExisting
    )
    begin {
        $runningProcess = 'powershell'
        if ((Get-Process -Id $pid).Name -eq 'powershell_ise') {
            $runningProcess = 'powershell_ise'
        }
        $Identity = [System.Security.Principal.WindowsIdentity]::GetCurrent()
        $Principal = New-Object System.Security.Principal.WindowsPrincipal($Identity)
        $isAdmin = $Principal.IsInRole([System.Security.Principal.WindowsBuiltInRole]::Administrator)
    }
    process {
        if ($isAdmin) {
            Write-Host -Object "Already running as administrator."
            return
        }
        if ($CloseExisting.IsPresent) {
            Start-Process $runningProcess -Verb RunAs
            exit
        } else {
            Start-Process $runningProcess -Verb RunAs
        }
    }
}

New-Alias -Name su -Value Enter-ElevatedPSSession

function Open-GitRemoteUrl {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$false)]
        [string]
        $RemoteName = 'origin'
    )
    start (git remote get-url $RemoteName)
}

New-Alias -Name openremote -Value Open-GitRemoteUrl
