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
            ConfigurationMode    = 'ApplyOnly';
            CertificateID        = $node.Thumbprint;
        }

        xComputer 'Hostname' {
            Name = $node.NodeName;
        }

        xNetConnectionProfile 'EthernetPrivate' {
            InterfaceAlias   = 'Ethernet'
            NetworkCategory  = 'Private'
        }

        xFirewall 'Network Discovery (Pub WSD-Out)' {
            DependsOn = '[xNetConnectionProfile]EthernetPrivate'
            Name      = '{E932EA36-1898-4FD6-8536-503EC5EFC306}'
            Profile   = 'Private'
        }
        xFirewall 'Network Discovery (Pub-WSD-In)' {
            DependsOn = '[xNetConnectionProfile]EthernetPrivate'
            Name      = '{7807E9C5-C3DF-41EB-8DA4-F4E46254763F}'
            Profile   = 'Private'
        }
        xFirewall 'Network Discovery (LLMNR-UDP-Out)' {
            DependsOn = '[xNetConnectionProfile]EthernetPrivate'
            Name      = '{EE815626-2441-4411-AFCB-DFA3A72B333E}'
            Profile   = 'Private'
        }
        xFirewall 'Network Discovery (LLMNR-UDP-In)' {
            DependsOn = '[xNetConnectionProfile]EthernetPrivate'
            Name      = '{320B0154-528E-489D-8C8A-FE89D7BD02E0}'
            Profile   = 'Private'
        }
        xFirewall 'Network Discovery (WSD-Out)' {
            DependsOn = '[xNetConnectionProfile]EthernetPrivate'
            Name      = '{3CD900B4-6D3F-4E14-873E-9251F84E40FD}'
            Profile   = 'Private'
        }
        xFirewall 'Network Discovery (WSD-In)' {
            DependsOn = '[xNetConnectionProfile]EthernetPrivate'
            Name      = '{830102E2-C146-4997-A9C6-45DA35013058}'
            Profile   = 'Private'
        }
        xFirewall 'Network Discovery (UPnPHost-Out)' {
            DependsOn = '[xNetConnectionProfile]EthernetPrivate'
            Name      = '{078A459D-0852-44B0-8EC8-80F6F94CEC39}'
            Profile   = 'Private'
        }
        xFirewall 'Network Discovery (SSDP-Out)' {
            DependsOn = '[xNetConnectionProfile]EthernetPrivate'
            Name      = '{94EADE61-D5B2-453B-81BE-601DF758B20D}'
            Profile   = 'Private'
        }
        xFirewall 'Network Discovery (SSDP-In)' {
            DependsOn = '[xNetConnectionProfile]EthernetPrivate'
            Name      = '{FDAD323F-B7B3-4F05-BD65-28A91E343578}'
            Profile   = 'Private'
        }
        xFirewall 'Network Discovery (WSD Events-Out)' {
            DependsOn = '[xNetConnectionProfile]EthernetPrivate'
            Name      = '{CF7248CC-D160-49A5-B089-CC0855673CE5}'
            Profile   = 'Private'
        }
        xFirewall 'Network Discovery (WSD Events-In)' {
            DependsOn = '[xNetConnectionProfile]EthernetPrivate'
            Name      = '{20E755A9-3348-4CB1-AB82-4BD9610288BC}'
            Profile   = 'Private'
        }
        xFirewall 'Network Discovery (WSD EventsSecure-Out)' {
            DependsOn = '[xNetConnectionProfile]EthernetPrivate'
            Name      = '{A0B3B5F1-569D-464E-B5DF-479CF0FB1E17}'
            Profile   = 'Private'
        }
        xFirewall 'Network Discovery (WSD EventsSecure-In)' {
            DependsOn = '[xNetConnectionProfile]EthernetPrivate'
            Name      = '{4D7BF087-8EA1-43E1-AB47-0330CB191B56}'
            Profile   = 'Private'
        }
        xFirewall 'Network Discovery (NB-Datagram-Out)' {
            DependsOn = '[xNetConnectionProfile]EthernetPrivate'
            Name      = '{0C4192CD-0439-46BA-AE73-A08F2A0BE373}'
            Profile   = 'Private'
        }
        xFirewall 'Network Discovery (NB-Datagram-In)' {
            DependsOn = '[xNetConnectionProfile]EthernetPrivate'
            Name      = '{2F0B1706-86F6-46BA-854F-A6445989F595}'
            Profile   = 'Private'
        }
        xFirewall 'Network Discovery (NB-Name-Out)' {
            DependsOn = '[xNetConnectionProfile]EthernetPrivate'
            Name      = '{C7E0E361-C03D-4226-82A4-BD6C49DC05D2}'
            Profile   = 'Private'
        }
        xFirewall 'Network Discovery (NB-Name-In)' {
            DependsOn = '[xNetConnectionProfile]EthernetPrivate'
            Name      = '{DA65EC4E-06BE-4085-BC49-437B93222981}'
            Profile   = 'Private'
        }
        xFirewall 'Network Discovery (UPnP-Out)' {
            DependsOn = '[xNetConnectionProfile]EthernetPrivate'
            Name      = '{32B24916-4C1E-45AE-A3F8-35B2A8AA1BE3}'
            Profile   = 'Private'
        }
        xFirewall 'Network Discovery (UPnP-In)' {
            DependsOn = '[xNetConnectionProfile]EthernetPrivate'
            Name      = '{E461491A-E834-45A9-9906-11373FC105E0}'
            Profile   = 'Private'
        }
    }
}
