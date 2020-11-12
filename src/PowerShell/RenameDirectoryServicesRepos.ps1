gci | ?{$_.Name -like 'Dir*' -and $_.Name -notlike '*-chef' -and $_.Name -notlike '*-azure-pipe*'} | %{ $newname = $_.Name -Replace 'DirectoryServices-', ''; rename-item $_.Name $newname}
