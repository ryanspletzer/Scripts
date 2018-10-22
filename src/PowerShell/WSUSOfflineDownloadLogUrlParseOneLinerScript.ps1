#WSUS Offline download.log oneliner
param (
    $LogPath
)

Select-String -Path $LogPath -Pattern "(http://download.windowsupdate.com)[-a-zA-z0-9./]+(.cab)\b" -AllMatches