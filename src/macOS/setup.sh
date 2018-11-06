#!/bin/bash

mkdir ~/git

defaults write com.apple.Finder AppleShowAllFiles true
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

brew cask install google-chrome
brew cask install firefox
brew install git
brew cask install java
brew install git-credential-manager
brew install bash-git-prompt
brew cask install dotnet-sdk
brew cask install powershell
brew cask install homebrew/cask-versions/powershell-preview
brew cask install slack
brew cask install visual-studio-code
brew cask install visual-studio
brew cask install azure-data-studio
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
brew install fish
brew install ykman
brew install ykpers
brew install yubico-piv-tool
brew cask install yubico-yubikey-manager
brew cask install yubico-yubikey-personalization-github
brew cask install yubico-yubikey-piv-manager
brew cask install microsoft-teams
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
