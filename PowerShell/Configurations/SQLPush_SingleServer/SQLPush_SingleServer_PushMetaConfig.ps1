#requires -Version 5

[DSCLocalConfigurationManager()]
Configuration PushMetaConfig {
    Node localhost {
        Settings {
            ActionAfterReboot = 'StopConfiguration'
            AllowModuleOverwrite = $True
            ConfigurationMode = 'ApplyAndMonitor'
            RefreshMode = 'Push'
            RebootNodeIfNeeded = $True
            DebugMode = 'All'
        }
    }
}

PushMetaConfig -OutputPath 'C:\Program Files\WindowsPowerShell\Configuration\Schema'
Set-DscLocalConfigurationManager -Path 'C:\Program Files\WindowsPowerShell\Configuration\Schema' -Force -Verbose
