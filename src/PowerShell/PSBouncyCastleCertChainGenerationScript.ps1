<#
    .SYNOPSIS
        A script for generating a certificate chain for development / testing purposes using the PSBouncyCastle
        module, which wraps the Bouncy Castle C# library.

    .PARAMETER CompanyName
        CompanyName will be used in the subject name and other attributes of the certificates. Specify -CompanyName
        as a parameter for this script or be interactively prompted for one.

    .PARAMETER CompanyWebsite
        The company website for the issuer.

    .PARAMETER SSLSubjectCN
        The SSL Subject common name.

    .PARAMETER SSLSANs
        The SSL Subject alternative names in a string array.

    .PARAMETER Organization
        The organization for the child certificates (can be different from the issuer).

    .PARAMETER Location
        The location for the child certificates (usually city).

    .PARAMETER Country
        The country abbrevation for the child certificates.

    .PARAMETER DocEncryptionSubjectCN
        The Subject common name for the document encryption certificate (can be whatever you want).

    .PARAMETER PfxPassword
        Optional password to use to secure the Pfx certificates.

    .PARAMETER OutputDirectory
        Output directory path where the certificate chain files will be exported. Specify -OutputPath as a
        paramter for this script or be interactively promptd for one.

    .LINKS
        This script is based on examples provided by PSBouncyCastle PowerShell module's author Roger Lipscombe.

        Module: 
        https://github.com/rlipscombe/PSBouncyCastle

        Blog Posts:
        http://blog.differentpla.net/blog/2013/04/17/how-do-i-use-bouncy-castle-from-powershell
        http://blog.differentpla.net/blog/2013/04/17/powershell-bouncy-castle-and-extended-key-usage
        http://blog.differentpla.net/blog/2013/04/17/powershell-bouncy-castle-and-subject-alternative-names

        References:
        http://www.bouncycastle.org/wiki/display/JA1/X.509+Public+Key+Certificate+and+Certification+Request+Generation
    
    .NOTES
        This script models its cert chain after DigiCert's root and intermediate attribute usage. Child certs
        that are created are an SSL certificate as well as a document encryption certificate. SSL is useful for IIS
        purposes. Document encryption is useful for PowerShell Desired State Configuration encryption of secrets in
        the MOF file. More child certs could be created for different uses (like client authentication) but this
        fit my needs for now.

        This script purposefully does not include Authority Information Access attribute for OCSP, cRL Distribution
        Points attribute or Certificate Policies, or Extended Validation attributes, as these are often
        environment- and/or browser-specific.
#>

param (
    [ValidateNotNullOrEmpty()]
    [String]
    $CompanyName = (Read-Host -Prompt "Enter a the issuing company name"),

    [ValidateNotNullOrEmpty()]
    [String]
    $CompanyWebSite = (Read-Host -Prompt "Enter the issuing company website in the form www.company.com"),

    [ValidateNotNullOrEmpty()]
    [String]
    $SSLSubjectCN = (Read-Host -Prompt "Enter subject common name for SSL cert (hint: wildcard or standard URL)"),

    [String[]]
    $SSLSANs = (Read-Host -Prompt "Enter a comma-separated list of subject alternative names for SSL").Split(","),

    [ValidateNotNullOrEmpty()]
    [String]
    $Organization = (Read-Host -Prompt "Enter organization (can be same or different from issuing company name)"),

    [ValidateNotNullOrEmpty()]
    [String]
    $Location = (Read-Host -Prompt "Enter the location / site"),

    [ValidateNotNullOrEmpty()]
    [String]
    $Country = (Read-Host -Prompt "Enter the country abbreviation"),
    
    [ValidateNotNullOrEmpty()]
    [String]
    $DocEncryptionSubjectCN = (Read-Host -Prompt "Enter the subject common name for doc encryption cert (anything)"),

    [ValidateNotNullOrEmpty()]
    [SecureString]
    $PfxPassword = (Read-Host -Prompt "Enter the Pfx password" -AsSecureString),

    [ValidateScript({
        (Test-Path -Path $_ -PathType Container)
    })]
    [ValidateNotNullOrEmpty()]
    [String]
    $OutputDirectory = (Read-Host -Prompt "Enter an output directory path")
)

#region Install the Module if need be. 
# You can hand copy into Program Files\WindowsPowerShell\Modules if you like and skip these lines.
# Below requires that git is available in your PATH to call. If not, pop into the Git Shell and run this.
if (-not (Get-Module -Name PSBouncyCastle -ListAvailable)) {
    Set-Location (Join-Path (Split-Path $PROFILE) 'Modules')
    git clone https://github.com/rlipscombe/PSBouncyCastle.git
}
#endregion

Import-Module -Name PSBouncyCastle

