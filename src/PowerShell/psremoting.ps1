Enable-PSRemoting -Force
winrm quickconfig
Set-Item wsman:localhost\client\trustedhosts -Value *
Enable-WSManCredSSP -Role Server -Force
Enable-WSManCredSSP -Role Client -DelegateComputer * -Force
