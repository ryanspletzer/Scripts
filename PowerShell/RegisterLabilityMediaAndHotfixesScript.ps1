Import-Module -Name Lability

#region Windows 10 / Windows Server 2016 Definitions

#region Define Windows 10 / Windows Server 2016 .NET Framework 4.6.2 cab's
# TODO: Encode these for OneDrive API
$WIN10x64NETFX = @{
    Id  = "Windows10.0-KB3151900-x64.cab"
    Uri = "https://onedrive.live.com/embed?cid=F2F955B26E685960&resid=F2F955B26E685960%2139600&authkey=ANUwyWrqmJY5PeM"
}
$WIN10x86NETFX = @{
    Id  = "Windows10.0-KB3151900-x86.cab"
    Uri = "https://onedrive.live.com/embed?cid=F2F955B26E685960&resid=F2F955B26E685960%2139598&authkey=AJ1CoVUU35gLj0Y"
}
#endregion Define Windows 10 / Windows Server 2016 .NET Framework 4.6.2 cab's

#region Define Windows 10 1607 / Windows Server 2016 CU's
$WIN10x64CU = @{ # January 2017 KB3213986
    Id  = "windows10.0-kb3213986-x64_a1f5adacc28b56d7728c92e318d6596d9072aec4.msu"
    Uri = "http://download.windowsupdate.com/d/msdownload/update/software/secu/2016/12/windows10.0-kb3213986-x64_a1f5adacc28b56d7728c92e318d6596d9072aec4.msu"
}
$WIN10x86CU = @{ # January 2017 KB3213986
    Id  = "windows10.0-kb3213986-x86_317506223682f535a8d4832c40cea468fe3e639d.msu"
    Uri = "http://download.windowsupdate.com/c/msdownload/update/software/secu/2016/12/windows10.0-kb3213986-x86_317506223682f535a8d4832c40cea468fe3e639d.msu"
}
#endregion Define Windows 10 1607 / Windows Server 2016 CU's

#region Define Windows 10 LTSB CU's
$WIN10x64LTSBCU = @{ # January 2017 KB3210721
    Id  = "windows10.0-kb3210721-x64_b724dfc9c7e7cc2603293231ae0bcdc85e12c0f2.msu"
    Uri = "http://download.windowsupdate.com/d/msdownload/update/software/secu/2016/12/windows10.0-kb3210721-x64_b724dfc9c7e7cc2603293231ae0bcdc85e12c0f2.msu"
}
$WIN10x86LTSBCU = @{ # January 2017 KB3210721
    Id  = "windows10.0-kb3210721-x86_c87226c3031f2c70a534aff9eaf3cf5daa8057cd.msu"
    Uri = "http://download.windowsupdate.com/c/msdownload/update/software/secu/2016/12/windows10.0-kb3210721-x86_c87226c3031f2c70a534aff9eaf3cf5daa8057cd.msu"
}
#endregion Define Windows 10 LTSB CU's

#endregion Windows 10 / Windows Server 2016 Definitions

#region Windows 8.1 / Windows Server 2012 R2 Definitions

