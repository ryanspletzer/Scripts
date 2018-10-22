@{
    AllNodes = @(
        @{
            NodeName = '*'
            PSDscAllowPlainTextPassword = $true
            PSDscAllowDomainUser = $true
            #NETPath = '\\localhost\C$\SQLBuilds\SQLAutoInstall\WIN2016TP5\sxs'
            SourcePath = 'C:\SQLBuilds\SQLAutoInstall\SQL2016'
            #InstallerServiceAccount = "CORP\SQLAutoSvc"
            AdminAccount = "CORP\sqladmin"  
        }
        @{
            NodeName = 'localhost'
            InstanceName = "MSSQLSERVER"
            Features = "SQLENGINE,IS"
        }
    )
    NonNodeData = @{
    }
}