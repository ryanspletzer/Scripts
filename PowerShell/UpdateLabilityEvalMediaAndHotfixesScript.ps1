$evalRegistrations = Get-LabMedia | Where-Object{
    $_.Id -like "*_Eval"
}
$evalRegistrations | ForEach-Object{
    $currentEvalRegistration = $_
    $equivalentNonEvalRegistration = Get-LabMedia | Where-Object{ 
        $_.Id -like $($currentEvalRegistration.Id.TrimEnd("_Eval").Replace("V5","V51"))
    }
    if ($equivalentNonEvalRegistration -ne $null) {
        $hotfixHtArray = [hashtable[]]@()
        $equivalentNonEvalRegistration.Hotfixes | ForEach-Object{
            $hotfixHtArray += @{Id = $_.Id; Uri = $_.Uri}
        }
        $registerLabMediaSplat = @{
            Id              = $($currentEvalRegistration.Id.Replace("V5","V51"))
            MediaType       = $currentEvalRegistration.MediaType
            Uri             = $currentEvalRegistration.Uri
            Architecture    = $currentEvalRegistration.Architecture
            Description     = $currentEvalRegistration.Description.Replace("WMF 5","WMF 5.1")
            ImageName       = $currentEvalRegistration.ImageName
            FileName        = $currentEvalRegistration.Filename
            Checksum        = $currentEvalRegistration.Checksum
            CustomData      = $currentRegistration.CustomData
            Hotfixes        = $hotfixHtArray
            OperatingSystem = $currentEvalRegistration.OperatingSystem
            Force           = $true
        }
        Register-LabMedia @registerLabMediaSplat
    }
}