#region Define Windows 8.1 x64 / Windows Server 2012 R2 Update Rollups
$WIN81x64UR = @(
    # Reference: https://support.microsoft.com/en-us/help/24717/windows-8-1-windows-server-2012-r2-update-history
    # Some updates supersede others, like December 2016.
    @{ # July 2016 Rollup KB3172614
        Id  = 'windows8.1-kb3172614-x64_e41365e643b98ab745c21dba17d1d3b6bb73cfcc.msu'
        Uri = 'http://download.windowsupdate.com/c/msdownload/update/software/updt/2016/07/windows8.1-kb3172614-x64_e41365e643b98ab745c21dba17d1d3b6bb73cfcc.msu'
    },
    @{ # August 2016 Rollup KB3179574
        Id  = 'windows8.1-kb3179574-x64_f0a5e2ff991aec5e6978aa808f287f1b21195d6e.msu'
        Uri = 'http://download.windowsupdate.com/d/msdownload/update/software/updt/2016/08/windows8.1-kb3179574-x64_f0a5e2ff991aec5e6978aa808f287f1b21195d6e.msu'
    },
    @{ # December 2016 Rollup KB3205401
        Id  = 'windows8.1-kb3205401-x64_90deeb4a6a70f1bb72a229bf8337f058ad0071a0.msu'
        Uri = 'http://download.windowsupdate.com/c/msdownload/update/software/secu/2016/12/windows8.1-kb3205401-x64_90deeb4a6a70f1bb72a229bf8337f058ad0071a0.msu'
    }
)
$WIN81x64WMF5 = @{
    Id  = "windowsblue-kb3134758-x64_7e8778610bfe23d9eea8bea1d396a399455d7bda.msu"
    Uri = "http://download.windowsupdate.com/c/msdownload/update/software/updt/2016/03/windowsblue-kb3134758-x64_7e8778610bfe23d9eea8bea1d396a399455d7bda.msu"
}
$WIN81x86UR = @(
    # Reference: https://support.microsoft.com/en-us/help/24717/windows-8-1-windows-server-2012-r2-update-history
    # Some updates supersede others, like December 2016.
    @{ # July 2016 Rollup KB3172614
        Id  = 'windows8.1-kb3172614-x86_d11c233c8598b734de72665e0d0a3f2ef007b91f.msu'
        Uri = 'http://download.windowsupdate.com/c/msdownload/update/software/updt/2016/07/windows8.1-kb3172614-x86_d11c233c8598b734de72665e0d0a3f2ef007b91f.msu'
    },
    @{ # August 2016 Rollup KB3179574
        Id  = 'windows8.1-kb3179574-x86_8b229e05915452a38a4b22bd15783b11c9b34c9f.msu'
        Uri = 'http://download.windowsupdate.com/d/msdownload/update/software/updt/2016/08/windows8.1-kb3179574-x86_8b229e05915452a38a4b22bd15783b11c9b34c9f.msu'
    },
    @{ # December 2016 Rollup KB3205401
        Id  = 'windows8.1-kb3205401-x86_d5c630d02f0637aed32bf84d9086d2c21f40974f.msu'
        Uri = 'http://download.windowsupdate.com/c/msdownload/update/software/secu/2016/12/windows8.1-kb3205401-x86_d5c630d02f0637aed32bf84d9086d2c21f40974f.msu'
    }
)
$WIN81x86WMF5 = @{
    Id  = "windowsblue-kb3134758-x86_1e52f4b0e4de7ddd3593732f027c56a37a670a7f.msu"
    Uri = "http://download.windowsupdate.com/c/msdownload/update/software/updt/2016/03/windowsblue-kb3134758-x86_1e52f4b0e4de7ddd3593732f027c56a37a670a7f.msu"
}
#endregion Define Windows 8.1 x64 / Windows Server 2012 R2 Update Rollups

#region Define Windows 8.1 x64 / Windows Server 2012 R2 .NET Framework 4.6.2 cab's
$WIN81x64NETFX = @{
    Id  = "Windows8.1-KB3151864-x64.cab"
    Uri = "https://onedrive.live.com/embed?cid=F2F955B26E685960&resid=F2F955B26E685960%2139599&authkey=ADnONjc7lHJD0bU"
}
$WIN81x86NETFX = @{
    Id  = "Windows8.1-KB3151864-x86.cab"
    Uri = "https://onedrive.live.com/embed?cid=F2F955B26E685960&resid=F2F955B26E685960%2139597&authkey=AEb08R3w9OPR2ME"
}
#endregion Define Windows 8.1 x64 / Windows Server 2012 R2 .NET Framework 4.6.2 cab's

