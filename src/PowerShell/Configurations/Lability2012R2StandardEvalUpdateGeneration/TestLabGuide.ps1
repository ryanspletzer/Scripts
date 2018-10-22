Configuration TestLabGuide {
<#
    Requires the following custom DSC resources:
        xComputerManagement (v1.4.0.0 or later): https://github.com/PowerShell/xComputerManagement
#>
    param ()
    Import-DscResource -Module xComputerManagement, xNetworking

    node $AllNodes.Where({$true}).NodeName {
        LocalConfigurationManager {
            RebootNodeIfNeeded   = $true;
            AllowModuleOverwrite = $true;
            ConfigurationMode = 'ApplyOnly';
            CertificateID = $node.Thumbprint;
        }

        xComputer 'Hostname' {
            Name = $node.NodeName;
        }
        
        xNetConnectionProfile 'EthernetPrivate' {
            InterfaceAlias = 'Ethernet'
            NetworkCategory = 'Private'
        }
    }
}
