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

# Excluded updates that won't install offline with DISM
$excluded = @{
    '2012R2' = @(
        'kb2978742',
        'kb3150220',
        'kb2894853',
        'kb3025417',
        'kb2876331',
        'kb3062760',
        'kb3155178',
        'kb2939153',
        'kb3038936',
        'kb2934520' #NET452
    )
}

$wsusOfflineDownloadLogPath = "D:\Users\rspletzer\Utilities\wsusoffline109\wsusoffline\log\download.log"
$allWSUSOfflineDownloads = Select-String -Path $wsusOfflineDownloadLogPath -Pattern "(http://download.windowsupdate.com)[-a-zA-z0-9./]+(.cab)\b" -AllMatches | %{ $_.Matches.Value}
$trimmedList = $allWSUSOfflineDownloads | %{
    $currentItem = $_
    $isExcluded = $false
    $excluded.'2012R2' | %{
        if ($currentItem -like "*$_*") {
            $isExcluded = $true
        }
    }
    if (!$isExcluded) {
        $currentItem
    }
}
$hotfixArray = @()
$trimmedList | %{
    $hotfix = @{
        Id  = (Split-Path -Path $_ -Leaf)
        Uri = $_
    }
    $hotfixArray += $hotfix
}

$wmf51 = @{
    Id  = "Win8.1AndW2K12R2-KB3134758-x64.msu"
    Uri = "https://download.microsoft.com/download/2/C/6/2C6E1B4A-EBE5-48A6-B225-2D2058A9CEFB/Win8.1AndW2K12R2-KB3134758-x64.msu"
}

$hotfixArray += $wmf51

$media = Get-LabMedia -Id 2012R2_x64_Standard_EN_V5_Eval
$registerLabMediaParams = @{
    Id              = $media.Id
    MediaType       = $media.MediaType
    Uri             = $media.Uri
    Architecture    = $media.Architecture
    Description     = $media.Description
    ImageName       = $media.ImageName
    FileName        = $media.FileName
    Checksum        = $media.Checksum
    CustomData      = @{
        WindowsOptionalFeature = @('NetFx3')
    }
    Hotfixes        = $hotfixArray
    OperatingSystem = $media.OperatingSystem
}
Register-LabMedia @registerLabMediaParams -Force
. .\Configurations\LabilityTestLabGuide2012R2StandardEvalWithICS\TestLabGuide.ps1
TestLabGuide -OutputPath D:\TestLab\Configurations -ConfigurationData .\Configurations\LabilityTestLabGuide2012R2StandardEvalWithICS\TestLabGuide.psd1
Start-LabConfiguration -ConfigurationData .\Configurations\LabilityTestLabGuide2012R2StandardEvalWithICS\TestLabGuide.psd1 -Path D:\TestLab\Configurations -Verbose -Force
$session = new-pssession -ComputerName EDGE1 -Credential (Get-credential)
$recommendedUpdates = Invoke-Command -Session $session -ScriptBlock { 
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
$trimmedRecommendedUpdates = $recommendedUpdates | ?{$_.EndsWith(".cab")}
$trimmedRecommendedUpdates = $trimmedRecommendedUpdates | %{
    $currentItem = $_
    $isExcluded = $false
    $excluded.'2012R2' | %{
        if ($currentItem -like "*$_*") {
            $isExcluded = $true
        }
    }
    if (!$isExcluded) {
        $currentItem
    }
}
$trimmedRecommendedUpdates | %{
    $hotfix = @{
        Id  = (Split-Path -Path $_ -Leaf)
        Uri = $_.ToString()
    }
    $hotfixArray += $hotfix
}
$registerLabMediaParams = @{
    Id              = $media.Id
    MediaType       = $media.MediaType
    Uri             = $media.Uri
    Architecture    = $media.Architecture
    Description     = $media.Description
    ImageName       = $media.ImageName
    FileName        = $media.FileName
    Checksum        = $media.Checksum
    CustomData      = @{
        WindowsOptionalFeature = @('NetFx3')
    }
    Hotfixes        = $hotfixArray
    OperatingSystem = $media.OperatingSystem
}
Register-LabMedia @registerLabMediaParams -Force
Stop-Lab -ConfigurationData .\Configurations\LabilityTestLabGuide2012R2StandardEvalWithICS\TestLabGuide.psd1 -Verbose
Remove-LabConfiguration -ConfigurationData .\Configurations\LabilityTestLabGuide2012R2StandardEvalWithICS\TestLabGuide.psd1 -Verbose
$image = Get-LabImage -Id 2012R2_x64_Standard_EN_V5_Eval
Remove-Item -Path $image.ImagePath -Force
. .\Configurations\LabilityTestLabGuide2012R2StandardEvalWithICS\TestLabGuide.ps1
TestLabGuide -OutputPath D:\TestLab\Configurations -ConfigurationData .\Configurations\LabilityTestLabGuide2012R2StandardEvalWithICS\TestLabGuide.psd1
Start-LabConfiguration -ConfigurationData .\Configurations\LabilityTestLabGuide2012R2StandardEvalWithICS\TestLabGuide.psd1 -Path D:\TestLab\Configurations -Verbose -Force
$session = new-pssession -ComputerName EDGE1 -Credential (Get-credential)
$recommendedUpdates = Invoke-Command -Session $session -ScriptBlock { 
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
$trimmedRecommendedUpdates = $recommendedUpdates | ?{$_.EndsWith(".cab")}
$trimmedRecommendedUpdates = $trimmedRecommendedUpdates | %{
    $currentItem = $_
    $isExcluded = $false
    $excluded.'2012R2' | %{
        if ($currentItem -like "*$_*") {
            $isExcluded = $true
        }
    }
    if (!$isExcluded) {
        $currentItem
    }
}
$trimmedRecommendedUpdates | %{
    $hotfix = @{
        Id  = (Split-Path -Path $_ -Leaf)
        Uri = $_.ToString()
    }
    $hotfixArray += $hotfix
}
$registerLabMediaParams = @{
    Id              = $media.Id
    MediaType       = $media.MediaType
    Uri             = $media.Uri
    Architecture    = $media.Architecture
    Description     = $media.Description
    ImageName       = $media.ImageName
    FileName        = $media.FileName
    Checksum        = $media.Checksum
    CustomData      = @{
        WindowsOptionalFeature = @('NetFx3')
    }
    Hotfixes        = $hotfixArray
    OperatingSystem = $media.OperatingSystem
}
Register-LabMedia @registerLabMediaParams -Force
Stop-Lab -ConfigurationData .\Configurations\LabilityTestLabGuide2012R2StandardEvalWithICS\TestLabGuide.psd1 -Verbose
Remove-LabConfiguration -ConfigurationData .\Configurations\LabilityTestLabGuide2012R2StandardEvalWithICS\TestLabGuide.psd1 -Verbose
$image = Get-LabImage -Id 2012R2_x64_Standard_EN_V5_Eval
Remove-Item -Path $image.ImagePath -Force
. .\Configurations\LabilityTestLabGuide2012R2StandardEvalWithICS\TestLabGuide.ps1
TestLabGuide -OutputPath D:\TestLab\Configurations -ConfigurationData .\Configurations\LabilityTestLabGuide2012R2StandardEvalWithICS\TestLabGuide.psd1
Start-LabConfiguration -ConfigurationData .\Configurations\LabilityTestLabGuide2012R2StandardEvalWithICS\TestLabGuide.psd1 -Path D:\TestLab\Configurations -Verbose -Force