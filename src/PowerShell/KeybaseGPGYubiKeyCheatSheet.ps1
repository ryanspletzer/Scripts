# Inspiration: https://www.hanselman.com/blog/HowToSetupSignedGitCommitsWithAYubiKeyNEOAndGPGAndKeybaseOnWindows.aspx

# pre-reqs
choco install gpg4win
# choco install keybase # optional

#region To generate a key / sub-keys

# 4096 bits RSA (1) key is valid for 16 years
# Real name: e.g. Ryan Spletzer
# email: e.g. ryan.spletzer@autodesk.com
# email: e.g. ryanspletzer@gmail.com
# passphrase
gpg --gen-key # or if using keybase, keybase pgp gen



# https://alexcabal.com/creating-the-perfect-gpg-keypair/

# Add photo to public key (small, < 5KB)
gpg --edit-key ryan.spletzer@autodesk.com #assuming there is only 1 key in the keyring with this email address
# gpg> addphoto
# gpg> save

# trust the new uid's
gpg --edit-key ryan.spletzer@autodesk.com
# gpg> trust
# 5
# gpg> save

# Set preferred algo's
gpg --edit-key ryan.spletzer@autodesk.com
# gpg> setpref SHA512 SHA384 SHA256 SHA224 AES256 AES192 AES CAST5 ZLIB BZIP2 ZIP Uncompressed
# gpg> save

# Add signing key (only comes with 1 encryption key by default with keybase commands)
gpg --edit-key ryan.spletzer@autodesk.com
# gpg> addkey
# 4 RSA (sign only)
# 4096
# Key is valid for 16 years
# gpg> save

# Create a revocation certificate
gpg --output ryan.spletzer@autodesk.com.gp-revocation-certificate --gen-revoke ryan.spletzer@autodesk.com
# Accept defaults / suggestions

# Export public and private key and revocation certificate
gpg --export-secret-keys --armor ryan.spletzer@autodesk.com > ryan.spletzer@autodesk.com.private.gpg-key
gpg --export --armor ryan.spletzer@autodesk.com > ryan.spletzer@autodesk.com.public.gpg-key

# Store private, public and revocation certificate somewhere safe, like LastPass

# Optional sync keybase with the new pgp public keys, if using keybase pgp gen
keybase pgp update

#endregion To generate a key / sub-keys

#region To move onto your YubiKey

# Plug in the YubiKey, give it a sec; test if gpg sees the YubiKey
gpg --card-status

# If this is the first time using your YubiKey, set your admin and regular PINs
# gpg --card-edit
# gpg> admin
# gpg> passwd
# gpg> 3
# gpg> 1
# (admin is the one you use most of the time for signing)
# admin default PIN is typically 12345678 and regular PIN is typically 123456 by default, set to different PINs
# eight and six digits (or characters?! didn't test) in length respectively
# gpg> Q
# gpg> quit
gpg --edit-key ryan.spletzer@autodesk.com
# NOTE: <index> is the zero-based index of the key you want to select. the primary key is key 0, the first subkey is
# key 1, the second subkey is key 2. You want the key with "S" aka signing capability. Typically will be key 2 if
# generated from keybase and added on after the first "E" encryption subkey.
# gpg> key <index>
# NOTE: keytocard is a destructive operation and will overwrite an existing type of key on the YubiKey!
# gpg> keytocard
# select 1 Signature key
# ***NOTE***: at this point the key has been copied to the YubiKey -- it is still present on the computer in the GPG
# keyring. if / when you type "save" it will REMOVE the private key from the keyring and you are totally reliant on the
# YubiKey at that point for this machine (unless you purge and reload the keys onto the keyring).
# enter the ADMIN PIN (not the normal pin)
# gpg> save

#endregion To move onto your YubiKey

#region Configure git

# Upload the contents of your public key to GitHub Enterprise / GitHub etc.

# macOS
# git config --global gpg.program "/opt/homebrew/bin/gpg"
git config --global gpg.program "c:\Program Files (x86)\GnuPG\bin\gpg.exe"
git config --global commit.gpgsign true # leave this off if you don't want to sign by default every time
git config --global user.signingkey THEKEYIDFORTHE4096BITSIGNINGKEY

# test sign a commit -- you should see a pop-up for the key passphrase to sign which you enter
git commit -m "Your commit message"
# if commit.gpgsign is not set, you need to explicitly do
git commit -S -m "Your commit message"
# to see it on the server
git push

# IMPORTANT: your email must be set in git config for this to work properly e.g.
git config --global user.email "ryan.spletzer@autodesk.com"

# Test sign with gpg
new-item test.txt
gpg --sign .\test.txt
get-childitem
remove-item test.txt
remove-item test.txt.gpg

#endregion Configure git

#region To use with YubiKey on another machine (e.g. on Lenovo)

# Plug in Yubikey
gpg --card-status

# Optional: get public key(s) from keybase, else copy by hand
mkdir ~/.keybase
cd ~/.keybase
keybase pgp export --outfile keybase-public.key

# Import public key(s) to GPG
gpg --import .\ryan.spletzer@autodesk.com.public.gpg-key # or: gpg --import .\keybase-public.key

# Trust keys
gpg --edit-key ryan.spletzer@autodesk.com
# gpg> trust
# 5
# gpg> save

# Cleanup .keybase
Remove-Item ~/.keybase -recurse -force

# Then run same git commands above

#endregion To use with YubiKey on another machine (e.g. on Lenovo)

#region To use *without* YubiKey on another machine (e.g. on CloudPC)

# Optional: get public and private key(s) from keybase, else copy by hand
mkdir ~/.keybase
cd ~/.keybase
keybase pgp export --outfile keybase-public.key
keybase pgp export --secret --outfile keybase-private.key

# Copy public and private key files to the machine, then
gpg --allow-secret-key-import --import .\ryan.spletzer@autodesk.com.private.gpg-key
# or: gpg --allow-secret-key-import --import .\keybase-private.key
gpg --import .\ryan.spletzer@autodesk.com.public.gpg-key
# or: gpg --allow-secret-key-import --import .\keybase-public.key
gpg --edit-key ryan.spletzer@autodesk.com
# gpg> trust
# 5
# y
# gpg> save

Remove-Item ~/.keybase -recurse -force

# Then run same git commands above

#endregion To use *without* YubiKey on another machine (e.g. on CloudPC)
