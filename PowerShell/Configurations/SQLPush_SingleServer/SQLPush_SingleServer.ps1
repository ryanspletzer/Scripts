#requires -Version 5

Configuration SQLSA {
    param (
        [Parameter(Mandatory=$true)]
        [pscredential]
        $DomainInstallCredential,

        [Parameter(Mandatory=$true)]
        [pscredential]
        $TestUser1Credential,

        [parameter(Mandatory=$true)]
        [pscredential]
        $TestUser2Credential
    )
    Import-DscResource -Module PSDesiredStateConfiguration
    Import-DscResource -Module xSQLServer

    Node $AllNodes.NodeName {

        if ($Node.Features) {
            xSqlServerSetup ($Node.NodeName) {
                SourcePath = $Node.SourcePath
                SetupCredential = $DomainInstallCredential
                InstanceName = $Node.InstanceName
                Features = $Node.Features
                SQLSysAdminAccounts = $Node.AdminAccount
                InstallSharedDir = "C:\Program Files\Microsoft SQL Server"
                InstallSharedWOWDir = "C:\Program Files (x86)\Microsoft SQL Server"
                InstanceDir = "C:\Program Files\Microsoft SQL Server"
                InstallSQLDataDir = "C:\Program Files\Microsoft SQL Server\MSSQL13.MSSQLSERVER\MSSQL\Data"
                SQLUserDBDir = "C:\Program Files\Microsoft SQL Server\MSSQL13.MSSQLSERVER\MSSQL\Data"
                SQLUserDBLogDir = "C:\Program Files\Microsoft SQL Server\MSSQL13.MSSQLSERVER\MSSQL\Data"
                SQLTempDBDir = "C:\Program Files\Microsoft SQL Server\MSSQL13.MSSQLSERVER\MSSQL\Data"
                SQLTempDBLogDir = "C:\Program Files\Microsoft SQL Server\MSSQL13.MSSQLSERVER\MSSQL\Data"
                SQLBackupDir = "C:\Program Files\Microsoft SQL Server\MSSQL13.MSSQLSERVER\MSSQL\Data"
            }
         
            xSqlServerFirewall ($Node.NodeName) {
                DependsOn = ("[xSqlServerSetup]" + $Node.NodeName)
                SourcePath = $Node.SourcePath
                InstanceName = $Node.InstanceName
                Features = $Node.Features
            }
            xSQLServerPowerPlan ($Node.Nodename) {
                Ensure = "Present"
            }
            xSQLServerMemory ($Node.Nodename) {
                DependsOn = ("[xSqlServerSetup]" + $Node.NodeName)
                Ensure = "Present"
                DynamicAlloc = $false
                SQLInstanceName = $Node.InstanceName
                MinMemory = "256"
                MaxMemory ="1024"
            }
            xSQLServerMaxDop ($Node.Nodename) {
                DependsOn = ("[xSqlServerSetup]" + $Node.NodeName)
                Ensure = "Present"
                DynamicAlloc = $true
            }
            xSQLServerLogin ($Node.Nodename+"TestUser1") {
                DependsOn = ("[xSqlServerSetup]" + $Node.NodeName)
                Ensure = "Present"
                Name = "TestUser1"
                LoginCredential = $TestUser1Credential
                LoginType = "SQLLogin"
            }
            xSQLServerLogin ($Node.Nodename+"TestUser2") {
                DependsOn = ("[xSqlServerSetup]" + $Node.NodeName)
                Ensure = "Present"
                Name = "TestUser2"
                LoginCredential = $TestUser2Credential
                LoginType = "SQLLogin"
            }
            xSQLServerDatabaseRole ($Node.Nodename) {
                DependsOn = ("[xSqlServerSetup]" + $Node.NodeName)
                Ensure = "Present"
                Name = "TestUser1"
                Database = "model"
                Role ="db_Datareader"
            }
            xSQLServerDatabasePermissions ($Node.Nodename) {
                Database = "Model"
                Name = "TestUser1"
                Permissions ="SELECT","DELETE"
            }
            xSQLServerDatabase ($Node.Nodename) {
                Database = "TestDB"
                Ensure = "Present"
            }
            xSQLDatabaseRecoveryModel ($Node.Nodename) {
                DependsOn = ("[xSQLServerDatabase]" + $Node.NodeName)
                DatabaseName = "TestDB"
                RecoveryModel = "Full"
                SqlServerInstance ="$($Node.NodeName)\$($Node.SQLInstanceName)"  
            }
            xSQLServerDatabaseOwner ($Node.Nodename) {
                DependsOn = ("[xSQLServerDatabase]" + $Node.NodeName)
                Database = "TestDB"
                Name = "TestUser2"
            }
        }
    }
}

$domainInstallCredential = (Get-Credential -Credential 'CORP\SQLAutoSvc')
$testUser1Credential = (Get-Credential -Credential 'TestUser1')
$testUser2Credential = (Get-Credential -Credential 'TestUser2')
$outputPath = 'C:\Program Files\WindowsPowerShell\Configuration\Schema'

$SQLSAConfigParams = @{
    OutputPath              = $outputPath
    ConfigurationData       = '.\SQLPush_SingleServer.psd1'
    DomainInstallCredential = $domainInstallCredential
    TestUser1Credential     = $testUser1Credential
    TestUser2Credential     = $testUser2Credential
}

SQLSA @SQLSAConfigParams
Start-DscConfiguration -Path $outputPath -Wait -Verbose -Force
