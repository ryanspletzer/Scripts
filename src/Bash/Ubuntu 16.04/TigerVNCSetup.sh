#!/bin/sh

# https://www.hiroom2.com/2016/08/28/ubuntu-16-04-remote-connect-to-unity-with-vnc-xrdp/

# Refresh Repository.
sudo apt update -y

# Install git and devscripts.
sudo apt install -y git devscripts

# Remove vnc4server.
sudo apt remove -y vnc4server

# Create working directory.
mkdir tigervnc
cd tigervnc

# Download source code.
git clone https://github.com/TigerVNC/tigervnc
cd tigervnc/

# Avoid compiler error.
# May not be necessary -- no compile error on master on 2/18/2017
# git checkout ff872614b507d0aa8bfbd09ef41550390cfe658a

# Prepare to build package.
ln -s contrib/packages/deb/ubuntu-xenial/debian
chmod a+x debian/rules
sudo apt install -y -o 'apt::install-recommends=true' \
    `dpkg-checkbuilddeps 2>&1 | \
sed -e 's/.*build dependencies://g' -e 's/([^)*])//g'`

# Build package.
fakeroot debian/rules binary
cd ..

# Install package with resolving dependent package.
sudo dpkg -i *.deb || (sudo apt-get -f install -y ; sudo dpkg -i *.deb || exit 1)
cd ..

sudo ln -s /usr/bin/unity-control-center /usr/bin/gnome-control-center

vncpasswd

vncserver

# Worked on 2/18/2017 -- need to set to start on startup
