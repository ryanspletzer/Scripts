#!/bin/sh
# https://technet.microsoft.com/en-us/windows-server-docs/compute/hyper-v/supported-ubuntu-virtual-machines-on-hyper-v
sudo -s
apt-get update
apt-get install linux-virtual-lts-xenial
apt-get install linux-tools-virtual-lts-xenial linux-cloud-tools-virtual-lts-xenial
echo "Please Reboot"
exit

# http://www.serverwatch.com/server-tutorials/installing-and-activating-hyper-v-linux-integration-services.html
sudo vi /etc/initramfs-tools/modules
# Insert this:
# hv_vmbus
# hv_storvsc
# hv_blkvsc
# hv_netvsc
