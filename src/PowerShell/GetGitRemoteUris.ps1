$uris = ls ~/git | %{cd $_.name; git remote -v | ?{$_ -match '^origin.*push\)$'} | %{(($_ -split '\t')[1] -split ' ')[0]} ; cd ..}
