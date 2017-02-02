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
    # $null in Registration Data File means we're looking for user to supply media Uri here
    if ($null -eq $currentRegistration.Uri) {
        # Checking if it was supplied in OneDriveItems
        # See .\OneDriveStaticLinkGeneratorScript.ps1 and OneDrive PS Module: https://www.powershellgallery.com/packages/OneDrive/1.0.3
        if ($null -ne $OneDriveItems) {
            $oneDriveItem = $OneDriveItems | Where-Object{
                $_.name -eq $currentRegistration.Filename
            }
            if ($null -ne $oneDriveItem) {
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
        $currentRegistration.Hotfixes = $currentRegistrationHotfixes
    }
}

$registrations | ForEach-Object {
    $currentRegistration = $_
    Register-LabMedia @currentRegistration -Force
}
