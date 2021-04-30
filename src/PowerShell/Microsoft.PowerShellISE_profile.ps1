if ((Get-Location).Path -eq 'C:\Windows\System32') {
    Set-Location -Path $env:USERPROFILE
}

Set-PSReadlineOption -BellStyle None

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

function Invoke-ElevatedCommand {
    $runningProcess = 'powershell'
    if ((Get-Process -Id $pid).Name -eq 'powershell_ise') {
        $runningProcess = 'powershell_ise'
    }

    $identity = [System.Security.Principal.WindowsIdentity]::GetCurrent()
    $principal = New-Object System.Security.Principal.WindowsPrincipal($Identity)
    $isAdmin = $Principal.IsInRole([System.Security.Principal.WindowsBuiltInRole]::Administrator)

    if ($isAdmin) {
        & $args
        return
    }

    Start-Process -FilePath $runningProcess -Verb RunAs -WorkingDirectory $pwd.Path -ArgumentList (
        @("-NoExit", "-Command") + $args
    )
}

New-Alias -Name sudo -Value Invoke-ElevatedCommand

function Invoke-NetView {
    [CmdletBinding()]
    [OutputType([string[]])]
    param (
        [Parameter(Mandatory=$true)]
        [String]
        $Path
    )
    begin { }
    process {
        [string[]](net view $Path /all | Select-Object -Skip 7 | ?{$_ -match 'disk*'} | %{$_ -match '^(.+?)\s+Disk*'|out-null;$matches[1]})
    }
}

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

function Sync-GitOriginRemoteFromUpstream {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $false)]
        [ValidateNotNullOrEmpty()]
        [Alias('b')]
        [string]
        $Branch,

        [Parameter(Mandatory = $false)]
        [Alias('f')]
        [switch]
        $Force
    )

    begin {}

    process {
        $b = git branch --show-current
        $trunk = $null
        if ($b -notmatch '(main|master)') {
            if (git branch | Select-String -Pattern main) {
                $trunk = 'main'
                git checkout $trunk
            } else {
                $trunk = 'master'
                git checkout $trunk
            }

            if ($Force.IsPresent) {
                git branch -D $b
            }
        }

        if ($null -eq $trunk) {
            if ($null -eq (git branch | Select-String -Pattern 'main')) {
                $trunk = 'master'
            } else {
                $trunk = 'main'
            }
        }

        git pull upstream $trunk
        git push
        git remote prune origin
        if (-not [string]::IsNullOrEmpty($Branch)) {
            git branch -D $branch
        }
    }

    end {}
}

New-Alias -Name syncremote -Value Sync-GitOriginRemoteFromUpstream

function Connect-Vault {
    [CmdletBinding()]
    param ()
    vault auth -method=ldap username=$($env:USERNAME + "admin")
}

function Get-TypeAccelerators {
    [psobject].Assembly.GetType("System.Management.Automation.TypeAccelerators")::get
}