#region Generate the Root Certificate
Write-Verbose -Message "Generating Root Certificate"
$random = New-SecureRandom
$serialNumber = New-SerialNumber -Random $random
$certificateGenerator = New-CertificateGenerator
$certificateGenerator.SetSerialNumber($serialNumber)
$signatureAlgorithm = "SHA1WITHRSAENCRYPTION"
$certificateGenerator.SetSignatureAlgorithm($signatureAlgorithm)
$subjectName = "C=$Country,O=$CompanyName,OU=$CompanyWebSite,CN=$CompanyName Global Root CA"
$subjectDN = New-Object Org.BouncyCastle.Asn1.X509.X509Name($subjectName)
$issuerDN = $subjectDN
$certificateGenerator.SetIssuerDN($issuerDN)
$certificateGenerator.SetSubjectDN($subjectDN)
$notBefore = [DateTime]::UtcNow.Date
$certificateGenerator.SetNotBefore($notBefore)
$notAfter = $notBefore.AddYears(30)
$certificateGenerator.SetNotAfter($notAfter)
$subjectKeyPair = New-KeyPair -Random $random
$certificateGenerator.SetPublicKey($subjectKeyPair.Public)
$issuerKeyPair = $subjectKeyPair
$issuerSerialNumber = $serialNumber
$authorityKeyIdentifier = New-AuthorityKeyIdentifier -name $issuerDN -publicKey $issuerKeyPair.Public -serialNumber $issuerSerialNumber
$subjectKeyIdentifier = New-SubjectKeyIdentifier -publicKey $subjectKeyPair.Public
$certificateGenerator |
    Add-AuthorityKeyIdentifier -authorityKeyIdentifier $authorityKeyIdentifier |
    Add-SubjectKeyIdentifier -subjectKeyIdentifier $subjectKeyIdentifier |
    Add-BasicConstraints -isCertificateAuthority $true |
    Add-KeyUsage -DigitalSignature -KeyCertSign -CrlSign |
    Add-ExtendedKeyUsage -ServerAuthentication -ClientAuthentication -EmailProtection -CodeSigning -TimeStamping |
    Out-Null
$certificate = $certificateGenerator.Generate($issuerKeyPair.Private, $random)
$result = ConvertFrom-BouncyCastleCertificate -certificate $certificate -subjectKeyPair $subjectKeyPair -friendlyName $CompanyName

