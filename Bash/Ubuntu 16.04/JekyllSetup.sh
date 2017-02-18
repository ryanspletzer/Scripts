#!/bin/sh
sudo -s
apt update
apt upgrade
apt-get install build-essential
apt-get install zlib1g-dev
apt-add-repository ppa:brightbox/ruby-ng
apt update
apt install ruby2.3 ruby2.3-dev ruby-switch
ruby -v
ruby-switch --set ruby2.3
gem install execjs
gem install bundler
gem install jekyll
exit
