Configuration TestLabGuide {
<#
    Requires the following custom DSC resources:
        xComputerManagement (v1.4.0.0 or later): https://github.com/PowerShell/xComputerManagement
        xNetworking/dev (v2.7.0.0 or later):     https://github.com/PowerShell/xNetworking
        xActiveDirectory (v2.9.0.0 or later):    https://github.com/PowerShell/xActiveDirectory
        xSmbShare (v1.1.0.0 or later):           https://github.com/PowerShell/xSmbShare
        xDhcpServer (v1.3.0 or later):           https://github.com/PowerShell/xDhcpServer
        xDnsServer (v1.5.0 or later):            https://github.com/PowerShell/xDnsServer
        xSQLServer (v1.5.0 or later):            https://github.com/PowerShell/xSQLServer
#>
    param (
        [Parameter()]
        [ValidateNotNull()]
        [PSCredential]
        $DomainAdministratorCredential = (Get-Credential -UserName $ConfigurationData.AllNodes.Where({$true}).DomainAdministratorUsername -Message "Credentials for Domain Administrator Account"),

        [Parameter()]
        [ValidateNotNull()]
        [PSCredential]
        $SQLAdminCredential = (Get-Credential -UserName $ConfigurationData.AllNodes.Where({$true}).SQLAdminUserName -Message "Credentials for SQL Admin Account"),

        [Parameter()]
        [ValidateNotNull()]
        [PSCredential]
        $SQLInstallCredential = (Get-Credential -UserName $ConfigurationData.AllNodes.Where({$true}).SQLInstallUserName -Message "Credentials for SQL Install Account"),

        [Parameter()]
        [ValidateNotNull()]
        [PSCredential]
        $SQLTestUser1Credential = (Get-Credential -UserName $ConfigurationData.AllNodes.Where({$_.Role -in "SQL"}).SQLTestUser1UserName -Message "Credentials for SQL TestUser1 Account"),

        [Parameter()]
        [ValidateNotNull()]
        [PSCredential]
        $SQLTestUser2Credential = $(Get-Credential -UserName $ConfigurationData.AllNodes.Where({$_.Role -in "SQL"}).SQLTestUser2UserName -Message "Credentials for SQL TestUser2 Account")
    )
    
    Import-DscResource -Module xComputerManagement, xNetworking, xActiveDirectory;
    Import-DscResource -Module xSmbShare, PSDesiredStateConfiguration;
    Import-DscResource -Module xDHCPServer, xDnsServer;
    Import-DscResource -Module xSQLServer;

    node $AllNodes.Where({$true}).NodeName {
        LocalConfigurationManager {
            RebootNodeIfNeeded   = $true;
            ActionAfterReboot    = 'ContinueConfiguration';
            AllowModuleOverwrite = $true;
            ConfigurationMode    = 'ApplyOnly';
            CertificateID        = $Node.Thumbprint;
        }

        if (-not [System.String]::IsNullOrEmpty($Node.IPAddress)) {
            xIPAddress 'PrimaryIPAddress' {
                IPAddress      = $Node.IPAddress;
                InterfaceAlias = $Node.InterfaceAlias;
                PrefixLength   = $Node.PrefixLength;
                AddressFamily  = $Node.AddressFamily;
            }

            if (-not [System.String]::IsNullOrEmpty($Node.DefaultGateway)) {
                xDefaultGatewayAddress 'PrimaryDefaultGateway' {
                    InterfaceAlias = $Node.InterfaceAlias;
                    Address        = $Node.DefaultGateway;
                    AddressFamily  = $Node.AddressFamily;
                }
            }
            
            if (-not [System.String]::IsNullOrEmpty($Node.DnsServerAddress)) {
                xDnsServerAddress 'PrimaryDNSClient' {
                    Address        = $Node.DnsServerAddress;
                    InterfaceAlias = $Node.InterfaceAlias;
                    AddressFamily  = $Node.AddressFamily;
                }
            }
            
            if (-not [System.String]::IsNullOrEmpty($Node.DnsConnectionSuffix)) {
                xDnsConnectionSuffix 'PrimaryConnectionSuffix' {
                    InterfaceAlias           = $Node.InterfaceAlias;
                    ConnectionSpecificSuffix = $Node.DnsConnectionSuffix;
                }
            }
            
        } #end if IPAddress
        
        xFirewall 'FPS-ICMP4-ERQ-In' {
            Name        = 'FPS-ICMP4-ERQ-In';
            DisplayName = 'File and Printer Sharing (Echo Request - ICMPv4-In)';
            Description = 'Echo request messages are sent as ping requests to other nodes.';
            Direction   = 'Inbound';
            Action      = 'Allow';
            Enabled     = 'True';
            Profile     = 'Any';
        }

        xFirewall 'FPS-ICMP6-ERQ-In' {
            Name        = 'FPS-ICMP6-ERQ-In';
            DisplayName = 'File and Printer Sharing (Echo Request - ICMPv6-In)';
            Description = 'Echo request messages are sent as ping requests to other nodes.';
            Direction   = 'Inbound';
            Action      = 'Allow';
            Enabled     = 'True';
            Profile     = 'Any';
        }
    } #end nodes ALL
  
    node $AllNodes.Where({$_.Role -in 'DC'}).NodeName {

        xComputer 'Hostname' {
            Name = $Node.NodeName;
        }
        
        ## Hack to fix DependsOn with hypens "bug" :(
        foreach ($feature in @(
                'AD-Domain-Services',
                'GPMC',
                'RSAT-AD-Tools',
                'DHCP',
                'RSAT-DHCP'
            )) {
            WindowsFeature $feature.Replace('-','') {
                Ensure               = 'Present';
                Name                 = $feature;
                IncludeAllSubFeature = $true;
            }
        }
        
        xADDomain 'ADDomain' {
            DomainName = $Node.DomainName;
            SafemodeAdministratorPassword = $DomainAdministratorCredential;
            DomainAdministratorCredential = $DomainAdministratorCredential;
            DependsOn                     = '[WindowsFeature]ADDomainServices';
        }

        xDhcpServerAuthorization 'DhcpServerAuthorization' {
            Ensure    = 'Present';
            DependsOn = '[WindowsFeature]DHCP','[xADDomain]ADDomain';
        }
        
        xDhcpServerScope 'DhcpScope10_0_0_0' {
            Name          = 'Corpnet';
            IPStartRange  = '10.0.0.100';
            IPEndRange    = '10.0.0.200';
            SubnetMask    = '255.255.255.0';
            LeaseDuration = '00:08:00';
            State         = 'Active';
            AddressFamily = 'IPv4';
            DependsOn     = '[WindowsFeature]DHCP';
        }

        xDhcpServerOption 'DhcpScope10_0_0_0_Option' {
            ScopeID            = '10.0.0.0';
            DnsDomain          = 'corp.contoso.com';
            DnsServerIPAddress = '10.0.0.1';
            Router             = '10.0.0.2';
            AddressFamily      = 'IPv4';
            DependsOn          = '[xDhcpServerScope]DhcpScope10_0_0_0';
        }
        
        xADUser $SQLInstallCredential.UserName { 
            DomainName  = $Node.DomainName;
            UserName    = $SQLInstallCredential.UserName;
            Description = 'SQL Install Account';
            Password    = $SQLAdminCredential;
            Ensure      = 'Present';
            DependsOn   = '[xADDomain]ADDomain';
        }
        
        xADUser $SQLAdminCredential.UserName { 
            DomainName  = $Node.DomainName;
            UserName    = $SQLAdminCredential.UserName;
            Description = 'SQL Admin Account';
            Password    = $SQLAdminCredential;
            Ensure      = 'Present';
            DependsOn   = '[xADDomain]ADDomain';
        }
        
    } #end nodes DC
    
    node $AllNodes.Where({$_.Role -in 'SQL','SB'}).NodeName {
        ## Flip credential into username@domain.com
        $domainAdministratorUpnCredential = New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList ("$($DomainAdministratorCredential.UserName)@$($Node.DomainName)", $DomainAdministratorCredential.Password);

        xComputer 'DomainMembership' {
            Name       = $Node.NodeName;
            DomainName = $Node.DomainName;
            Credential = $domainAdministratorUpnCredential;
        }
    } #end nodes DomainJoined

    node $AllNodes.Where({$_.Role -in 'SQL'}).NodeName {
        $domainAdministratorUpnCredential = New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList ("$($DomainAdministratorCredential.UserName)@$($Node.DomainName)", $DomainAdministratorCredential.Password);
        $sqlInstallLogonCredential = New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList ("$($Node.DomainName)\$($SQLInstallCredential.UserName)", $SQLInstallCredential.Password);
        $sqlAdminLogonCredential = New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList ("$($Node.DomainName)\$($SQLAdminCredential.UserName)", $SQLAdminCredential.Password);

        Group ($Node.NodeName+"LocalAdministrators") {
            Credential       = $domainAdministratorUpnCredential
            GroupName        = 'Administrators'
            Ensure           = 'Present'
            MembersToInclude = $sqlInstallLogonCredential.UserName,$sqlAdminLogonCredential.UserName
        }

        xSqlServerSetup ($Node.NodeName) {
            DependsOn           = ("[Group]" + $Node.NodeName + "LocalAdministrators")
            SourcePath          = $Node.SourcePath
            SetupCredential     = $sqlInstallLogonCredential
            InstanceName        = $Node.InstanceName
            Features            = $Node.Features
            SQLSysAdminAccounts = $sqlAdminLogonCredential.UserName
            InstallSharedDir    = "C:\Program Files\Microsoft SQL Server"
            InstallSharedWOWDir = "C:\Program Files (x86)\Microsoft SQL Server"
            InstanceDir         = "C:\Program Files\Microsoft SQL Server"
            InstallSQLDataDir   = "C:\Program Files\Microsoft SQL Server\MSSQL13.MSSQLSERVER\MSSQL\Data"
            SQLUserDBDir        = "C:\Program Files\Microsoft SQL Server\MSSQL13.MSSQLSERVER\MSSQL\Data"
            SQLUserDBLogDir     = "C:\Program Files\Microsoft SQL Server\MSSQL13.MSSQLSERVER\MSSQL\Data"
            SQLTempDBDir        = "C:\Program Files\Microsoft SQL Server\MSSQL13.MSSQLSERVER\MSSQL\Data"
            SQLTempDBLogDir     = "C:\Program Files\Microsoft SQL Server\MSSQL13.MSSQLSERVER\MSSQL\Data"
            SQLBackupDir        = "C:\Program Files\Microsoft SQL Server\MSSQL13.MSSQLSERVER\MSSQL\Data"
        }
         
        xSqlServerFirewall ($Node.NodeName) {
            DependsOn    = ("[xSqlServerSetup]" + $Node.NodeName)
            SourcePath   = $Node.SourcePath
            InstanceName = $Node.InstanceName
            Features     = $Node.Features
        }

        xPowerPlan ($Node.Nodename) {
            IsSingleInstance = 'Yes'
            Name             = 'High Performance'
        }

        xSQLServerMemory ($Node.Nodename) {
            DependsOn       = ("[xSqlServerSetup]" + $Node.NodeName)
            Ensure          = "Present"
            DynamicAlloc    = $false
            SQLInstanceName = $Node.InstanceName
            MinMemory       = "256"
            MaxMemory       = "1024"
        }

        xSQLServerMaxDop ($Node.Nodename) {
            SQLInstanceName = "\"
            DependsOn       = ("[xSqlServerSetup]" + $Node.NodeName)
            Ensure          = "Present"
            DynamicAlloc    = $true
        }

        xSQLServerLogin ($Node.Nodename+$SQLTestUser1Credential.UserName) {
            SQLServer       = $Node.NodeName
            SQLInstanceName = "\"
            DependsOn       = ("[xSqlServerSetup]" + $Node.NodeName)
            Ensure          = "Present"
            Name            = $SQLTestUser1Credential.UserName
            LoginCredential = $SQLTestUser1Credential
            LoginType       = "SQLLogin"
        }

        xSQLServerLogin ($Node.Nodename+$SQLTestUser2Credential.UserName) {
            SQLServer       = $Node.NodeName
            SQLInstanceName = "\"
            DependsOn       = ("[xSqlServerSetup]" + $Node.NodeName)
            Ensure          = "Present"
            Name            = $SQLTestUser2Credential.UserName
            LoginCredential = $SQLTestUser2Credential
            LoginType       = "SQLLogin"
        }

        xSQLServerDatabaseRole ($Node.Nodename) {
            SQLServer       = $Node.Nodename
            SQLInstanceName = "\"
            DependsOn       = ("[xSqlServerSetup]" + $Node.NodeName)
            Ensure          = "Present"
            Name            = $SQLTestUser2Credential.UserName
            Database        = "model"
            Role            = "db_Datareader"
        }

        xSQLServerDatabasePermission ($Node.Nodename) {
            DependsOn       = ("[xSqlServerSetup]" + $Node.NodeName)
            SQLServer       = $Node.Nodename
            SQLInstanceName = $Node.Nodename
            Database        = "Model"
            Name            = $SQLTestUser2Credential.UserName
            Permissions     = "SELECT","DELETE"
            PermissionState = "GRANT"
        }

        xSQLServerDatabase ($Node.Nodename) {
            DependsOn       = ("[xSqlServerSetup]" + $Node.NodeName)
            SQLServer       = $Node.Nodename
            SQLInstanceName = "\"
            Name            = "TestDB"
            Ensure          = "Present"
        }

        xSQLServerDatabaseRecoveryModel ($Node.Nodename) {
            SQLServer       = $Node.Nodename
            SQLInstanceName = "\"
            DependsOn       = ("[xSQLServerDatabase]" + $Node.NodeName)
            Name            = "TestDB"
            RecoveryModel   = "Full"  
        }

        xSQLServerDatabaseOwner ($Node.Nodename) {
            DependsOn = ("[xSQLServerDatabase]" + $Node.NodeName)
            Database  = "TestDB"
            Name      = $SQLTestUser2Credential.UserName
        }

    } #end nodes SQL

    node $AllNodes.Where({$_.Role -in 'SB'}).NodeName {

    } #end nodes SB
} #end Configuration Example
