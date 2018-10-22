$env:VAULT_ADDR = 'https://vault.aws.autodesk.com'
$env:PACKER_LOG = 1
$env:PACKER_LOG_PATH = 'packerlog.txt'
$env:CLOUDPCCOMPUTERNAME = 'CPSCLW10-0081.ads.autodesk.com'
$env:WORKSTATIONCOMPUTERNAME = 'NOVPC0SWSR3.ads.autodesk.com'
Set-PSReadlineOption -BellStyle None

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
        [string[]](net view $Path /all | select -Skip 7 | ?{$_ -match 'disk*'} | %{$_ -match '^(.+?)\s+Disk*'|out-null;$matches[1]})
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

