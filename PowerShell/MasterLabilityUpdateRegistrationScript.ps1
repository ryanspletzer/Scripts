# Master Update Script
# strategy
<#
Download WSUSOffline (No Windows Defender and exclude problem childs)
Parse log (exclude known problem childs)
Add .net 4.6.1 (not in wsus package.xml, KB3102467)
Add IE 11 (KB3021952)
Add WMF 5 / 5.1
register
make live machine (work out bugs / add to known problem childs. rinse and repeat)
aggregate recommended and optional from live machine (get-wulist / objSearch)
cross reference recommended and optional with package.xml for Uris
register
make live machine (work out bugs / add to known problem childs. rinse and repeat)
#>

#TODO: Enabling network discovery as part of DSC config
#TODO: Ignore Malicious Software Removal Tool

param (
    [Parameter(Mandatory=$true,
               Position=0)]
    [ValidateNotNullOrEmpty()]
    [string]
    $LabilityLabMediaId = "2012R2_x64_Standard_EN_V5_Eval",

    [Parameter(Mandatory=$true,
               Position=1)]
    [ValidateNotNullOrEmpty()]
    [ValidateScript({
        (Test-Path -Path $_ -PathType Leaf) -and
        ($_.EndsWith(".log"))
    })]
    [string]
    $WSUSOfflineDownloadLogPath = "D:\Users\$env:USERNAME\Utilities\wsusoffline\log\download.log",

    [Parameter(Mandatory=$true,
               Position=2)]
    [ValidateNotNullOrEmpty()]
    [ValidateScript({
        (Test-Path -Path $_ -PathType Leaf) -and
        ($_.EndsWith(".psd1"))
    })]
    [string]
    $ExcludedUpdatesData = ".\ExcludedUpdates.psd1",

    [Parameter(Mandatory=$false,
               Position=3)]
    [ValidateNotNullOrEmpty()]
    [ValidateScript({
        ($_.StartsWith('http://') -or $_.StartsWith("https://")) -and 
        $_.EndsWith('.msu')
    })]
    [string]
    $WMFUpdateUri = "https://download.microsoft.com/download/6/F/5/6F5FF66C-6775-42B0-86C4-47D41F2DA187/Win8.1AndW2K12R2-KB3191564-x64.msu", # WMF 5.1 2012 R2

    [Parameter(Mandatory=$false,
               Position=4)]
    [ValidateNotNullOrEmpty()]
    [ValidateScript({
        ($_.StartsWith('http://') -or $_.StartsWith("https://")) -and 
        $_.EndsWith('.msu')
    })]
    [string[]]
    $NetFxQualityRollupUris = @(
        "http://download.windowsupdate.com/c/msdownload/update/software/secu/2016/12/windows8.1-kb3205378-x64_30390c422203c74bdb41cc16fa796f2b643ae1f1.msu", # Dec 2016
        "http://download.windowsupdate.com/c/msdownload/update/software/secu/2016/12/windows8.1-kb3210137-x64_0c14af1d2e32174e6c138d63630fdb95339c046e.msu",
        "http://download.windowsupdate.com/c/msdownload/update/software/secu/2016/12/windows8.1-kb3210135-x64_c30336e451b9c87437060653ad42706f528c88b0.msu",
        "http://download.windowsupdate.com/c/msdownload/update/software/secu/2016/12/windows8.1-kb3210132-x64_0779132bda3eb60e10aec47647ee86770ddc4f95.msu"
    ),

    [Parameter(Mandatory=$false,
               Position=4)]
    [ValidateNotNullOrEmpty()]
    [ValidateScript({
        (Test-Path -Path $_ -PathType Leaf) -and
        ($_.EndsWith(".ps1"))
    })]
    [string]
    $ConfigurationScript = ".\Configurations\LabilityTestLabGuide2012R2StandardEvalWithICS\TestLabGuide.ps1",

    [Parameter(Mandatory=$false,
               Position=5)]
    [ValidateNotNullOrEmpty()]
    [ValidateScript({
        (Test-Path -Path $_ -PathType Leaf) -and
        ($_.EndsWith(".psd1"))
    })]
    [string]
    $ConfigurationData = ".\Configurations\LabilityTestLabGuide2012R2StandardEvalWithICS\TestLabGuide.psd1",

    [Parameter(Mandatory=$false,
               Position=6)]
    [ValidateNotNullOrEmpty()]
    [string]
    $ComputerName = "EDGE1",

    [Parameter(Mandatory=$false,
               Position=7)]
    [ValidateNotNullOrEmpty()]
    [ValidateScript({
        (Test-Path -Path $_ -PathType Leaf)
    })]
    [string]
    $OutFile = ".\$LabilityLabMediaId.Hotfixes.txt"
)

