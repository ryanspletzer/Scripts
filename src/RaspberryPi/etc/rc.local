# Add this in to deal with a bug in iptables not loading properly
sudo su
iptables -L >/dev/null
systemctl stop openvpn
systemctl start openvpn
