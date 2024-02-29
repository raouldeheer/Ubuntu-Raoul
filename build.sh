#!/bin/bash

file() {
    touch $1
    tar uvf ../base.tar $1
}
echo "Starting build"
wget -O base.tar.zst -q http://download.proxmox.com/images/system/ubuntu-22.04-standard_22.04-1_amd64.tar.zst # http://download.proxmox.com/images/system/ubuntu-20.04-standard_20.04-1_amd64.tar.gz

echo "Unzipping gz"
unzstd --rm base.tar.zst

echo "Starting file edit"
cd files

# Get latest ASD
wget -O ./usr/bin/asd -q https://github.com/raouldeheer/ASD/releases/latest/download/asd.sh
chmod +x ./usr/bin/asd
# FILES BEGIN
file ./usr/bin/asd
chmod +x ./etc/rc.local
file ./etc/rc.local
file ./etc/lsb-release
file ./usr/lib/os-release
chmod +x ./etc/init.d/startupUbuntuRaoul
file ./etc/init.d/startupUbuntuRaoul
file ./etc/apt/apt.conf.d/00aptproxy

# FILES END
echo "Finished file edit"
cd ..
echo "Zipping gz"
zstd -f base.tar
mv base.tar.zst $1
echo "Done: $1"