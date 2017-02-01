#requires -Version 5
[CmdletBinding()]
[OutputType([psobject[]])]
param (
    [Parameter(Mandatory=$true)]
    [ValidateScript({
        Test-Path -Path $_ -PathType Leaf -Include "*.psd1"
    })]
    [string]
    $RegistrationData,

    [Parameter(Mandatory=$false)]
    [ValidateNotNullOrEmpty()]
    [psobject[]]
    $OneDriveItems
)

Import-Module -Name Lability
$registrations = (Import-PowerShellDataFile -Path $RegistrationData).Registrations
$registrations | ForEach-Object{
    $currentRegistration = $_
    Write-Verbose -Message "Current Registration: $($currentRegistration.Id)"
    if ($currentRegistration.Uri -eq $null) {
        if ($OneDriveItems -ne $null) {
            $oneDriveItem = $OneDriveItems | Where-Object{
                $_.name -eq $currentRegistration.Filename
            }
            if ($oneDriveItem -ne $null) {
                $currentRegistration.Uri = $oneDriveItem.downloadUri
            } else {
                $currentRegistration.Uri = Read-Host -Prompt "Please provide download URI for $($currentRegistration.Id)"
            }
        } else {
            $currentRegistration.Uri = Read-Host -Prompt "Please provide download URI for $($currentRegistration.Id)"
        }
    }
    if ($null -ne $currentRegistration.Hotfixes) {
        [hashtable[]]$currentRegistrationHotfixes = (Import-Clixml -Path ($currentRegistration.Hotfixes)) | ForEach-Object{ @{Id=$_.Id;Uri=$_.Uri}}
        $currentRegistrationHotfixes | ForEach-Object {
            if ($_.Uri -eq $null) {
                $currentHotfix = $_
                if ($OneDriveItems -ne $null) {
                    $oneDriveItem = $OneDriveItems | Where-Object{
                        $_.name -eq $currentHotfix.Id
                    }
                    if ($oneDriveItem -ne $null) {
                        $currentHotfix.Uri = $oneDriveItem.downloadUri
                    } else {
                        $currentHotfix.Uri = Read-Host -Prompt "Please provide download URI for $($currentRegistration.Id)"
                    }
                } else {
                    $currentHotfix.Uri = Read-Host -Prompt "Please provide download URI for $($currentRegistration.Id)"
                }
            }
        }
    }
    $currentRegistration.Hotfixes = $currentRegistrationHotfixes
}

$registrations | ForEach-Object {
    $currentRegistration = $_
    Register-LabMedia @currentRegistration -Force
}