# Excluded updates that won't install offline with DISM
$importedExcludedUpdates = Import-PowerShellDataFile -Path $ExcludedUpdatesData
$specificExcludedUpdates = [string[]]@()
$customData = @{}
switch -Wildcard ($LabilityLabMediaId) {
    "2016*Nano*" {
        $specificExcludedUpdates = $importedExcludedUpdates.'2016Nano'
        break
    }
    "2016*" {
        $specificExcludedUpdates = $importedExcludedUpdates.'2016'
        $customData = @{
            WindowsOptionalFeature = @('NetFx3')
        }
        break
    }
    "2012R2*" {
        $specificExcludedUpdates = $importedExcludedUpdates.'2012R2'
        $customData = @{
            WindowsOptionalFeature = @('NetFx3')
        }
        break
    }
    "WIN81*x64*" {
        $specificExcludedUpdates = $importedExcludedUpdates.WIN81x64
        $customData = @{
            WindowsOptionalFeature = @('NetFx3')
            CustomBootstrap = @(
                "## Unattend.xml will set the Administrator password, but it won't enable the account on client OSes",
                "NET USER Administrator /active:yes;",
                "Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope LocalMachine -Force;",
                "## Kick-start PowerShell remoting on clients to permit applying DSC configurations",
                "Enable-PSRemoting -SkipNetworkProfileCheck -Force;"
            )
        }
        break
    }
    "WIN81*x86*" {
        $specificExcludedUpdates = $importedExcludedUpdates.WIN81x64
        $customData = @{
            WindowsOptionalFeature = @('NetFx3')
            CustomBootstrap = @(
                "## Unattend.xml will set the Administrator password, but it won't enable the account on client OSes",
                "NET USER Administrator /active:yes;",
                "Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope LocalMachine -Force;",
                "## Kick-start PowerShell remoting on clients to permit applying DSC configurations",
                "Enable-PSRemoting -SkipNetworkProfileCheck -Force;"
            )
        }
        break
    }
    "WIN10*x64*" {
        $specificExcludedUpdates = $importedExcludedUpdates.WIN10x86
        $customData = @{
            WindowsOptionalFeature = @('NetFx3')
            CustomBootstrap = @(
                "## Unattend.xml will set the Administrator password, but it won't enable the account on client OSes",
                "NET USER Administrator /active:yes;",
                "Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope LocalMachine -Force;",
                "## Kick-start PowerShell remoting on clients to permit applying DSC configurations",
                "Enable-PSRemoting -SkipNetworkProfileCheck -Force;"
            )
        }
        break
    }
    "WIN10*x86*" {
        $specificExcludedUpdates = $importedExcludedUpdates.WIN10x86
        $customData = @{
            WindowsOptionalFeature = @('NetFx3')
            CustomBootstrap = @(
                "## Unattend.xml will set the Administrator password, but it won't enable the account on client OSes",
                "NET USER Administrator /active:yes;",
                "Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope LocalMachine -Force;",
                "## Kick-start PowerShell remoting on clients to permit applying DSC configurations",
                "Enable-PSRemoting -SkipNetworkProfileCheck -Force;"
            )
        }
        break
    }
}

function TrimExcluded {
    param (
        [string[]]
        $Updates,

        [string[]]
        $ExcludedUpdates
    )
    $Updates | ForEach-Object{
        $currentItem = $_
        $isExcluded = $false
        $ExcludedUpdates | ForEach-Object{
            if ($currentItem -like "*$_*") {
                $isExcluded = $true
            }
        }
        if (!$isExcluded) {
            $currentItem
        }
    }
}

function PackHotfixArray {
    param (
        [string[]]
        $Updates,

        [object[]]
        $HotfixArray
    )
    if ($HotfixArray -eq $null) {
        $HotfixArray = @()
    }
    $Updates | ForEach-Object{
        $hotfix = @{
            Id  = (Split-Path -Path $_ -Leaf)
            Uri = $_.ToString()
        }
        $HotfixArray += $hotfix
    }
    $HotfixArray
}

