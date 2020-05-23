Import-Module Lability -Force
Get-Command -Module Lability
Get-LabHostDefault
Set-LabHostDefault -ConfigurationPath F:\TestLab\Configurations -DifferencingVhdPath 'F:\TestLab\VM Disks' -HotfixPath F:\TestLab\Hotfixes -IsoPath F:\TestLab\ISOs -ParentVhdPath 'F:\TestLab\Parent Disks' -ResourcePath F:\TestLab\Resources

<#
    Test host configuration and start configuration if necessary (Start-LabConfiguration calls Test-LabConfiguration anyway!) #>
Test-LabHostConfiguration -Verbose
Start-LabHostConfiguration -Verbose

<#
    Import configuration into session and generate the MOFs #>
. .\TestLabGuide.ps1
TestLabGuide -OutputPath F:\TestLab\Configurations -ConfigurationData .\TestLabGuide.psd1

<#
    Set the lab VM defaults, create the lab and start the VMs #>
Get-LabVMDefault
Set-LabVMDefault -SystemLocale en-US -InputLocale 0409:00000409 -UserLocale en-US -RegisteredOrganization 'Contoso' -StartupMemory 2GB
Start-LabConfiguration -ConfigurationData .\TestLabGuide.psd1 -Path F:\TestLab\Configurations -Verbose -Force

## ADD ADDITIONAL NIC
#Add-VMNetworkAdapter -VMName EDGE1 -SwitchName Internet

<# Start Lab #>
Start-Lab -ConfigurationData .\TestLabGuide.psd1 -Verbose

<#
    List available 'included' media #>
Get-LabMedia | Select Id, Description, Filename

<#
    List (currently) configured images #>
Get-LabImage | Select Id, ImagePath

<# Stop Lab #>
Stop-Lab -ConfigurationData .\TestLabGuide.psd1 -Verbose




<# Reset lab #>
Import-Module Lability -Force
Remove-LabConfiguration -ConfigurationData .\TestLabGuide.psd1 -Verbose