#region Windows 8.1 x64 / Windows Server 2012 R2 .NET Framework Monthly Rollups
$WIN81x64NETFXMR = @(
    # December 2016 KB3205404 (4 Updates)
    @{ # KB3205378
        Id  = "windows8.1-kb3205378-x64_30390c422203c74bdb41cc16fa796f2b643ae1f1.msu"
        Uri = "http://download.windowsupdate.com/c/msdownload/update/software/secu/2016/12/windows8.1-kb3205378-x64_30390c422203c74bdb41cc16fa796f2b643ae1f1.msu"
    },
    @{ # KB3210132
        Id  = "windows8.1-kb3210132-x64_0779132bda3eb60e10aec47647ee86770ddc4f95.msu"
        Uri = "http://download.windowsupdate.com/c/msdownload/update/software/secu/2016/12/windows8.1-kb3210132-x64_0779132bda3eb60e10aec47647ee86770ddc4f95.msu"
    },
    @{ # KB3210135
        Id  = "windows8.1-kb3210135-x64_c30336e451b9c87437060653ad42706f528c88b0.msu"
        Uri = "http://download.windowsupdate.com/c/msdownload/update/software/secu/2016/12/windows8.1-kb3210135-x64_c30336e451b9c87437060653ad42706f528c88b0.msu"
    },
    @{ # KB3210137
        Id  = "windows8.1-kb3210137-x64_0c14af1d2e32174e6c138d63630fdb95339c046e.msu"
        Uri = "http://download.windowsupdate.com/c/msdownload/update/software/secu/2016/12/windows8.1-kb3210137-x64_0c14af1d2e32174e6c138d63630fdb95339c046e.msu"
    }
)
$WIN81x86NETFXMR = @(
    # December 2016 KB3205404 (4 Updates)
    @{ # KB3205378
        Id  = "windows8.1-kb3205378-x86_5480b94da2521d3b8e88b23b47992b03138fdab1.msu"
        Uri = "http://download.windowsupdate.com/c/msdownload/update/software/secu/2016/12/windows8.1-kb3205378-x86_5480b94da2521d3b8e88b23b47992b03138fdab1.msu"
    },
    @{ # KB3210132
        Id  = "windows8.1-kb3210132-x86_77fde7e765393307306f8dfe41e6abed0ac77471.msu"
        Uri = "http://download.windowsupdate.com/c/msdownload/update/software/secu/2016/12/windows8.1-kb3210132-x86_77fde7e765393307306f8dfe41e6abed0ac77471.msu"
    },
    @{ # KB3210135
        Id  = "windows8.1-kb3210135-x86_7c8dab6748063871797704f87b871d556e2d411a.msu"
        Uri = "http://download.windowsupdate.com/c/msdownload/update/software/secu/2016/12/windows8.1-kb3210135-x86_7c8dab6748063871797704f87b871d556e2d411a.msu"
    },
    @{ # KB3210137
        Id  = "windows8.1-kb3210137-x86_194ef828b8e86ceeb2d8539e5b817cfc1406a8d9.msu"
        Uri = "http://download.windowsupdate.com/c/msdownload/update/software/secu/2016/12/windows8.1-kb3210137-x86_194ef828b8e86ceeb2d8539e5b817cfc1406a8d9.msu"
    }
)
#endregion Windows 8.1 x64 / Windows Server 2012 R2 .NET Framework Monthly Rollups
# TODO: Encode these for OneDrive API
#endregion Windows 8.1 / Windows Server 2012 R2 Definitions

#region Register New Media
# curl to get the redir link from the short link
# https://dev.onedrive.com/shares/shares.htm#encoding-sharing-urls
# Use Get-FileHash -Path $Path -Algorithm MD5 to get checksum

#region Windows 10 Enterprise, Version 1607 (Updated Jul 2016) (x64) - DVD (English)
$WIN10x64OutFile = "en_windows_10_enterprise_version_1607_updated_jul_2016_x64_dvd_9054264.iso"
$WIN10x64SharingUrl = "https://onedrive.live.com/redir?resid=F2F955B26E685960!38123&authkey=!AKQTCjfcKo4R1nQ"
$base64Value = [System.Convert]::ToBase64String([System.Text.Encoding]::UTF8.GetBytes($WIN10x64SharingUrl))
$encodedUrl = "u!" + $base64Value.TrimEnd('=').Replace('/','_').Replace('+','-')
$WIN10x64Api = "https://api.onedrive.com/v1.0/shares/$encodedUrl/root/content"
$WIN10x64MD5Checksum = ""
#endregion Windows 10 Enterprise, Version 1607 (Updated Jul 2016) (x64) - DVD (English)

