function Find-TrailingWhitespace {
    <#
        .SYNOPSIS
            Scans a given path and outputs the file paths and line numbers that contain long lines.
    #>
    [CmdletBinding()]
    [OutputType([psobject[]])]
    param (
        [Parameter(Mandatory=$true)]
        [ValidateScript({
            Test-Path -Path $_
        })]
        $Path,

        [Parameter(Mandatory=$false)]
        [Switch]
        $Recurse,

        [Parameter(Mandatory=$false)]
        [String[]]
        $Include,

        [Parameter(Mandatory=$false)]
        [String[]]
        $Exclude,

        [Parameter(Mandatory=$false)]
        [String]
        $Filter,

        [Parameter(Mandatory=$false)]
        [int]
        $LineLength = 120
    )
    process {
        $getChildItemParams = @{
            Path = $Path
            File = $true
        }
        if ($Recurse.IsPresent) {
            $getChildItemParams.Add("Recurse", $Recurse.IsPresent)
        }
        if ($null -ne $Include) {
            $getChildItemParams.Add("Include", $Include)
        }
        if ($null -ne $Exclude) {
            $getChildItemParams.Add("Exclude", $Exclude)
        }
        if ($null -ne $Filter) {
            $getChildItemParams.Add("Filter", $Filter)
        }

        Get-ChildItem @getChildItemParams | ForEach-Object {
            $currentFile = $_
            $currentLine = 1
            Get-Content -Path $currentFile.FullName | ForEach-Object {
                if ($_.GetType().Name -eq "String") {
                    if ($_.Length -gt $LineLength) {
                        Write-Output -InputObject ([PSCustomObject]@{
                            'Path' = $currentFile.FullName
                            'Line' = $currentLine
                        })
                    }
                    $currentLine++
                } else {
                    $currentLine++
                    continue
                }
            }
        }
    }
}
