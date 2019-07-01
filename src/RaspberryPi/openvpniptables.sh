# add this to pi home folder and chmod +x it then from /etc/rc.local / .bashrc:
# sudo su -c /home/pi/openvpniptables.sh root
iptables -L >/dev/null
sleep 5
systemctl stop openvpn
sleep 5
systemctl start openvpn
