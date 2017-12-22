# Building the OpenAirInterface KVM image

You will need access to a linux box (I use an ubuntu VirtualBox on my mac).

### Download and install diskimage-builder

    cd /tmp
    wget https://bootstrap.pypa.io/get-pip.py
    sudo python get-pip.py

    sudo pip install --upgrade pip dib-utils networkx

    sudo apt install -y curl kpartx python-yaml qemu-utils kpartx
    cd ~/
    git clone http://git.openstack.org/openstack/diskimage-builder.git


Upgrade setuptools to the latest version: (from setuptools-18.3.3 to setuptools-36.2.2 for example – python ./setup.py install may fail with the older version of setuptools)

    sudo pip install -U pip setuptools

    cd diskimage-builder
    sudo python ./setup.py install
    sudo pip install -r requirements.txt

### Download diskimage-builder files for OpenAirInterface

    cd ~/
    git clone 
    https://github.com/RuthDevlaeminck/OAI_VNF.git


### Tell the diskimage-builder where your elements are

    export ELEMENTS_PATH=~/OAI_VNF/images/oai_kvm_files/dib_elements


### Build the image

    disk-image-create -o OpenAirInterfaceEPC -t qcow2 -a amd64 -x ubuntu vm OpenAirInterfaceEPC

### Upload the image to openstack (use cli)

    glance image-create --name oai-image-kvm --visibility private --container-format bare --disk-format qcow2 --file OpenAirInterfaceEPC.qcow2 --progress

