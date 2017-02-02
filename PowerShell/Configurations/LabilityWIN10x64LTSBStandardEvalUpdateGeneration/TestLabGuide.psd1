@{
    AllNodes = @(
        @{
            NodeName = '*';
            PSDscAllowPlainTextPassword = $true;
            #CertificateFile = "$env:AllUsersProfile\Lability\Certificates\LabClient.cer";
            #Thumbprint = 'AAC41ECDDB3B582B133527E4DE0D2F8FEB17AAB2';
            PSDscAllowDomainUser = $true; # Removes 'It is not recommended to use domain credential for node X' messages
            Lability_SwitchName = 'ICS';
            Lability_ProcessorCount = 1;
            Lability_StartupMemory = 4GB;
            Lability_Media = 'WIN10_x64_Enterprise_LTSB_EN_Eval';
        }
        @{
            NodeName = 'EDGE1';
        }
    );
    NonNodeData = @{
        Lability = @{
            EnvironmentPrefix = 'TLG-';
            Media = @();
            Network = @(
                #@{ Name = 'Corpnet'; Type = 'Internal'; }
                #@{ Name = 'Internet'; Type = 'Internal'; }
                @{ Name = 'ICS'; Type = 'Internal';}
                #@{ Name = 'External'; Type = 'External'; NetAdapterName = 'Ethernet'; AllowManagementOS = $true; }
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
                ## If not specified, the provider defaults to the PSGallery.
                #@{ Name = 'xSmbShare'; MinimumVersion = '1.1.0.0'; }
                @{ Name = 'xNetworking'; MinimumVersion = '2.7.0.0'; }
                #@{ Name = 'xActiveDirectory'; MinimumVersion = '2.9.0.0'; }
                #@{ Name = 'xDnsServer'; MinimumVersion = '1.5.0.0'; }
                #@{ Name = 'xDhcpServer'; MinimumVersion = '1.3.0.0'; }
                ## The 'GitHub# provider can download modules directly from a GitHub repository, for example:
                ## @{ Name = 'Lability'; Provider = 'GitHub'; Owner = 'VirtualEngine'; Repository = 'Lability'; Branch = 'dev'; }
            );
        };
    };
};