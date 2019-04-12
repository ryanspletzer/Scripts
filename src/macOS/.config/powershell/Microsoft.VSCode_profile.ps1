$env:VAULT_ADDR = 'https://vault.aws.autodesk.com'
$env:PACKER_LOG = 1
$env:PACKER_LOG_PATH = 'packerlog.txt'
$env:CLOUDPCCOMPUTERNAME = 'CPSCLW10-0081.ads.autodesk.com'
$env:WORKSTATIONCOMPUTERNAME = 'NOVPC0SWSR3.ads.autodesk.com'
Import-Module -Name posh-git
Set-Alias -Name code -Value /usr/local/bin/code
# Import the module into the PowerShell session
# Import-Module Az
# Enable AzureRM aliases for the user
# Enable-AzureRmAlias -Scope CurrentUser

function Open-GitRemoteUrl {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$false)]
        [string]
        $RemoteName = 'origin'
    )
    Start-Process (git remote get-url $RemoteName)
}

New-Alias -Name openremote -Value Open-GitRemoteUrl
