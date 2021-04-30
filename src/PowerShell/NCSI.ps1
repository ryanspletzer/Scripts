# This app runs the same tests as the Network Connection Status Indicator (NCSI) using WinHTTP, not IE as a proxy.
#
# Open PowerShell and navigate to this script, Run it using ./NCSItest
# 
# Any failed tests will show in red text.
cls
Write-host "Any failures will show in red" -ForegroundColor Red
Start-Sleep 1
Write-Host ""

Write-Host "Confirming WinHTTP is not using a proxy" -ForegroundColor Green
Write-Host "WinHTTP should show: " -ForegroundColor Green -NoNewLine;
Write-Host "Direct access (no proxy server)" -ForegroundColor Yellow
Start-Sleep 1
netsh winhttp show proxy
Start-Sleep 1
Write-Host ""

Write-Host "Trying to reach msftconnecttest.com; You should see" -ForegroundColor Green -NoNewLine;
Write-Host " StatusCode: 200" -ForegroundColor Yellow
Start-Sleep 1
Write-Host ""

Invoke-webrequest "http://www.msftconnecttest.com/connecttest.txt"
Start-Sleep 1
Write-Host ""

Write-Host "Trying to resolve dns.msftncsi.com" -ForegroundColor Green
Write-Host ""
Write-Host "Testing Domain Name Resolution..." -ForegroundColor Green
Start-Sleep 1
Write-Host ""

Resolve-DnsName "dns.msftncsi.com"
Write-Host "Does IPV6 = " -ForegroundColor Green -NoNewLine; 
Write-Host " fd3e:4f5a:5b81::1" -ForegroundColor Yellow
Write-Host "Does IPV4 = " -ForegroundColor Green -NoNewLine;
Write-Host " 131.107.255.255" -ForegroundColor Yellow
Write-Host""
Write-Host "Network Connection Status Indicator test complete" -ForegroundColor Green
