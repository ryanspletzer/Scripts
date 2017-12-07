Enable-PSRemoting -Force
Set-Item wsman:localhost\client\trustedhosts -Value *
Enable-WSManCredSSP -Role Server -Force
Enable-WSManCredSSP -Role Client -DelegateComputer * -Force
