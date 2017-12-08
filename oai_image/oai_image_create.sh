#!/bin/bash

preq_script="prereq.sh"
helper_script="build_helper2"

THIS_SCRIPT_PATH=$(dirname $(readlink -f $0))

if [ ! -f "$preq_script" ];then
        echo "Missing $preq_script in this folder"
fi

if [ ! -f "$helper_script" ];then
        echo "Missing $helper_script in this folder"
fi

echo "Installing specific linux kernels (v4.8/linux-headers-4.8.0-040800)"
cd /tmp
mkdir kernel
cd kernel
wget http://kernel.ubuntu.com/~kernel-ppa/mainline/v4.8/linux-headers-4.8.0-040800_4.8.0-040800.201610022031_all.deb
wget http://kernel.ubuntu.com/~kernel-ppa/mainline/v4.8/linux-headers-4.8.0-040800-generic_4.8.0-040800.201610022031_amd64.deb
wget http://kernel.ubuntu.com/~kernel-ppa/mainline/v4.8/linux-image-4.8.0-040800-generic_4.8.0-040800.201610022031_amd64.deb
sudo dpkg -i *.deb
echo "gtp" >> /etc/modules-load.d/modules.conf


"Cloning git repository into /root/openair-cn"
cd /root/
#git clone https://gitlab.eurecom.fr/oai/openair-cn
git clone https://github.com/RuthDevlaeminck/openair-cn.git

# copy prereq script into correct openair folder
cp $THIS_SCRIPT_PATH/$preq_script /root/openair-cn/SCRIPTS/

# copy buildhelper script into correct openair folder
cp $THIS_SCRIPT_PATH/$helper_script /root/openair-cn/BUILD/TOOLS/

# we added a prereq script that I am including in the email
cd /root/openair-cn/SCRIPTS

apt-get update
apt-get install mysql-workbench -y

# added mysql parameters
./prereq.sh root root
./build_hss
./build_mme
./build_spgw