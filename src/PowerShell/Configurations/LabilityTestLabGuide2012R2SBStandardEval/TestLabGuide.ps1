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
        $SQLTestUser2Credential = $(Get-Credential -UserName $ConfigurationData.AllNodes.Where({$_.Role -in "SQL"}).SQLTestUser2UserName -Message "Credentials for SQL TestUser2 Account"),

        [Parameter()]
        [ValidateNotNull()]
        [PSCredential]
        $SBInstallCredential = (Get-Credential -UserName $ConfigurationData.AllNodes.Where({$true}).SBInstallUserName -Message "Credentials for Service Bus Install Account"),

        [Parameter()]
        [ValidateNotNull()]
        [PSCredential]
        $SBServiceCredential = (Get-Credential -UserName $ConfigurationData.AllNodes.Where({$true}).SBServiceUserName -Message "Credentials for Service Bus Service Account")
    )

    Import-DscResource -Module ComputerManagementDsc, NetworkingDsc, xActiveDirectory;
    Import-DscResource -Module xSmbShare, PSDesiredStateConfiguration;
    Import-DscResource -Module xDHCPServer, xDnsServer;
    Import-DscResource -Module SQLServerDsc;

    node $AllNodes.Where({$true}).NodeName {
        LocalConfigurationManager {
            RebootNodeIfNeeded   = $true;
            ActionAfterReboot    = 'ContinueConfiguration';
            AllowModuleOverwrite = $true;
            ConfigurationMode    = 'ApplyOnly';
            CertificateID        = $Node.Thumbprint;
        }

        if (-not [System.String]::IsNullOrEmpty($Node.IPAddress)) {
            IPAddress 'PrimaryIPAddress' {
                IPAddress      = $Node.IPAddress;
                InterfaceAlias = $Node.InterfaceAlias;
                AddressFamily  = $Node.AddressFamily;
            }

            if (-not [System.String]::IsNullOrEmpty($Node.DefaultGateway)) {
                DefaultGatewayAddress 'PrimaryDefaultGateway' {
                    InterfaceAlias = $Node.InterfaceAlias;
                    Address        = $Node.DefaultGateway;
                    AddressFamily  = $Node.AddressFamily;
                }
            }

            if (-not [System.String]::IsNullOrEmpty($Node.DnsServerAddress)) {
                DnsServerAddress 'PrimaryDNSClient' {
                    Address        = $Node.DnsServerAddress;
                    InterfaceAlias = $Node.InterfaceAlias;
                    AddressFamily  = $Node.AddressFamily;
                }
            }

            if (-not [System.String]::IsNullOrEmpty($Node.DnsConnectionSuffix)) {
                DnsConnectionSuffix 'PrimaryConnectionSuffix' {
                    InterfaceAlias           = $Node.InterfaceAlias;
                    ConnectionSpecificSuffix = $Node.DnsConnectionSuffix;
                }
            }

        } #end if IPAddress

        Firewall 'FPS-ICMP4-ERQ-In' {
            Name        = 'FPS-ICMP4-ERQ-In';
            DisplayName = 'File and Printer Sharing (Echo Request - ICMPv4-In)';
            Description = 'Echo request messages are sent as ping requests to other nodes.';
            Direction   = 'Inbound';
            Action      = 'Allow';
            Enabled     = 'True';
            Profile     = 'Any';
        }

        Firewall 'FPS-ICMP6-ERQ-In' {
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
        $domainAdministratorUpnCredential = New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList ("$($DomainAdministratorCredential.UserName)@$($Node.DomainName)", $DomainAdministratorCredential.Password);
        $sqlInstallUpnCredential = New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList ("$($SQLInstallCredential.UserName)@$($Node.DomainName)", $SQLInstallCredential.Password);
        $sqlAdminUpnCredential = New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList ("$($SQLAdminCredential.UserName)@$($Node.DomainName)", $SQLAdminCredential.Password);
        $sbInstallUpnCredential = New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList ("$($SBInstallCredential.UserName)@$($Node.DomainName)", $SBInstallCredential.Password);
        $sbServiceUpnCredential = New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList ("$($SBServiceCredential.UserName)@$($Node.DomainName)", $SBServiceCredential.Password);

        Computer 'Hostname' {
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
            DomainName                    = $Node.DomainName;
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
            ScopeId       = '10.0.0.0';
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

        xADUser $DomainAdministratorCredential.UserName {
            DomainName  = $Node.DomainName;
            UserName    = $DomainAdministratorCredential.UserName;
            Description = 'SQL Install Account';
            Password    = $DomainAdministratorCredential;
            UserPrincipalName = $domainAdministratorUpnCredential.UserName;
            Ensure      = 'Present';
            DependsOn   = '[xADDomain]ADDomain';
        }

        xADUser $SQLInstallCredential.UserName {
            DomainName  = $Node.DomainName;
            UserName    = $SQLInstallCredential.UserName;
            Description = 'SQL Install Account';
            Password    = $SQLInstallCredential;
            UserPrincipalName = $sqlInstallUpnCredential.UserName;
            Ensure      = 'Present';
            DependsOn   = '[xADDomain]ADDomain';
        }

        xADUser $SQLAdminCredential.UserName {
            DomainName  = $Node.DomainName;
            UserName    = $SQLAdminCredential.UserName;
            Description = 'SQL Admin Account';
            Password    = $SQLAdminCredential;
            UserPrincipalName = $sqlAdminUpnCredential.UserName;
            Ensure      = 'Present';
            DependsOn   = '[xADDomain]ADDomain';
        }

        xADUser $SBInstallCredential.UserName {
            DomainName  = $Node.DomainName;
            UserName    = $SBInstallCredential.UserName;
            Description = 'Service Bus Install Account';
            Password    = $SBInstallCredential;
            UserPrincipalName = $sbInstallUpnCredential.UserName;
            Ensure      = 'Present';
            DependsOn   = '[xADDomain]ADDomain';
        }

        xADUser $SBServiceCredential.UserName {
            DomainName  = $Node.DomainName;
            UserName    = $SBServiceCredential.UserName;
            Description = 'Service Bus Install Account';
            Password    = $SBServiceCredential;
            UserPrincipalName = $sbServiceUpnCredential.UserName;
            Ensure      = 'Present';
            DependsOn   = '[xADDomain]ADDomain';
        }

    } #end nodes DC

    node $AllNodes.Where({$_.Role -in 'SQL','SB'}).NodeName {
        ## Flip credential into username@domain.com
        $domainAdministratorUpnCredential = New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList ("$($DomainAdministratorCredential.UserName)@$($Node.DomainName)", $DomainAdministratorCredential.Password);

        xWaitForADDomain 'WaitForDomain' {
            DomainName           = $Node.DomainName
            RetryIntervalSec     = 60
            RetryCount           = 60
            DomainUserCredential = $domainAdministratorUpnCredential
        }

        Computer 'DomainMembership' {
            Name       = $Node.NodeName;
            DomainName = $Node.DomainName;
            Credential = $domainAdministratorUpnCredential;
            DependsOn  = '[xWaitForADDomain]WaitForDomain';
        }
    } #end nodes DomainJoined

    node $AllNodes.Where({$_.Role -in 'SQL'}).NodeName {
        $domainAdministratorLogonCredential = New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList ("$($Node.DomainNameShort)\$($DomainAdministratorCredential.UserName)", $DomainAdministratorCredential.Password);
        $sqlInstallLogonCredential = New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList ("$($Node.DomainNameShort)\$($SQLInstallCredential.UserName)", $SQLInstallCredential.Password);
        $sqlAdminLogonCredential = New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList ("$($Node.DomainNameShort)\$($SQLAdminCredential.UserName)", $SQLAdminCredential.Password);
        $sbInstallLogonCredential = New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList ("$($Node.DomainNameShort)\$($SBInstallCredential.UserName)", $SBInstallCredential.Password);

        Group ($Node.NodeName+"LocalAdministrators") {
            DependsOn        = '[Computer]DomainMembership'
            Credential       = $domainAdministratorLogonCredential
            GroupName        = 'Administrators'
            Ensure           = 'Present'
            MembersToInclude = $sqlInstallLogonCredential.UserName,$sqlAdminLogonCredential.UserName
        }

        SqlSetup ($Node.NodeName) {
            DependsOn           = ("[Group]" + $Node.NodeName + "LocalAdministrators")
            SourcePath          = $Node.SourcePath
            SourceCredential    = $sqlInstallLogonCredential
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

        SqlServerFirewall ($Node.NodeName) {
            DependsOn    = ("[SqlServerSetup]" + $Node.NodeName)
            SourcePath   = $Node.SourcePath
            InstanceName = $Node.InstanceName
            Features     = $Node.Features
        }

        PowerPlan ($Node.Nodename) {
            IsSingleInstance = 'Yes'
            Name             = 'High Performance'
        }

        SqlServerMemory ($Node.Nodename) {
            DependsOn    = ("[xSqlServerSetup]" + $Node.NodeName)
            Ensure       = "Present"
            DynamicAlloc = $false
            InstanceName = $Node.InstanceName
            MinMemory    = "256"
            MaxMemory    = "1024"
        }

        SqlServerMaxDop ($Node.Nodename) {
            ServerName   = $Node.NodeName
            InstanceName = $Node.InstanceName
            DependsOn    = ("[SqlServerSetup]" + $Node.NodeName)
            Ensure       = "Present"
            DynamicAlloc = $true
        }

        SqlServerLogin ($Node.Nodename+$SQLAdminCredential.UserName) {
            ServerName   = $Node.NodeName
            InstanceName = $Node.InstanceName
            DependsOn    = ("[SqlServerSetup]" + $Node.NodeName)
            Ensure       = "Present"
            Name            = $sqlAdminLogonCredential.UserName
        }

        SqlServerLogin ($Node.Nodename+$SQLTestUser1Credential.UserName) {
            ServerName      = $Node.NodeName
            InstanceName    = $Node.InstanceName
            DependsOn       = ("[SqlServerSetup]" + $Node.NodeName)
            Ensure          = "Present"
            Name            = $SQLTestUser1Credential.UserName
            LoginCredential = $SQLTestUser1Credential
            LoginType       = "SQLLogin"
        }

        SqlServerLogin ($Node.Nodename+$SQLTestUser2Credential.UserName) {
            ServerName      = $Node.NodeName
            InstanceName    = $Node.InstanceName
            DependsOn       = ("[SqlServerSetup]" + $Node.NodeName)
            Ensure          = "Present"
            Name            = $SQLTestUser2Credential.UserName
            LoginCredential = $SQLTestUser2Credential
            LoginType       = "SQLLogin"
        }

        SqlServerLogin ($Node.Nodename+$SBInstallCredential.UserName) {
            ServerName   = $Node.NodeName
            InstanceName = $Node.InstanceName
            DependsOn    = ("[SqlServerSetup]" + $Node.NodeName)
            Ensure       = "Present"
            Name         = $sbInstallLogonCredential.UserName
        }

        SqlServerRole ($Node.Nodename+$SBInstallCredential.UserName) {
            ServerName     = $Node.NodeName
            InstanceName   = $Node.InstanceName
            DependsOn      = ("[SqlServerLogin]" + ($Node.Nodename+$SBInstallCredential.UserName))
            Members        = $sbInstallLogonCredential.UserName
            ServerRoleName = 'dbcreator','securityadmin'
            Ensure         = 'Present'
        }

        SqlDatabaseRole ($Node.Nodename) {
            ServerName   = $Node.Nodename
            InstanceName = $Node.InstanceName
            DependsOn    = ("[SqlServerSetup]" + $Node.NodeName)
            Ensure       = "Present"
            Name         = $SQLTestUser1Credential.UserName
            Database     = "model"
            Role         = "db_Datareader"
        }

        SqlDatabasePermission ($Node.Nodename) {
            DependsOn       = ("[SqlServerSetup]" + $Node.NodeName)
            ServerName      = $Node.Nodename
            InstanceName    = $Node.InstanceName
            Database        = "Model"
            Name            = $SQLTestUser1Credential.UserName
            Permissions     = "SELECT","DELETE"
            PermissionState = "GRANT"
        }

        SqlDatabase ($Node.Nodename) {
            DependsOn    = ("[SqlServerSetup]" + $Node.NodeName)
            ServerName   = $Node.Nodename
            InstanceName = $Node.InstanceName
            Name         = "TestDB"
            Ensure       = "Present"
        }

        SqlDatabaseRecoveryModel ($Node.Nodename) {
            ServerName    = $Node.Nodename
            InstanceName  = $Node.InstanceName
            DependsOn     = ("[SqlServerDatabase]" + $Node.NodeName)
            Name          = "TestDB"
            RecoveryModel = "Full"
        }

        SqlDatabaseOwner ($Node.Nodename) {
            DependsOn = ("[SqlServerDatabase]" + $Node.NodeName)
            Database  = "TestDB"
            Name      = $SQLTestUser2Credential.UserName
        }

    } #end nodes SQL

    node $AllNodes.Where({$_.Role -in 'SB'}).NodeName {

    } #end nodes SB
} #end Configuration Example