$getWSUSUpdateUrlsSB = {
    $updateSession = New-Object -ComObject Microsoft.Update.Session
    $updateSearcher = $updateSession.CreateUpdateSearcher()
    $updateSearchResults = $updateSearcher.Search("IsInstalled = 0")
    $updateSearchResults.Updates | %{
        $currentUpdate = $_
        $currentUpdate.BundledUpdates | %{
            $currentBundledUpdate = $_
            $currentBundledUpdate.DownloadContents | %{
                $_.DownloadUrl
            }
        }
    }
}

$allWSUSOfflineDownloads = Select-String -Path $wsusOfflineDownloadLogPath -Pattern "(http://download.windowsupdate.com)[-a-zA-z0-9./]+(.cab)\b" -AllMatches | %{ $_.Matches.Value}
$trimmedUpdateList = TrimExcluded -Updates $allWSUSOfflineDownloads -ExcludedUpdates $specificExcludedUpdates
$hotfixArray = PackHotfixArray -Updates $trimmedUpdateList
$hotfixArray = PackHotfixArray -Updates $WMFUpdateUri -HotfixArray $hotfixArray

do
{
    Stop-Lab -ConfigurationData $ConfigurationData -Verbose
    Remove-LabConfiguration -ConfigurationData $ConfigurationData -Verbose
    $image = Get-LabImage -Id $LabilityLabMediaId
    Remove-Item -Path $image.ImagePath -Force
    $media = Get-LabMedia -Id $LabilityLabMediaId
    $registerLabMediaParams = @{
        Id              = $media.Id
        MediaType       = $media.MediaType
        Uri             = $media.Uri
        Architecture    = $media.Architecture
        Description     = $media.Description
        ImageName       = $media.ImageName
        FileName        = $media.FileName
        Checksum        = $media.Checksum
        CustomData      = $customData
        Hotfixes        = $hotfixArray
        OperatingSystem = $media.OperatingSystem
    }
    Register-LabMedia @registerLabMediaParams -Force
    . $ConfigurationScript
    TestLabGuide -OutputPath D:\TestLab\Configurations -ConfigurationData $ConfigurationData
    Start-LabConfiguration -ConfigurationData $ConfigurationData -Path D:\TestLab\Configurations -Verbose -Force
    Start-Lab -ConfigurationData $ConfigurationData
    $session = new-pssession -ComputerName $ComputerName -Credential (Get-credential -Message "Enable Network on VM for remote powershell session.")
    $recommendedUpdates = Invoke-Command -Session $session -ScriptBlock $getWSUSUpdateUrlsSB
    $trimmedRecommendedUpdates = $recommendedUpdates | Where-Object{$_.EndsWith(".cab")}
    $trimmedRecommendedUpdates = TrimExcluded -Updates $trimmedRecommendedUpdates -ExcludedUpdates $specificExcludedUpdates
    $hotfixArray = PackHotfixArray -Updates $trimmedRecommendedUpdates -HotfixArray $hotfixArray
}
while ($trimmedRecommendedUpdates.Count -gt 0)
if ($OutFile) {
    $format =
@'
@{
    Id  = "{0}"
    Uri = "{1}"
}
'@
    New-Item -Path $OutFile
    $hotfixes = (Get-LabMedia -Id $LabilityLabMediaId).Hotfixes | ForEach-Object{
        $format.Replace('{0}', $_.Id).Replace('{1}', $_.Uri)
    }
    Set-Content -Path $OutFile -Value $hotfixes
    Export-Clixml -Path ".\$LabilityLabMediaId.Hotfixes.xml" -InputObject ((Get-LabMedia -Id $LabilityLabMediaId).Hotfixes) -Force
}

<#
# Reconstituting the object
Import-Clixml -Path .\2012R2_x64_Standard_EN_V5_Eval.Hotfixes.xml

[hashtable[]] $testArray = ((Import-Clixml -Path .\2012R2_x64_Standard_EN_V5_Eval.Hotfixes.xml) | %{
    $ht = @{
        Id  = $_.Id
        Uri = $_.Uri
    }
    $ht
})
#>