<#PSScriptInfo
.VERSION 0.1.1 
 
.GUID 93dfb2d8-1330-49b7-a86c-0d9ff8b44846 
 
.AUTHOR Ryan Spletzer
 
.COMPANYNAME The Dow Chemical Company
 
.COPYRIGHT 
 
.TAGS 
 
.LICENSEURI 
 
.PROJECTURI 
 
.ICONURI 
 
.EXTERNALMODULEDEPENDENCIES 
 
.REQUIREDSCRIPTS 
 
.EXTERNALSCRIPTDEPENDENCIES 
 
.RELEASENOTES
 
#>

<#
.DESCRIPTION
    I use this script to get static download links that are curl-able for items that I have in my OneDrive.

.NOTES
    Requires the registration of a client app for OAuth 2.0 authentication to OneDrive.

#>
[CmdletBinding()]
[OutputType([psobject])]
param(
    [Parameter(Mandatory=$true,
               Position=0)]
    [string]
    $ClientId,
    
    [Parameter(Mandatory=$false,
               Position = 1)]
    [string]
    $Path = "/"
)

$access_token = (Get-ODAuthentication -ClientID $ClientId).access_token

function Get-ODChildItemsRecurse {
    [CmdletBinding()]
    [OutputType([psobject])]
    param (
        [Parameter(Mandatory=$true,
                   Position=0)]
        [string]
        $AccessToken,
        
        [Parameter(Mandatory=$true,
                   Position=1)]
        [string]
        $Path = "/",

        [Parameter(Mandatory=$false,
                   Position=2)]
        [string]
        $SelectProperties = 'name,size,lastModifiedDateTime,id'
    )

    process {
        Get-ODChildItems -AccessToken $AccessToken -Path $Path -SelectProperties $SelectProperties | ForEach-Object{
            if ($_.folder -ne $null) {
                if ($_.folder.childCount -gt 0) {
                    Get-ODChildItemsRecurse -AccessToken $AccessToken -Path "$Path/$($_.name)" -SelectProperties $SelectProperties
                }
            } else {
                    Write-Output -InputObject $_
            }
        }
    }
}
