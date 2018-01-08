# OAI VNF Packages and Image Generator scripts 

This repo contains:

* VNF Packages
* Scripts for generating the disk image (LXD/KVM)

NFV
----

These are the files to create the VNF Packages.  
To create the tar files:

```
cd nfv
make
```

The tar files can then be uploaded into Open Baton.

NOTE:  The OAI SPGW requires kernel modifications and therefore cannot be run in a container, instead it must be run in a KVM.

Image Generation
----------

### KVM

Use diskimage-builder to create a qcow2 image.  You will need access to a linux box (can be a kvm or virtual box).

##### Download and install diskimage-builder
```
cd /tmp
wget https://bootstrap.pypa.io/get-pip.py
sudo python get-pip.py

sudo pip install --upgrade pip dib-utils networkx

sudo apt install -y curl kpartx python-yaml qemu-utils kpartx
cd ~/
git clone http://git.openstack.org/openstack/diskimage-builder.git
```
Upgrade setuptools to the latest version: (from setuptools-18.3.3 to setuptools-36.2.2 for example – python ./setup.py install may fail with the older version of setuptools)
```
sudo pip install -U pip setuptools

cd diskimage-builder
sudo python ./setup.py install

sudo pip install -r requirements.txt
```

##### Download the diskimage-builder element files for OAI SPGW
```
cd ~/
git clone https://github.com/RuthDevlaeminck/OAI_VNF.git
```

##### Tell the diskimage-builder where the elements are
```
export ELEMENTS_PATH=~/OAI_VNF/images/oai_kvm_files/dib_elements
```

##### Build the image
```
disk-image-create -o OpenAirInterfaceEPC -t qcow2 -a amd64 -x ubuntu vm OpenAirInterfaceEPC
```

##### Upload the image to openstack (use cli)
```
glance image-create --name oai-image-kvm --visibility private --container-format bare --disk-format qcow2 --file OpenAirInterfaceEPC.qcow2 --progress
```


### LXD

Use custom built image generator located at <https://github.com/corenetdynamics/image-generator.git>

##### Create the tar file containing the OAI specific files
```
cd ~/OAI_VNF/images/oai_lxc_files
./compress.sh
```

##### Edit the image.yaml file to point at the generated tar file

