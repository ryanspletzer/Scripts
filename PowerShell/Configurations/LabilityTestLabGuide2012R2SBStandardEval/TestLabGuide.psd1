@{
    AllNodes = @(
        @{
            NodeName = '*';
            InterfaceAlias = 'Ethernet';
            DefaultGateway = '10.0.0.254';
            PrefixLength = 24;
            AddressFamily = 'IPv4';
            DnsServerAddress = '10.0.0.1';
            DomainName = 'corp.contoso.com';
            DomainNameShort = "CORP"
            PSDscAllowPlainTextPassword = $true;
            #CertificateFile = "$env:AllUsersProfile\Lability\Certificates\LabClient.cer";
            #Thumbprint = 'AAC41ECDDB3B582B133527E4DE0D2F8FEB17AAB2';
            PSDscAllowDomainUser = $true; # Removes 'It is not recommended to use domain credential for node X' messages
            Lability_SwitchName = 'Corpnet';
            Lability_ProcessorCount = 1;
            Lability_StartupMemory = 4GB;
            Lability_Media = '2012R2_x64_Standard_EN_V5_Eval';
            DomainAdministratorUserName = 'Administrator'
            SQLAdminUserName = 'SQLAdmin'
            SQLInstallUserName = 'SQLInstall'
        }
        @{
            NodeName = 'DC1';
            IPAddress = '10.0.0.1';
            DnsServerAddress = '127.0.0.1';
            Role = 'DC';
            Lability_ProcessorCount = 1;
        }
        @{
            NodeName = 'SQL1';
            IPAddress = '10.0.0.3';
            Role = 'SQL';
            Features = "SQLENGINE,IS"
            SourcePath = 'C:\Resources\SQLServerISO';
            SQLTestUser1UserName = 'SQLTestUser1'
            SQLTestUser2UserName = 'SQLTestUser2'
            InstanceName = "MSSQLSERVER";
            Lability_Resource = @('SQLServerISO');
        }
        @{
            NodeName = 'SB1';
            IPAddress = '10.0.0.4';
            Role = 'SB';
            Lability_Resource = @('ServiceBus_1_1_CU1');
        }
    );
    NonNodeData = @{
        Lability = @{
            EnvironmentPrefix = 'SB-';
            Media = @();
            Network = @(
                @{ Name = 'Corpnet'; Type = 'Internal'; }
                #@{ Name = 'Internet'; Type = 'Internal'; }
                @{ Name = 'ICS'; Type = 'Internal'; }
                # @{ Name = 'External'; Type = 'External'; NetAdapterName = 'Ethernet'; AllowManagementOS = $true; }
                <#
                    IPAddress: The desired IP address.
                    InterfaceAlias: Alias of the network interface for which the IP address should be set. <- Use NetAdapterName
                    DefaultGateway: Specifies the IP address of the default gateway for the host. <- Not needed for internal switch
                    Subnet: Local subnet CIDR (used for cloud routing).
                    AddressFamily: IP address family: { IPv4 | IPv6 }
                #>
            );
            DSCResource = @(
                ## Download published version from the PowerShell Gallery
                @{ Name = 'xComputerManagement'; MinimumVersion = '1.3.0.0'; Provider = 'PSGallery'; }
                @{ Name = 'xCertificate'; MinimumVersion = '2.3.0.0'; }
                ## If not specified, the provider defaults to the PSGallery.
                @{ Name = 'xSmbShare'; MinimumVersion = '1.1.0.0'; }
                @{ Name = 'xNetworking'; MinimumVersion = '2.7.0.0'; }
                @{ Name = 'xActiveDirectory'; MinimumVersion = '2.9.0.0'; }
                @{ Name = 'xDnsServer'; MinimumVersion = '1.5.0.0'; }
                @{ Name = 'xDhcpServer'; MinimumVersion = '1.3.0.0'; }
                @{ Name = 'xSQLServer'; MinimumVersion = '5.0.0.0'; }
                ## The 'GitHub# provider can download modules directly from a GitHub repository, for example:
                ## @{ Name = 'Lability'; Provider = 'GitHub'; Owner = 'VirtualEngine'; Repository = 'Lability'; Branch = 'dev'; }
            );
            Resource = @(
                @{
                    ##  Resource identifier. If the resource is to be expanded (ZIP or ISO), it will also be
                    ##  expanded into the \Resources\<ResourceID> folder on the target node.
                    Id = 'SQLServerISO';

                    ##  When the file is downloaded, it will be placed in the host's 'ResourcePath' folder
                    ##  using this filename.
                    Filename = 'en_sql_server_2016_enterprise_with_service_pack_1_x64_dvd_9542382.iso';

                    ##  The source URI to download the file from if it is not present in the host's Resources
                    ##  folder. This can be a http, https or file URI. If the path includes spaces, they must
                    ##  be URL encoded.
                    Uri = 'https://api.onedrive.com/v1.0/shares/u!aHR0cHM6Ly9vbmVkcml2ZS5saXZlLmNvbS9yZWRpcj9yZXNpZD1GMkY5NTVCMjZFNjg1OTYwITM5NjMzJmF1dGhrZXk9IUFCd1g4NzQ2cDlCdkc5SQ/root/content'

                    ##  If you want the module to check the downloaded file, you can specify a MD5 checksum.
                    ##  If you do specify a checksum you HAVE to ensure it's correct otherwise it will
                    ##  continuously attempt to download the resource!
                    # Checksum = '';

                    ## If the resource is a .ZIP or .ISO file, it can be expanded/decompressed when copied
                    ## into the node's \Resources\<ResourceID> folder. If not specified, this value defaults
                    ## to False.
                    Expand = $true;

                    ## If specified, overrides the default \Resources destination path.
                    # DestinationPath = '\ProgramData\VirtualEngine';
                }
                @{
                    ##  Resource identifier. If the resource is to be expanded (ZIP or ISO), it will also be
                    ##  expanded into the \Resources\<ResourceID> folder on the target node.
                    Id = 'ServiceBus_1_1_CU1';

                    ##  When the file is downloaded, it will be placed in the host's 'ResourcePath' folder
                    ##  using this filename.
                    Filename = 'ServiceBus_1_1_CU1.zip';

                    ##  The source URI to download the file from if it is not present in the host's Resources
                    ##  folder. This can be a http, https or file URI. If the path includes spaces, they must
                    ##  be URL encoded.
                    Uri = 'https://api.onedrive.com/v1.0/shares/u!aHR0cHM6Ly9vbmVkcml2ZS5saXZlLmNvbS9yZWRpcj9yZXNpZD1GMkY5NTVCMjZFNjg1OTYwITM5ODUxJmF1dGhrZXk9IUFKWjdPWVpZdzdkSWpLWQ/root/content'

                    ##  If you want the module to check the downloaded file, you can specify a MD5 checksum.
                    ##  If you do specify a checksum you HAVE to ensure it's correct otherwise it will
                    ##  continuously attempt to download the resource!
                    # Checksum = '';

                    ## If the resource is a .ZIP or .ISO file, it can be expanded/decompressed when copied
                    ## into the node's \Resources\<ResourceID> folder. If not specified, this value defaults
                    ## to False.
                    Expand = $true;

                    ## If specified, overrides the default \Resources destination path.
                    # DestinationPath = '\ProgramData\VirtualEngine';
                }
            )
        };
    };
};
