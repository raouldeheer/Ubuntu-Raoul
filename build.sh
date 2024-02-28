#!/bin/bash

file() {
    tar rvf ../base.tar $1
}
echo "Starting build"
wget -O base.tar.zst -q http://download.proxmox.com/images/system/ubuntu-22.04-standard_22.04-1_amd64.tar.zst # http://download.proxmox.com/images/system/ubuntu-20.04-standard_20.04-1_amd64.tar.gz

echo "Unzipping gz"
unzstd base.tar.zst

echo "Starting file edit"
cd files

# Get latest ASD
wget -O ./usr/bin/asd -q https://github.com/raouldeheer/ASD/releases/latest/download/asd.sh
chmod +x ./usr/bin/asd
# FILES BEGIN
file ./usr/bin/asd
file ./etc/rc.local
file ./etc/os-release
file ./etc/init.d/startupUbuntuRaoul

# FILES END
echo "Finished file edit"
cd ..
echo "Zipping gz"
zstd base.tar
mv base.tar.zst $1
echo "Done: $1"