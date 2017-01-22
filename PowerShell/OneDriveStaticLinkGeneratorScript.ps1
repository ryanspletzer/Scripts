<#PSScriptInfo
.VERSION 0.1.1 
 
.GUID c16ff69d-fe96-421d-b7f8-dfbb46b3e9ec
 
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

function New-ODItemDownloadUri {
    [CmdletBinding()]
    [OutputType([string])]
    param (
        [Parameter(Mandatory=$true,
                   Position=0)]
        [string]
        $AccessToken,

        [Parameter(Mandatory=$true,
                   Position=1)]
        [string]
        $ItemId,

        [Parameter(Mandatory=$false,
                   Position=2)]
        [ValidateSet('view','edit','embed')]
        [string]
        $Type = 'view'
    )
    begin {
        $ODRootURI = 'https://api.onedrive.com/v1.0'
    }
    process {
        $body = @"
{
    "type": "$type"
}
"@
        $relativeUri = "/drive/items/$ItemId/action.createLink"
        $shortSharingUri = (Invoke-RestMethod -Method POST -Uri ($ODRootURI + $relativeUri) -Body $body -Headers @{
            Authorization = "Bearer " + $AccessToken 
        } -ContentType "application/json").link.webUrl
        $sharingUri = (Invoke-WebRequest -Uri $shortSharingUri).BaseResponse.ResponseUri.OriginalString
        $base64Value = [System.Convert]::ToBase64String([System.Text.Encoding]::UTF8.GetBytes($sharingUri))
        $encodedSharingUri = "u!" + $base64Value.TrimEnd('=').Replace('/','_').Replace('+','-')
        return ($ODRootURI + "/shares/$encodedSharingUri/root/content")
    }
}

$access_token = (Get-ODAuthentication -ClientID $ClientId).access_token
$leafItems = Get-ODChildItemsRecurse -AccessToken $access_token -Path $Path
$leafItems | ForEach-Object{
    $downloadUri = New-ODItemDownloadUri -AccessToken $access_token -ItemId $_.id -Type view
    Add-Member -InputObject $_ -MemberType NoteProperty -Name "downloadUri" -Value $downloadUri -Force
    Write-Output -InputObject $_
}
