if ((Get-Location).Path -eq 'C:\Windows\System32') {
    Set-Location -Path $env:USERPROFILE
}

Set-PSReadlineOption -BellStyle None
# Chocolatey profile
$ChocolateyProfile = "$env:ChocolateyInstall\helpers\chocolateyProfile.psm1"
if (Test-Path($ChocolateyProfile)) {
  Import-Module "$ChocolateyProfile"
}

Import-Module -Name posh-git

$GitPromptSettings.DefaultPromptAbbreviateHomeDirectory = $true
$GitPromptSettings.DefaultPromptPrefix = @'
$($env:USERNAME + '@' + $env:COMPUTERNAME + ' : ')
'@
$GitPromptSettings.DefaultPromptSuffix = @'
$("`n" + ('>' * ($nestedPromptLevel + 1)) + ' ')
'@
$global:GitPromptSettings.BeforeText = ' : ['

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
