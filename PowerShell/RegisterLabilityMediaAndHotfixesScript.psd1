@{
    Registrations = @(
        #region Custom

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
            Hotfixes = '.\2016_x64_Standard_EN_Eval.Hotfixes.xml'
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
            Hotfixes = '.\2016_x64_Standard_EN_Eval.Hotfixes.xml'
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
            Hotfixes = '.\2016_x64_Standard_EN_Eval.Hotfixes.xml'
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
            Hotfixes = '.\2016_x64_Standard_EN_Eval.Hotfixes.xml'
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
            Hotfixes = '.\2016_x64_Standard_EN_Eval.Hotfixes.xml'
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
            Hotfixes = '.\2016_x64_Standard_EN_Eval.Hotfixes.xml'
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
            Hotfixes = '.\2012R2_x64_Standard_EN_Eval.Hotfixes.xml'
        },
        @{
            Id              = "2012R2_x64_Standard_EN_V5"
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
            Hotfixes = '.\2012R2_x64_Standard_EN_V5_Eval.Hotfixes.xml'
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
            Hotfixes = '.\2012R2_x64_Standard_EN_Eval.Hotfixes.xml'
        },
        @{
            Id              = "2012R2_x64_Standard_Core_EN_V5"
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
            Hotfixes = '.\2012R2_x64_Standard_EN_V5_Eval.Hotfixes.xml'
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
            Hotfixes = '.\2012R2_x64_Standard_EN_Eval.Hotfixes.xml'
        },
        @{
            Id              = "2012R2_x64_Datacenter_EN_V5"
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
            Hotfixes = '.\2012R2_x64_Standard_EN_V5_Eval.Hotfixes.xml'
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
            Hotfixes = '.\2012R2_x64_Standard_EN_Eval.Hotfixes.xml'
        },
        @{
            Id              = "2012R2_x64_Datacenter_Core_EN_V5"
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
            Hotfixes = '.\2012R2_x64_Standard_EN_V5_Eval.Hotfixes.xml'
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
            Hotfixes = '.\2012R2_x64_Standard_EN_Eval.Hotfixes.xml'
        },
        @{
            Id              = "WIN81_x64_Enterprise_EN_V5"
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
            Hotfixes = '.\2012R2_x64_Standard_EN_V5_Eval.Hotfixes.xml'
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
            Hotfixes = '.\WIN81_x86_Enterprise_EN_Eval.Hotfixes.xml'
        },
        @{
            Id              = "WIN81_x86_Enterprise_EN_V5"
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
            Hotfixes = '.\WIN81_x86_Enterprise_EN_V5_Eval.Hotfixes.xml'
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
            Hotfixes = '.\WIN10_x64_Enterprise_EN_Eval.Hotfixes.xml'
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
            Hotfixes = '.\WIN10_x86_Enterprise_EN_Eval.Hotfixes.xml'
        },
        @{
            Id              = "WIN10_x64_Enterprise_LTSB_EN"
            FileName        = "en_windows_10_enterprise_2016_ltsb_x86_dvd_9060010.iso"
            Description     = "Windows 10 64bit Enterprise 2016 English Evaluation"
            Architecture    = "x64"
            ImageName       = "Windows 10 Enterprise"
            MediaType       = "ISO"
            OperatingSystem = "Windows"
            Uri             = $null
            Checksum        = "E39EA2AF41B3710682FE3BBDAC35EC9A"
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
            Hotfixes = '.\WIN10_x64_Enterprise_LTSB_EN_Eval.Hotfixes.xml'
        },
        @{
            Id              = "WIN10_x86_Enterprise_LTSB_EN"
            FileName        = "en_windows_10_enterprise_version_1607_updated_jan_2017_x86_dvd_9719039.iso"
            Description     = "Windows 10 32bit Enterprise 2016 English Evaluation"
            Architecture    = "x86"
            ImageName       = "Windows 10 Enterprise"
            MediaType       = "ISO"
            OperatingSystem = "Windows"
            Uri             = $null
            Checksum        = "6FFB9B81FDE69EA4B5A2764F93D8B245"
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
            Hotfixes = '.\WIN10_x64_Enterprise_LTSB_EN_Eval.Hotfixes.xml'
        }
        #endregion

        #endregion

        #region Eval

        #region Windows Server 2016
        @{
            Id              = "2016_x64_Standard_EN_Eval"
            FileName        = "2016_x64_EN_Eval.iso"
            Description     = "Windows Server 2016 Standard 64bit English Evaluation"
            Architecture    = "x64"
            ImageName       = "Windows Server 2016 SERVERSTANDARD"
            MediaType       = "ISO"
            OperatingSystem = "Windows"
            Uri             = "http://download.microsoft.com/download/1/6/F/16FA20E6-4662-482A-920B-1A45CF5AAE3C/14393.0.160715-1616.RS1_RELEASE_SERVER_EVAL_X64FRE_EN-US.ISO"
            Checksum        = "18A4F00A675B0338F3C7C93C4F131BEB"
            CustomData = @{
                WindowsOptionalFeature = @('NetFx3')
            }
            Hotfixes = '.\2016_x64_Standard_EN_Eval.Hotfixes.xml'
        },
        @{
            Id              = "2016_x64_Standard_Core_EN_Eval"
            FileName        = "2016_x64_EN_Eval.iso"
            Description     = "Windows Server 2016 Standard Core 64bit English Evaluation"
            Architecture    = "x64"
            ImageName       = "Windows Server 2016 SERVERSTANDARDCORE"
            MediaType       = "ISO"
            OperatingSystem = "Windows"
            Uri             = "http://download.microsoft.com/download/1/6/F/16FA20E6-4662-482A-920B-1A45CF5AAE3C/14393.0.160715-1616.RS1_RELEASE_SERVER_EVAL_X64FRE_EN-US.ISO"
            Checksum        = "18A4F00A675B0338F3C7C93C4F131BEB"
            CustomData = @{
                WindowsOptionalFeature = @('NetFx3')
            }
            Hotfixes = '.\2016_x64_Standard_EN_Eval.Hotfixes.xml'
        },
        @{
            Id              = "2016_x64_DataCenter_EN_Eval"
            FileName        = "2016_x64_EN_Eval.iso"
            Description     = "Windows Server 2016 Datacenter 64bit English Evaluation"
            Architecture    = "x64"
            ImageName       = "Windows Server 2016 SERVERDATACENTER"
            MediaType       = "ISO"
            OperatingSystem = "Windows"
            Uri             = "http://download.microsoft.com/download/1/6/F/16FA20E6-4662-482A-920B-1A45CF5AAE3C/14393.0.160715-1616.RS1_RELEASE_SERVER_EVAL_X64FRE_EN-US.ISO"
            Checksum        = "18A4F00A675B0338F3C7C93C4F131BEB"
            CustomData = @{
                WindowsOptionalFeature = @('NetFx3')
            }
            Hotfixes = '.\2016_x64_Standard_EN_Eval.Hotfixes.xml'
        },
        @{
            Id              = "2016_x64_DataCenter_Core_EN_Eval"
            FileName        = "2016_x64_EN_Eval.iso"
            Description     = "Windows Server 2016 Datacenter Core 64bit English Evaluation"
            Architecture    = "x64"
            ImageName       = "Windows Server 2016 SERVERDATACENTERCORE"
            MediaType       = "ISO"
            OperatingSystem = "Windows"
            Uri             = "http://download.microsoft.com/download/1/6/F/16FA20E6-4662-482A-920B-1A45CF5AAE3C/14393.0.160715-1616.RS1_RELEASE_SERVER_EVAL_X64FRE_EN-US.ISO"
            Checksum        = "18A4F00A675B0338F3C7C93C4F131BEB"
            CustomData = @{
                WindowsOptionalFeature = @('NetFx3')
            }
            Hotfixes = '.\2016_x64_Standard_EN_Eval.Hotfixes.xml'
        },
        @{
            Id              = "2016_x64_Standard_Nano_EN_Eval"
            FileName        = "2016_x64_EN_Eval.iso"
            Description     = "Windows Server 2016 Standard Nano 64bit English Evaluation"
            Architecture    = "x64"
            ImageName       = "Windows Server 2016 SERVERSTANDARDNANO"
            MediaType       = "ISO"
            OperatingSystem = "Windows"
            Uri             = "http://download.microsoft.com/download/1/6/F/16FA20E6-4662-482A-920B-1A45CF5AAE3C/14393.0.160715-1616.RS1_RELEASE_SERVER_EVAL_X64FRE_EN-US.ISO"
            Checksum        = "18A4F00A675B0338F3C7C93C4F131BEB"
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
            Hotfixes = '.\2016_x64_Standard_EN_Eval.Hotfixes.xml'
        },
        @{
            Id              = "2016_x64_Datacenter_Nano_EN"
            FileName        = "2016_x64_EN_Eval.iso"
            Description     = "Windows Server 2016 Datacenter Nano 64bit English Evaluation"
            Architecture    = "x64"
            ImageName       = "Windows Server 2016 SERVERDATACENTERNANO"
            MediaType       = "ISO"
            OperatingSystem = "Windows"
            Uri             = "http://download.microsoft.com/download/1/6/F/16FA20E6-4662-482A-920B-1A45CF5AAE3C/14393.0.160715-1616.RS1_RELEASE_SERVER_EVAL_X64FRE_EN-US.ISO"
            Checksum        = "18A4F00A675B0338F3C7C93C4F131BEB"
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
            Hotfixes = '.\2016_x64_Standard_EN_Eval.Hotfixes.xml'
        },
        #endregion

        #region Windows Server 2012 R2
        @{
            Id              = "2012R2_x64_Standard_EN"
            FileName        = "2012R2_x64_EN_Eval.iso"
            Description     = "Windows Server 2012 R2 with Update Standard 64bit English Evaluation"
            Architecture    = "x64"
            ImageName       = "Windows Server 2012 R2 SERVERSTANDARD"
            MediaType       = "ISO"
            OperatingSystem = "Windows"
            Uri             = "http://download.microsoft.com/download/6/2/A/62A76ABB-9990-4EFC-A4FE-C7D698DAEB96/9600.17050.WINBLUE_REFRESH.140317-1640_X64FRE_SERVER_EVAL_EN-US-IR3_SSS_X64FREE_EN-US_DV9.ISO"
            Checksum        = "5B5E08C490AD16B59B1D9FAB0DEF883A"
            CustomData = @{
                WindowsOptionalFeature = @('NetFx3')
            }
            Hotfixes = '.\2012R2_x64_Standard_EN_Eval.Hotfixes.xml'
        },
        @{
            Id              = "2012R2_x64_Standard_EN_V5"
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
            Hotfixes = '.\2012R2_x64_Standard_EN_V5_Eval.Hotfixes.xml'
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
            Hotfixes = '.\2012R2_x64_Standard_EN_Eval.Hotfixes.xml'
        },
        @{
            Id              = "2012R2_x64_Standard_Core_EN_V5"
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
            Hotfixes = '.\2012R2_x64_Standard_EN_V5_Eval.Hotfixes.xml'
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
            Hotfixes = '.\2012R2_x64_Standard_EN_Eval.Hotfixes.xml'
        },
        @{
            Id              = "2012R2_x64_Datacenter_EN_V5"
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
            Hotfixes = '.\2012R2_x64_Standard_EN_V5_Eval.Hotfixes.xml'
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
            Hotfixes = '.\2012R2_x64_Standard_EN_Eval.Hotfixes.xml'
        },
        @{
            Id              = "2012R2_x64_Datacenter_Core_EN_V5"
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
            Hotfixes = '.\2012R2_x64_Standard_EN_V5_Eval.Hotfixes.xml'
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
            Hotfixes = '.\2012R2_x64_Standard_EN_Eval.Hotfixes.xml'
        },
        @{
            Id              = "WIN81_x64_Enterprise_EN_V5"
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
            Hotfixes = '.\2012R2_x64_Standard_EN_V5_Eval.Hotfixes.xml'
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
            Hotfixes = '.\WIN81_x86_Enterprise_EN_Eval.Hotfixes.xml'
        },
        @{
            Id              = "WIN81_x86_Enterprise_EN_V5"
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
            Hotfixes = '.\WIN81_x86_Enterprise_EN_V5_Eval.Hotfixes.xml'
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
            Hotfixes = '.\WIN10_x64_Enterprise_EN_Eval.Hotfixes.xml'
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
            Hotfixes = '.\WIN10_x86_Enterprise_EN_Eval.Hotfixes.xml'
        },
        @{
            Id              = "WIN10_x64_Enterprise_LTSB_EN"
            FileName        = "en_windows_10_enterprise_2016_ltsb_x86_dvd_9060010.iso"
            Description     = "Windows 10 64bit Enterprise 2016 English Evaluation"
            Architecture    = "x64"
            ImageName       = "Windows 10 Enterprise"
            MediaType       = "ISO"
            OperatingSystem = "Windows"
            Uri             = $null
            Checksum        = "E39EA2AF41B3710682FE3BBDAC35EC9A"
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
            Hotfixes = '.\WIN10_x64_Enterprise_LTSB_EN_Eval.Hotfixes.xml'
        },
        @{
            Id              = "WIN10_x86_Enterprise_LTSB_EN"
            FileName        = "en_windows_10_enterprise_version_1607_updated_jan_2017_x86_dvd_9719039.iso"
            Description     = "Windows 10 32bit Enterprise 2016 English Evaluation"
            Architecture    = "x86"
            ImageName       = "Windows 10 Enterprise"
            MediaType       = "ISO"
            OperatingSystem = "Windows"
            Uri             = $null
            Checksum        = "6FFB9B81FDE69EA4B5A2764F93D8B245"
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
            Hotfixes = '.\WIN10_x86_Enterprise_LTSB_EN_Eval.Hotfixes.xml'
        }
        #endregion

        #endregion
    )
}