Export-Certificate -Certificate $result -OutputFile ($OutputDirectory.TrimEnd("\") + "\root.pfx") -OutputFormat 'DER' -X509ContentType "Pfx" -Password $PfxPassword
Write-Verbose -Message "Root Certificate Generated"
#endregion

#region Generate the Intermediate Signing Certificate
Write-Verbose -Message "Generating Intermediate Signing Certificate"
$serialNumber = New-SerialNumber -Random $random
$certificateGenerator = New-CertificateGenerator
$certificateGenerator.SetSerialNumber($serialNumber)
$signatureAlgorithm = "SHA256WITHRSAENCRYPTION"
$certificateGenerator.SetSignatureAlgorithm($signatureAlgorithm)
$certificateGenerator.SetIssuerDN($issuerDN)
$subjectName = "C=$Country,O=$CompanyName,CN=$CompanyName SHA 2 Intermediate CA"
$subjectDN = New-Object Org.BouncyCastle.Asn1.X509.X509Name($subjectName)
$certificateGenerator.SetSubjectDN($subjectDN)
$notBefore = [DateTime]::UtcNow.Date
$certificateGenerator.SetNotBefore($notBefore)
$notAfter = $notBefore.AddYears(29)
$certificateGenerator.SetNotAfter($notAfter)
$subjectKeyPair = New-KeyPair -Random $random
$certificateGenerator.SetPublicKey($subjectKeyPair.Public)
$authorityKeyIdentifier = New-AuthorityKeyIdentifier -name $issuerDN -publicKey $issuerKeyPair.Public -serialNumber $issuerSerialNumber
$subjectKeyIdentifier = New-SubjectKeyIdentifier -publicKey $subjectKeyPair.Public
$certificateGenerator |
    Add-AuthorityKeyIdentifier -authorityKeyIdentifier $authorityKeyIdentifier |
    Add-SubjectKeyIdentifier -subjectKeyIdentifier $subjectKeyIdentifier |
    Add-BasicConstraints -isCertificateAuthority $true |
    Add-KeyUsage -DigitalSignature -KeyCertSign -CrlSign |
    Add-ExtendedKeyUsage -ServerAuthentication -ClientAuthentication -EmailProtection -CodeSigning -TimeStamping |
    Out-Null
$certificate = $certificateGenerator.Generate($issuerKeyPair.Private)
$result = ConvertFrom-BouncyCastleCertificate -certificate $certificate -subjectKeyPair $subjectKeyPair -friendlyName "$CompanyName SHA 2 Intermediate CA"
$issuerSerialNumber = $serialNumber
$issuerKeyPair = $subjectKeyPair
$issuerDN = $subjectDN
Export-Certificate -Certificate $result -OutputFile ($OutputDirectory.TrimEnd("\") + "\intermediate.pfx") -OutputFormat 'DER' -X509ContentType "Pfx" -Password $PfxPassword
Write-Verbose -Message "Intermediate Signing Certificate Generated"
#endregion

#region Generate the SSL Certificate
Write-Verbose -Message "Generating SSL Certificate"
$serialNumber = New-SerialNumber -Random $random
$certificateGenerator = New-CertificateGenerator
$certificateGenerator.SetSerialNumber($serialNumber)
$signatureAlgorithm = "SHA256WITHRSAENCRYPTION"
$certificateGenerator.SetSignatureAlgorithm($signatureAlgorithm)
$certificateGenerator.SetIssuerDN($issuerDN)
$subjectName = "C=$Country,L=$Location,O=$Organization,CN=$SSLSubjectCN"
$subjectDN = New-Object Org.BouncyCastle.Asn1.X509.X509Name($subjectName)
$certificateGenerator.SetSubjectDN($subjectDN)
$notBefore = [DateTime]::UtcNow.Date
$certificateGenerator.SetNotBefore($notBefore)
$notAfter = $notBefore.AddYears(29)
$certificateGenerator.SetNotAfter($notAfter)
$subjectKeyPair = New-KeyPair -Random $random
$certificateGenerator.SetPublicKey($subjectKeyPair.Public)
$authorityKeyIdentifier = New-AuthorityKeyIdentifier -name $issuerDN -publicKey $issuerKeyPair.Public -serialNumber $issuerSerialNumber
$subjectKeyIdentifier = New-SubjectKeyIdentifier -publicKey $subjectKeyPair.Public
$certificateGenerator |
    Add-AuthorityKeyIdentifier -authorityKeyIdentifier $authorityKeyIdentifier |
    Add-SubjectKeyIdentifier -subjectKeyIdentifier $subjectKeyIdentifier |
    Add-BasicConstraints -isCertificateAuthority $false |
    Add-KeyUsage -DigitalSignature -KeyEncipherment |
    Add-ExtendedKeyUsage -ServerAuthentication -ClientAuthentication |
    Add-SubjectAlternativeName -DnsName $SSLSANs |
    Out-Null
$certificate = $certificateGenerator.Generate($issuerKeyPair.Private)
$result = ConvertFrom-BouncyCastleCertificate -certificate $certificate -subjectKeyPair $subjectKeyPair -friendlyName $SSLSubjectCN
Export-Certificate -Certificate $result -OutputFile ($OutputDirectory.TrimEnd("\") + "\ssl.pfx") -OutputFormat 'DER' -X509ContentType "Pfx" -Password $PfxPassword
Write-Verbose -Message "SSL Certificate Generated"
#endregion

#region Generate the Document Encryption Certificate
Write-Verbose -Message "Generating Document Encryption Certificate"
$serialNumber = New-SerialNumber -Random $random
$certificateGenerator = New-CertificateGenerator
$certificateGenerator.SetSerialNumber($serialNumber)
$signatureAlgorithm = "SHA256WITHRSAENCRYPTION"
$certificateGenerator.SetSignatureAlgorithm($signatureAlgorithm)
$certificateGenerator.SetIssuerDN($issuerDN)
$subjectName = "C=$Country,L=$Location,O=$Organization,CN=$DocEncryptionSubjectCN"
$subjectDN = New-Object Org.BouncyCastle.Asn1.X509.X509Name($subjectName)
$certificateGenerator.SetSubjectDN($subjectDN)
$notBefore = [DateTime]::UtcNow.Date
$certificateGenerator.SetNotBefore($notBefore)
$notAfter = $notBefore.AddYears(29)
$certificateGenerator.SetNotAfter($notAfter)
$subjectKeyPair = New-KeyPair -Random $random
$certificateGenerator.SetPublicKey($subjectKeyPair.Public)
$authorityKeyIdentifier = New-AuthorityKeyIdentifier -name $issuerDN -publicKey $issuerKeyPair.Public -serialNumber $issuerSerialNumber
$subjectKeyIdentifier = New-SubjectKeyIdentifier -publicKey $subjectKeyPair.Public
$certificateGenerator |
    Add-AuthorityKeyIdentifier -authorityKeyIdentifier $authorityKeyIdentifier |
    Add-SubjectKeyIdentifier -subjectKeyIdentifier $subjectKeyIdentifier |
    Add-BasicConstraints -isCertificateAuthority $false |
    Add-KeyUsage -DigitalSignature -KeyEncipherment |
    Add-ExtendedKeyUsage -Oid "1.3.6.1.4.1.311.80.1" |
    Out-Null
$certificate = $certificateGenerator.Generate($issuerKeyPair.Private)
$result = ConvertFrom-BouncyCastleCertificate -certificate $certificate -subjectKeyPair $subjectKeyPair -friendlyName $DocEncryptionSubjectCN
Export-Certificate -Certificate $result -OutputFile ($OutputDirectory.TrimEnd("\") + "\docencryption.pfx") -OutputFormat 'DER' -X509ContentType "Pfx" -Password $PfxPassword
Write-Verbose -Message "Document Encryption Certificate Generated"
#endregion
