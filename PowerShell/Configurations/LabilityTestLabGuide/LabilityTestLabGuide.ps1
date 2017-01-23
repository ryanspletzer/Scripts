Import-Module Lability -Force
Get-Command -Module Lability
Get-LabHostDefaults
Set-LabHostDefaults -ConfigurationPath D:\TestLab\Configurations -DifferencingVhdPath 'D:\TestLab\VM Disks' -HotfixPath D:\TestLab\Hotfixes -IsoPath D:\TestLab\ISOs -ParentVhdPath 'C:\TestLab\Parent Disks' -ResourcePath D:\TestLab\Resources

<#
    Test host configuration and start configuration if necessary (Start-LabConfiguration calls Test-LabConfiguration anyway!) #>
Test-LabHostConfiguration -Verbose
Start-LabHostConfiguration -Verbose

<#
    Import configuration into session and generate the MOFs #>
. .\TestLabGuide.ps1
TestLabGuide -OutputPath D:\TestLab\Configurations -ConfigurationData .\TestLabGuide.psd1

<#
    Set the lab VM defaults, create the lab and start the VMs #>
Get-LabVMDefaults
Set-LabVMDefaults -SystemLocale en-US -InputLocale 0409:00000409 -UserLocale en-US -RegisteredOrganization 'Contoso' -StartupMemory 4GB
Start-LabConfiguration -ConfigurationData .\TestLabGuide.psd1 -Path D:\TestLab\Configurations -Verbose -Force

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