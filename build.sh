#!/bin/bash

file() {
    tar rvf ../base.tar $1
}
echo "Starting build"
cp $1 base.tar.gz

echo "Unzipping gz"
gunzip base.tar.gz

echo "Starting file edit"
cd files

# Get latest ASD
wget -O ./usr/bin/asd -q --show-progress https://github.com/raouldeheer/ASD/releases/latest/download/asd.sh
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
mv base.tar.gz $2
echo "Done: $2"