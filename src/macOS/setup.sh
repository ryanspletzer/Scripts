#!/bin/bash

mkdir ~/git

defaults write com.apple.Finder AppleShowAllFiles true
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
brew install git
brew cask install java
brew install git-credential-manager

brew install bash
brew install fish
brew cask install dotnet-sdk
brew cask install powershell
brew cask install homebrew/cask-versions/powershell-preview

sudo bash -c 'echo /usr/local/bin/bash >> /etc/shells'
sudo bash -c 'echo /usr/local/bin/pwsh >> /etc/shells'
bash -c "$(curl -fsSL https://raw.githubusercontent.com/ohmybash/oh-my-bash/master/tools/install.sh)"
curl -L https://github.com/oh-my-fish/oh-my-fish/raw/master/bin/install | fish
omf install agnoster
brew install zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
cd ~/git
git clone https://github.com/powerline/fonts.git --depth=1
cd fonts
./install.sh
cd ..
rm -rf fonts
sudo pwsh -Command "Set-PackageSource -Name PSGallery -Trusted -Force"
sudo pwsh -Command "Install-Module -Name Az, AWSPowerShell, posh-git"
sudo pwsh -Command "Update-Help"
mkdir ~/.config/powershell

brew install coreutils
brew install awscli
brew install azure-cli
brew install packer
brew install terraform
brew install vault
brew cask install google-chrome
brew cask install firefox
brew cask install tunnelblick
#brew install bash-git-prompt
brew cask install slack
brew cask install visual-studio-code
brew cask install visual-studio
brew cask install azure-data-studio
brew cask install intellij-idea-ce
brew install maven
brew cask install postman
brew cask install citrix-workspace
brew cask install zoomus
brew cask install zoom-outlook-plugin
brew cask install microsoft-azure-storage-explorer
brew install gnupg
brew cask install keybase
brew cask install homebrew/cask-drivers/drobo-dashboard
brew cask install docker
brew cask install steam
brew cask install iterm2
brew install ykman
brew install ykpers
brew install yubico-piv-tool
brew cask install yubico-yubikey-manager
brew cask install yubico-yubikey-personalization-github
brew cask install yubico-yubikey-piv-manager
brew cask install microsoft-teams
brew install lastpass-cli
brew install ruby
brew cask install spotify

mkdir ~/.tunnelblick
mkdir ~/.tunnelblick/Home.tblk

cp ./.config/fish/* ~/.config/fish
cp ./.config/powershell/* ~/.config/powershell
cp ./.bash_profile ~/.bash_profile
cp ./.bashrc ~/.bashrc
cp ./.zshrc ~/.zshrc
source ~/.bash_profile

xcode-select --install
gem install bundler
gem install jekyll
