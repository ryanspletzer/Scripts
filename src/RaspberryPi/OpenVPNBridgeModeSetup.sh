#!/bin/bash

# https://www.emaculation.com/doku.php/bridged_openvpn_server_setup

sudo su
apt-get install openvpn easy-rsa bridge-utils
cp -r /usr/share/easy-rsa /etc/openvpn
cd /etc/openvpn/easy-rsa
source vars
./clean-all
ln -s openssl-1.0.0.cnf openssl.cnf
./build-ca
# Country Name (2 letter code) [US]:US
# State or Province Name (full name) [CA]:MI
# Locality Name (eg, city) [SanFrancisco]:Canton
# Organization Name (eg, company) [Fort-Funston]:Spletzer
# Organizational Unit Name (eg, section) [MyOrganizationalUnit]:Home
# Common Name (eg, your name or your server's hostname) [Fort-Funston CA]:OpenVPN-CA
# Name [EasyRSA]:
# Email Address [me@myhost.mydomain]:<email>
./build-key-server server
# Country Name (2 letter code) [US]:US
# State or Province Name (full name) [CA]:MI
# Locality Name (eg, city) [SanFrancisco]:Canton
# Organization Name (eg, company) [Fort-Funston]:Spletzer
# Organizational Unit Name (eg, section) [MyOrganizationalUnit]:Home
# Common Name (eg, your name or your server's hostname) [server]:OpenVPN-ICA
# Name [EasyRSA]:
# Email Address [me@myhost.mydomain]:<email>
# Skip challenge password and optional company name / accept defaults
# Hit 'y' twice to sign and commit issuing CA
./build-dh
./build-key <user@computername>
# Country Name (2 letter code) [US]:US
# State or Province Name (full name) [CA]:MI
# Locality Name (eg, city) [SanFrancisco]:Canton
# Organization Name (eg, company) [Fort-Funston]:Spletzer
# Organizational Unit Name (eg, section) [MyOrganizationalUnit]:Home
# Common Name (eg, your name or your server's hostname) [<user@computername>]:
# Name [EasyRSA]:
# Email Address [me@myhost.mydomain]:<email>
# Skip challenge password and optional company name / accept defaults
# Hit 'y' twice to sign and commit issuing CA
openvpn --genkey --secret /etc/openvpn/easy-rsa/keys/ta.key
# Copy text client key(s) in /etc/openvpn/easy-rsa/keys to somewhere safe like LastPass
nano /etc/openvpn/openvpn-bridge
# Adjust IP settings in file, eth var to match interface name
# To get list of ethernet interface names: ip a
chmod 744 /etc/openvpn/openvpn-bridge
nano /etc/openvpn/server.conf
# Adjust IP settings in file
nano /lib/systemd/system/openvpn@.service
# https://openvpn.net/community-resources/ethernet-bridging/
iptables -A INPUT -i tap0 -j ACCEPT
iptables -A INPUT -i br0 -j ACCEPT
# https://wiki.debian.org/iptables
iptables-save > /etc/iptables.up.rules
touch /etc/network/if-pre-up.d/iptables
echo '#!/bin/sh' >> /etc/network/if-pre-up.d/iptables
echo '/sbin/iptables-restore < /etc/iptables.up.rules' >> /etc/network/if-pre-up.d/iptables
chmod +x /etc/network/if-pre-up.d/iptables
reboot
# create specific client.conf for each client, distribute ca.crt, ta.key, client.crt, client.key, client.conf
