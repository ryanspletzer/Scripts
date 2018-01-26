Import-Module -Name posh-git
Set-PSReadlineOption -BellStyle None

<#
    .SYNOPSIS
        Converts a secure string to plaintext.
    .PARAMETER SecureString
        SecureString object
    .EXAMPLE
        $secureString = ConvertTo-SecureString -String "string" -AsPlainText -Force
        ConvertTo-PlainText -SecureString $secureString
#>
function ConvertTo-PlainText
{
    [CmdletBinding()]
    [OutputType([string])]
    param
    (
        [Parameter(Mandatory = $true)]
        [securestring]
        $SecureString
    )
    process
    {
        $BTSR = [System.Runtime.InteropServices.Marshal]::SecureStringToBSTR($SecureString)
        return [System.Runtime.InteropServices.Marshal]::PtrToStringAuto($BTSR)
    }
}