#region Windows 10 Enterprise, Version 1607 (Updated Jul 2016) (x86) - DVD (English)
$WIN10x86OutFile = ""
$WIN10x86SharingUrl = ""
$base64Value = [System.Convert]::ToBase64String([System.Text.Encoding]::UTF8.GetBytes($WIN10x86SharingUrl))
$encodedUrl = "u!" + $base64Value.TrimEnd('=').Replace('/','_').Replace('+','-')
$WIN10x86Api = "https://api.onedrive.com/v1.0/shares/$encodedUrl/root/content"
$WIN10x86MD5Checksum = ""
#endregion Windows 10 Enterprise, Version 1607 (Updated Jul 2016) (x86) - DVD (English)

#region Windows Server 2016 (x64) - DVD (English) (January 2017)
$2016OutFile = "en_windows_server_2016_x64_dvd_9718492.iso"
$2016SharingUrl = "https://onedrive.live.com/redir?resid=F2F955B26E685960!39609&authkey=!AD5QPtRsh1E9gqM"
$base64Value = [System.Convert]::ToBase64String([System.Text.Encoding]::UTF8.GetBytes($2016SharingURL))
$encodedUrl = "u!" + $base64Value.TrimEnd('=').Replace('/','_').Replace('+','-')
$2016Api = "https://api.onedrive.com/v1.0/shares/$encodedUrl/root/content"
$2016MD5Checksum = ""
#endregion Windows Server 2016 (x64) - DVD (English) (January 2017)

#region Windows 8.1 Enterprise with Update (x64) - DVD (English) (December 2014)
$WIN81x64OutFile = "en_windows_8.1_enterprise_with_update_x64_dvd_6054382.iso"
$WIN81x64SharingUrl = "https://onedrive.live.com/redir?resid=F2F955B26E685960!39602&authkey=!AOGxyrko7AW77QA"
$base64Value = $base64Value = [System.Convert]::ToBase64String([System.Text.Encoding]::UTF8.GetBytes($WIN81x64SharingUrl))
$WIN81x64Api = "u!" + $base64Value.TrimEnd('=').Replace('/','_').Replace('+','-')
$WIN81x64MD5Checksum = ""
#endregion

#region Windows 8.1 Enterprise with Update (x86) - DVD (English) (December 2014)
$WIN81x86OutFile = ""
$WIN81x86SharingUrl = ""
$base64Value = $base64Value = [System.Convert]::ToBase64String([System.Text.Encoding]::UTF8.GetBytes($WIN81x86SharingUrl))
$WIN81x86Api = "u!" + $base64Value.TrimEnd('=').Replace('/','_').Replace('+','-')
$WIN81x86MD5Checksum = ""
#endregion

#region Windows Server 2012 R2 with Update (x64) - DVD (English) (December 2014)
$2012R2OutFile = "en_windows_server_2012_r2_with_update_x64_dvd_6052708.iso"
$2012R2SharingUrl = "https://onedrive.live.com/redir?resid=F2F955B26E685960!39603&authkey=!AJTTe9JiT95w1F8"
$base64Value = [System.Convert]::ToBase64String([System.Text.Encoding]::UTF8.GetBytes($2012R2SharingURL))
$encodedUrl = "u!" + $base64Value.TrimEnd('=').Replace('/','_').Replace('+','-')
$2012R2Api = "https://api.onedrive.com/v1.0/shares/$encodedUrl/root/content"
$2012R2MD5Checksum = ""
#endregion
#endregion Register New Media

