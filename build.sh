#!/bin/bash

file() {
    tar rvf ../base.tar $1
}
echo "Starting build"
wget -O base.tar.gz -q http://download.proxmox.com/images/system/ubuntu-20.04-standard_20.04-1_amd64.tar.gz

echo "Unzipping gz"
gunzip base.tar.gz

echo "Starting file edit"
cd files

# Get latest ASD
wget -O ./usr/bin/asd -q https://github.com/raouldeheer/ASD/releases/latest/download/asd.sh
chmod +x ./usr/bin/asd
# FILES BEGIN
file ./usr/bin/asd
file ./etc/rc.local
file ./etc/init.d/startupUbuntuRaoul

# FILES END
echo "Finished file edit"
cd ..
echo "Zipping gz"
gzip base.tar
mv base.tar.gz $1
echo "Done: $1"