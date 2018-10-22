#!/bin/bash

defaults write com.apple.Finder AppleShowAllFiles true
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

brew cask install google-chrome
brew cask install firefox
brew install git
brew cask install java
brew install git-credential-manager
brew install bash-git-prompt
brew cask install powershell
brew cask install homebrew/cask-versions/powershell-preview
brew cask install slack
brew cask install visual-studio-code
brew cask install visual-studio
brew cask install postman
brew cask install citrix-workspace
brew cask install zoomus
brew cask install zoom-outlook-plugin
brew cask install microsoft-azure-storage-explorer
brew install gnupg
brew cask install keybase
