Get-NetAdapter 'vEthernet (WSL)' | Disable-NetAdapter -Confirm:$false
# Connect VPN
Get-NetAdapter 'vEthernet (WSL)' | Enable-NetAdapter
