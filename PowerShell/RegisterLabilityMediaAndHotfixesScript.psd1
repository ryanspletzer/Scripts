@{
    Registrations = @(
        #region Windows Server 2016
        @{
            Id              = "2016_x64_Standard_EN"
            FileName        = "en_windows_server_2016_x64_dvd_9718492.iso"
            Description     = "Windows Server 2016 Standard 64bit (Updated January 2017) English"
            Architecture    = "x64"
            ImageName       = "Windows Server 2016 SERVERSTANDARD"
            MediaType       = "ISO"
            OperatingSystem = "Windows"
            Uri             = $null
            Checksum        = "E02D2E482B0F3DAB915435E9040C13B4"
            CustomData = @{
                WindowsOptionalFeature = @('NetFx3')
            }
            Hotfixes = @()
        },
        @{
            Id              = "2016_x64_Standard_Core_EN"
            FileName        = "en_windows_server_2016_x64_dvd_9718492.iso"
            Description     = "Windows Server 2016 Standard Core 64bit (Updated January 2017) English"
            Architecture    = "x64"
            ImageName       = "Windows Server 2016 SERVERSTANDARDCORE"
            MediaType       = "ISO"
            OperatingSystem = "Windows"
            Uri             = $null
            Checksum        = "E02D2E482B0F3DAB915435E9040C13B4"
            CustomData = @{
                WindowsOptionalFeature = @('NetFx3')
            }
            Hotfixes = @()
        },
        @{
            Id              = "2016_x64_DataCenter_EN"
            FileName        = "en_windows_server_2016_x64_dvd_9718492.iso"
            Description     = "Windows Server 2016 Datacenter 64bit (Updated January 2017) English"
            Architecture    = "x64"
            ImageName       = "Windows Server 2016 SERVERDATACENTER"
            MediaType       = "ISO"
            OperatingSystem = "Windows"
            Uri             = $null
            Checksum        = "E02D2E482B0F3DAB915435E9040C13B4"
            CustomData = @{
                WindowsOptionalFeature = @('NetFx3')
            }
            Hotfixes = @()
        },
        @{
            Id              = "2016_x64_DataCenter_Core_EN"
            FileName        = "en_windows_server_2016_x64_dvd_9718492.iso"
            Description     = "Windows Server 2016 Datacenter Core 64bit (Updated January 2017) English"
            Architecture    = "x64"
            ImageName       = "Windows Server 2016 SERVERDATACENTERCORE"
            MediaType       = "ISO"
            OperatingSystem = "Windows"
            Uri             = $null
            Checksum        = "E02D2E482B0F3DAB915435E9040C13B4"
            CustomData = @{
                WindowsOptionalFeature = @('NetFx3')
            }
            Hotfixes = @()
        },
        @{
            Id              = "2016_x64_Standard_Nano_EN"
            FileName        = "en_windows_server_2016_x64_dvd_9718492.iso"
            Description     = "Windows Server 2016 Standard Nano 64bit (Updated January 2017) English"
            Architecture    = "x64"
            ImageName       = "Windows Server 2016 SERVERSTANDARDNANO"
            MediaType       = "ISO"
            OperatingSystem = "Windows"
            Uri             = $null
            Checksum        = "E02D2E482B0F3DAB915435E9040C13B4"
            CustomData = @{
                SetupComplete = "CoreCLR"
                PackagePath   = "\\NanoServer\Packages"
                PackageLocale = "en-US"
                WimPath       = "\\NanoServer\NanoServer.wim"
                Package       = @(
                    "Microsoft-NanoServer-Guest-Package",
                    "Microsoft-NanoServer-DSC-Package"
                )
            }
            Hotfixes = @()
        },
        @{
            Id              = "2016_x64_Datacenter_Nano_EN"
            FileName        = "en_windows_server_2016_x64_dvd_9718492.iso"
            Description     = "Windows Server 2016 Datacenter Nano 64bit (Updated January 2017) English"
            Architecture    = "x64"
            ImageName       = "Windows Server 2016 SERVERDATACENTERNANO"
            MediaType       = "ISO"
            OperatingSystem = "Windows"
            Uri             = $null
            Checksum        = "E02D2E482B0F3DAB915435E9040C13B4"
            CustomData = @{
                SetupComplete = "CoreCLR"
                PackagePath   = "\\NanoServer\Packages"
                PackageLocale = "en-US"
                WimPath       = "\\NanoServer\NanoServer.wim"
                Package       = @(
                    "Microsoft-NanoServer-Guest-Package",
                    "Microsoft-NanoServer-DSC-Package"
                )
            }
            Hotfixes = @()
        },
        #endregion
        #region Windows Server 2012 R2
        @{
            Id              = "2012R2_x64_Standard_EN"
            FileName        = "en_windows_server_2012_r2_with_update_x64_dvd_6052708.iso"
            Description     = "Windows Server 2012 R2 with Update Standard 64bit English"
            Architecture    = "x64"
            ImageName       = "Windows Server 2012 R2 SERVERSTANDARD"
            MediaType       = "ISO"
            OperatingSystem = "Windows"
            Uri             = $null
            Checksum        = "78BFF6565F178ED08AB534397FE44845"
            CustomData = @{
                WindowsOptionalFeature = @('NetFx3')
            }
            Hotfixes = @(
                #region Update Rollups
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
                },
                #endregion
                #region .NET Framework 4.6.2
                @{
                    Id  = "Windows8.1-KB3151864-x64.cab"
                    Uri = $null
                },
                #endregion
                #region .NET Framework Monthly Rollups - December 2016 KB3205404 (4 Updates)
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
                #endregion
            )
        },
        @{
            Id              = "2012R2_x64_Standard_EN_V51"
            FileName        = "en_windows_server_2012_r2_with_update_x64_dvd_6052708.iso"
            Description     = "Windows Server 2012 R2 with Update Standard 64bit English with WMF 5.1"
            Architecture    = "x64"
            ImageName       = "Windows Server 2012 R2 SERVERSTANDARD"
            MediaType       = "ISO"
            OperatingSystem = "Windows"
            Uri             = $null
            Checksum        = "78BFF6565F178ED08AB534397FE44845"
            CustomData = @{
                WindowsOptionalFeature = @('NetFx3')
            }
            Hotfixes = @(
                #region Update Rollups
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
                },
                #endregion
                #region .NET Framework 4.6.2
                @{
                    Id  = "Windows8.1-KB3151864-x64.cab"
                    Uri = $null
                },
                #endregion
                #region .NET Framework Monthly Rollups - December 2016 KB3205404 (4 Updates)
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
                },
                #endregion
                #region WMF 5.1
                @{
                    Id  = "Win8.1AndW2K12R2-KB3191564-x64.msu"
                    Uri = "https://download.microsoft.com/download/6/F/5/6F5FF66C-6775-42B0-86C4-47D41F2DA187/Win8.1AndW2K12R2-KB3191564-x64.msu"
                }
                #endregion
            )
        },
        @{
            Id              = "2012R2_x64_Standard_Core_EN"
            FileName        = "en_windows_server_2012_r2_with_update_x64_dvd_6052708.iso"
            Description     = "Windows Server 2012 R2 with Update Standard Core 64bit English"
            Architecture    = "x64"
            ImageName       = "Windows Server 2012 R2 SERVERSTANDARDCORE"
            MediaType       = "ISO"
            OperatingSystem = "Windows"
            Uri             = $null
            Checksum        = "78BFF6565F178ED08AB534397FE44845"
            CustomData = @{
                WindowsOptionalFeature = @('NetFx3')
            }
            Hotfixes = @(
                #region Update Rollups
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
                },
                #endregion
                #region .NET Framework 4.6.2
                @{
                    Id  = "Windows8.1-KB3151864-x64.cab"
                    Uri = $null
                },
                #endregion
                #region .NET Framework Monthly Rollups - December 2016 KB3205404 (4 Updates)
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
                #endregion
            )
        },
        @{
            Id              = "2012R2_x64_Standard_Core_EN_V51"
            FileName        = "en_windows_server_2012_r2_with_update_x64_dvd_6052708.iso"
            Description     = "Windows Server 2012 R2 with Update Standard Core 64bit English with WMF 5.1"
            Architecture    = "x64"
            ImageName       = "Windows Server 2012 R2 SERVERSTANDARDCORE"
            MediaType       = "ISO"
            OperatingSystem = "Windows"
            Uri             = $null
            Checksum        = "78BFF6565F178ED08AB534397FE44845"
            CustomData = @{
                WindowsOptionalFeature = @('NetFx3')
            }
            Hotfixes = @(
                #region Update Rollups
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
                #endregion
                #region .NET Framework 4.6.2
                @{
                    Id  = "Windows8.1-KB3151864-x64.cab"
                    Uri = $null
                }
                #endregion
                #region .NET Framework Monthly Rollups - December 2016 KB3205404 (4 Updates)
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
                },
                #endregion
                #region WMF 5.1
                @{
                    Id  = "Win8.1AndW2K12R2-KB3191564-x64.msu"
                    Uri = "https://download.microsoft.com/download/6/F/5/6F5FF66C-6775-42B0-86C4-47D41F2DA187/Win8.1AndW2K12R2-KB3191564-x64.msu"
                }
                #endregion
            )
        },
        @{
            Id              = "2012R2_x64_Datacenter_EN"
            FileName        = "en_windows_server_2012_r2_with_update_x64_dvd_6052708.iso"
            Description     = "Windows Server 2012 R2 with Update Datacenter 64bit English"
            Architecture    = "x64"
            ImageName       = "Windows Server 2012 R2 SERVERDATACENTER"
            MediaType       = "ISO"
            OperatingSystem = "Windows"
            Uri             = $null
            Checksum        = "78BFF6565F178ED08AB534397FE44845"
            CustomData = @{
                WindowsOptionalFeature = @('NetFx3')
            }
            Hotfixes = @(
                #region Update Rollups
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
                #endregion
                #region .NET Framework 4.6.2
                @{
                    Id  = "Windows8.1-KB3151864-x64.cab"
                    Uri = $null
                }
                #endregion
                #region .NET Framework Monthly Rollups - December 2016 KB3205404 (4 Updates)
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
                #endregion
            )
        },
        @{
            Id              = "2012R2_x64_Datacenter_EN_V51"
            FileName        = "en_windows_server_2012_r2_with_update_x64_dvd_6052708.iso"
            Description     = "Windows Server 2012 R2 with Update Datacenter 64bit English with WMF 5.1"
            Architecture    = "x64"
            ImageName       = "Windows Server 2012 R2 SERVERDATACENTER"
            MediaType       = "ISO"
            OperatingSystem = "Windows"
            Uri             = $null
            Checksum        = "78BFF6565F178ED08AB534397FE44845"
            CustomData = @{
                WindowsOptionalFeature = @('NetFx3')
            }
            Hotfixes = @(
                #region Update Rollups
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
                #endregion
                #region .NET Framework 4.6.2
                @{
                    Id  = "Windows8.1-KB3151864-x64.cab"
                    Uri = $null
                }
                #endregion
                #region .NET Framework Monthly Rollups - December 2016 KB3205404 (4 Updates)
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
                },
                #endregion
                #region WMF 5.1
                @{
                    Id  = "Win8.1AndW2K12R2-KB3191564-x64.msu"
                    Uri = "https://download.microsoft.com/download/6/F/5/6F5FF66C-6775-42B0-86C4-47D41F2DA187/Win8.1AndW2K12R2-KB3191564-x64.msu"
                }
                #endregion
            )
        },
        @{
            Id              = "2012R2_x64_Datacenter_Core_EN"
            FileName        = "en_windows_server_2012_r2_with_update_x64_dvd_6052708.iso"
            Description     = "Windows Server 2012 R2 with Update Datacenter 64bit English"
            Architecture    = "x64"
            ImageName       = "Windows Server 2012 R2 SERVERDATACENTERCORE"
            MediaType       = "ISO"
            OperatingSystem = "Windows"
            Uri             = $null
            Checksum        = "78BFF6565F178ED08AB534397FE44845"
            CustomData = @{
                WindowsOptionalFeature = @('NetFx3')
            }
            Hotfixes = @(
                #region Update Rollups
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
                #endregion
                #region .NET Framework 4.6.2
                @{
                    Id  = "Windows8.1-KB3151864-x64.cab"
                    Uri = $null
                }
                #endregion
                #region .NET Framework Monthly Rollups - December 2016 KB3205404 (4 Updates)
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
                #endregion
            )
        },
        @{
            Id              = "2012R2_x64_Datacenter_Core_EN_V51"
            FileName        = "en_windows_server_2012_r2_with_update_x64_dvd_6052708.iso"
            Description     = "Windows Server 2012 R2 with Update Datacenter 64bit English with WMF 5.1"
            Architecture    = "x64"
            ImageName       = "Windows Server 2012 R2 SERVERDATACENTERCORE"
            MediaType       = "ISO"
            OperatingSystem = "Windows"
            Uri             = $null
            Checksum        = "78BFF6565F178ED08AB534397FE44845"
            CustomData = @{
                WindowsOptionalFeature = @('NetFx3')
            }
            Hotfixes = @(
                #region Update Rollups
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
                #endregion
                #region .NET Framework 4.6.2
                @{
                    Id  = "Windows8.1-KB3151864-x64.cab"
                    Uri = $null
                }
                #endregion
                #region .NET Framework Monthly Rollups - December 2016 KB3205404 (4 Updates)
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
                },
                #endregion
                #region WMF 5.1
                @{
                    Id  = "Win8.1AndW2K12R2-KB3191564-x64.msu"
                    Uri = "https://download.microsoft.com/download/6/F/5/6F5FF66C-6775-42B0-86C4-47D41F2DA187/Win8.1AndW2K12R2-KB3191564-x64.msu"
                }
                #endregion
            )
        },
        #endregion
        #region Windows 8.1
        @{
            Id              = "WIN81_x64_Enterprise_EN"
            FileName        = "en_windows_8.1_enterprise_with_update_x64_dvd_6054382.iso"
            Description     = "Windows 8.1 with Update 64bit English"
            Architecture    = "x64"
            ImageName       = "Windows 8.1 Enterprise"
            MediaType       = "ISO"
            OperatingSystem = "Windows"
            Uri             = $null
            Checksum        = "115D7C4203417E52C09D16B50043B10D"
            CustomData = @{
                WindowsOptionalFeature = @('NetFx3')
            }
            Hotfixes = @(
                #region Update Rollups
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
                #endregion
                #region .NET Framework 4.6.2
                @{
                    Id  = "Windows8.1-KB3151864-x64.cab"
                    Uri = $null
                }
                #endregion
                #region .NET Framework Monthly Rollups - December 2016 KB3205404 (4 Updates)
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
                #endregion
            )
        },
        @{
            Id              = "WIN81_x64_Enterprise_EN_V51"
            FileName        = "en_windows_8.1_enterprise_with_update_x64_dvd_6054382.iso"
            Description     = "Windows 8.1 with Update 64bit English with WMF 5.1"
            Architecture    = "x64"
            ImageName       = "Windows 8.1 Enterprise"
            MediaType       = "ISO"
            OperatingSystem = "Windows"
            Uri             = $null
            Checksum        = "115D7C4203417E52C09D16B50043B10D"
            CustomData = @{
                WindowsOptionalFeature = @('NetFx3')
            }
            Hotfixes = @(
                #region Update Rollups
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
                #endregion
                #region .NET Framework 4.6.2
                @{
                    Id  = "Windows8.1-KB3151864-x64.cab"
                    Uri = $null
                }
                #endregion
                #region .NET Framework Monthly Rollups - December 2016 KB3205404 (4 Updates)
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
                },
                #endregion
                #region WMF 5.1
                @{
                    Id  = "Win8.1AndW2K12R2-KB3191564-x64.msu"
                    Uri = "https://download.microsoft.com/download/6/F/5/6F5FF66C-6775-42B0-86C4-47D41F2DA187/Win8.1AndW2K12R2-KB3191564-x64.msu"
                }
                #endregion
            )
        },
        @{
            Id              = "WIN81_x86_Enterprise_EN"
            FileName        = "en_windows_8.1_enterprise_with_update_x86_dvd_6050710.iso"
            Description     = "Windows 8.1 with Update 32bit English"
            Architecture    = "x64"
            ImageName       = "Windows 8.1 Enterprise"
            MediaType       = "ISO"
            OperatingSystem = "Windows"
            Uri             = $null
            Checksum        = "CE18DE710A9C025323B8DEE823BFBE7B"
            CustomData = @{
                WindowsOptionalFeature = @('NetFx3')
            }
            Hotfixes = @(
                #region Update Rollups
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
                #endregion
                #region .NET Framework 4.6.2
                @{
                    Id  = "Windows10.0-KB3151900-x86.cab"
                    Uri = $null
                }
                #endregion
                #region .NET Framework Monthly Rollups - December 2016 KB3205404 (4 Updates)
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
                #endregion
            )
        },
        @{
            Id              = "WIN81_x86_Enterprise_EN_V51"
            FileName        = "en_windows_8.1_enterprise_with_update_x86_dvd_6050710.iso"
            Description     = "Windows 8.1 with Update 32bit English with WMF 5.1"
            Architecture    = "x64"
            ImageName       = "Windows 8.1 Enterprise"
            MediaType       = "ISO"
            OperatingSystem = "Windows"
            Uri             = $null
            Checksum        = "CE18DE710A9C025323B8DEE823BFBE7B"
            CustomData = @{
                WindowsOptionalFeature = @('NetFx3')
            }
            Hotfixes = @(
                #region Update Rollups
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
                #endregion
                #region .NET Framework 4.6.2
                @{
                    Id  = "Windows10.0-KB3151900-x86.cab"
                    Uri = $null
                }
                #endregion
                #region .NET Framework Monthly Rollups - December 2016 KB3205404 (4 Updates)
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
                },
                #endregion
                #region WMF 5.1
                @{
                    Id  = "Win8.1-KB3191564-x86.msu"
                    Uri = "https://download.microsoft.com/download/6/F/5/6F5FF66C-6775-42B0-86C4-47D41F2DA187/Win8.1-KB3191564-x86.msu"
                }
                #endregion
            )
        },
        #endregion
        #region Windows 10
        @{
            Id              = "WIN10_x64_Enterprise_EN"
            FileName        = "en_windows_10_enterprise_version_1607_updated_jan_2017_x64_dvd_9714415.iso"
            Description     = "Windows 10 64bit Enterprise 1607 (Updated January 2017) English"
            Architecture    = "x64"
            ImageName       = "Windows 10 Enterprise"
            MediaType       = "ISO"
            OperatingSystem = "Windows"
            Uri             = $null
            Checksum        = "281D3ABE703D9884588B120BE74E7241"
            CustomData = @{
                WindowsOptionalFeature = @('NetFx3')
                CustomBootstrap = @(
                    "## Unattend.xml will set the Administrator password, but it won't enable the account on client OSes",
                    "NET USER Administrator /active:yes;",
                    "Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope LocalMachine -Force;",
                    "## Kick-start PowerShell remoting on clients to permit applying DSC configurations",
                    "Enable-PSRemoting -SkipNetworkProfileCheck -Force;"
                )
            }
            Hotfixes = @()
        },
        @{
            Id              = "WIN10_x86_Enterprise_EN"
            FileName        = "en_windows_10_enterprise_version_1607_updated_jan_2017_x86_dvd_9719039.iso"
            Description     = "Windows 10 32bit Enterprise 1607 (Updated January 2017) English"
            Architecture    = "x86"
            ImageName       = "Windows 10 Enterprise"
            MediaType       = "ISO"
            OperatingSystem = "Windows"
            Uri             = $null
            Checksum        = "82D2D26AC61C997AE7A1F615BDF2215C"
            CustomData = @{
                WindowsOptionalFeature = @('NetFx3')
                CustomBootstrap = @(
                    "## Unattend.xml will set the Administrator password, but it won't enable the account on client OSes",
                    "NET USER Administrator /active:yes;",
                    "Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope LocalMachine -Force;",
                    "## Kick-start PowerShell remoting on clients to permit applying DSC configurations",
                    "Enable-PSRemoting -SkipNetworkProfileCheck -Force;"
                )
            }
            Hotfixes = @()
        }
        #endregion
    )
}
