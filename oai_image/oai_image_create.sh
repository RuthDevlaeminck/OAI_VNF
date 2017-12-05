#!/bin/bash


cd /tmp
mkdir kernel
cd kernel
wget http://kernel.ubuntu.com/~kernel-ppa/mainline/v4.8/linux-headers-4.8.0-040800_4.8.0-040800.201610022031_all.deb
wget http://kernel.ubuntu.com/~kernel-ppa/mainline/v4.8/linux-headers-4.8.0-040800-generic_4.8.0-040800.201610022031_amd64.deb
wget http://kernel.ubuntu.com/~kernel-ppa/mainline/v4.8/linux-image-4.8.0-040800-generic_4.8.0-040800.201610022031_amd64.deb
sudo dpkg -i *.deb
echo "gtp" >> /etc/modules-load.d/modules.conf

cd /root/
git clone https://gitlab.eurecom.fr/oai/openair-cn

cd /root/openair-cn/SCRIPTS
# we added a prereq script that I am including in the email
./prereq.sh
apt install mysql-workbench
./build_hss
./build_mme
./build_spgw