#region Register All Hotfixes
$win10 = $null
$win81 = $null
(Get-LabMedia).ForEach{
    Write-Host $_.Id
    switch -wildcard ($_) {
        {
            ($_.Id -like "WIN10*") -or ($_.Id -like "2016*")
        } {
            $newWin10 = @{
                Id              = $_.Id
                Architecture    = $_.Architecture
                MediaType       = $_.MediaType
                Uri             = $_.Uri
                Checksum        = $_.Checksum
                ImageName       = $_.ImageName
                Description     = $_.Description
                Hotfixes        = $(
                    if ($_.Id -like "*NANO*") {
                        @([hashtable]::new())
                    } else {
                        switch -wildcard ($_)  {
                            {
                                (-not ($_.Id -like "*LTSB*")) -and
                                ($_.Architecture -eq "x64")
                            } {
                                @($WIN10x64NETFX, $WIN10x64CU)
                            }
                            {
                                ($_.Id -like "*LTSB*") -and
                                ($_.Architecture -eq "x64")
                            } {
                                @($WIN10x64NETFX, $WIN10LTSBx64CU)
                            }
                            {
                                (-not ($_.Id -like "*LTSB*")) -and
                                ($_.Architecture -eq "x86")
                            } {
                                @($WIN10x86NETFX, $WIN10x86CU)
                            }
                            {
                                ($_.Id -like "*LTSB*") -and
                                ($_.Architecture -eq "x86")
                            } {
                                @($WIN10x86NETFX, $WIN10LTSBx86CU)
                            }
                        }
                    }
                )
                OperatingSystem = $_.OperatingSystem
                CustomData = $(
                    if ($_.Id -like "*NANO*") {
                        @{
                            SetupComplete = "CoreCLR"
                            PackagePath   = "\\NanoServer\Packages"
                            WimPath       = "\\NanoServer\NanoServer.wim"
                            Package       = @(
                                "Microsoft-NanoServer-Guest-Package",
                                "Microsoft-NanoServer-DSC-Package"
                            )
                        }
                    } else {
                        if ($_.Id -like "2016*") {
                            @{
                                WindowsOptionalFeature = @('NetFx3')
                            }
                        } else {
                            @{
                                WindowsOptionalFeature = @('NetFx3')
                                CustomBootstrap = @(
                                    "## Unattend.xml will set the Administrator password, but it won't enable the account on client OSes",
                                    "NET USER Administrator /active:yes;",
                                    "Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope LocalMachine -Force;",
                                    "## Kick-start PowerShell remoting on clients to permit applying DSC configurations",
                                    "Enable-PSRemoting -SkipNetworkProfileCheck -Force;"
                                ) 
                            }
                        }
                    }
                )
            }
            Register-LabMedia @newWin10 -Force
        }
        {
            ($_.Id -like "WIN81*") -or ($_.Id -like "2012R2*")
        } {
            $newWin81 = @{
                Id              = $_.Id
                Architecture    = $_.Architecture
                MediaType       = $_.MediaType
                Uri             = $_.Uri
                Checksum        = $_.Checksum
                ImageName       = $_.ImageName
                Description     = $_.Description
                Hotfixes        = $(
                    switch -wildcard ($_) {
                        {
                            ($_ -like "*V5*") -and
                            ($_.Architecture -eq "x64")
                        } {
                            $WIN81x64UR + $WIN81x64WMF5 + $WIN81x64NETFX + $WIN81x64NETFXMR
                        }
                        {
                            (-not ($_.Id -like "*V5*")) -and
                            ($_.Architecture -eq "x64")
                        } {
                            $WIN81x64UR + $WIN81x64NETFX + $WIN81x64NETFXMR
                        }
                        {
                            ($_.Id -like "*V5*") -and
                            ($_.Architecture -eq "x86")
                        } {
                            $WIN81x86UR + $WIN81x64WMF5 + $WIN81x64NETFX + $WIN81x86NETFXMR
                        }
                        {
                            (-not ($_.Id -like "*V5*")) -and
                            ($_.Architecture -eq "x86")
                        } {
                            $WIN81x86UR + $WIN81x64NETFX + $WIN81x86NETFXMR
                        }
                    }
                )
                OperatingSystem = $_.OperatingSystem
                CustomData      = $(
                    if ($_.Id -like "2012R2*") {
                        @{
                            WindowsOptionalFeature = @('NetFx3')
                        }
                    } else {
                        @{
                            WindowsOptionalFeature = @('NetFx3')
                            CustomBootstrap = @(
                                "## Unattend.xml will set the Administrator password, but it won't enable the account on client OSes",
                                "NET USER Administrator /active:yes;",
                                "Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope LocalMachine -Force;",
                                "## Kick-start PowerShell remoting on clients to permit applying DSC configurations",
                                "Enable-PSRemoting -SkipNetworkProfileCheck -Force;"
                            ) 
                        }
                    }
                )
            }
            Register-LabMedia @newWin81 -Force
        }
    }
}
#endregion Register All Hotfixes
