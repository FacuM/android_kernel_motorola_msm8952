#!/bin/bash
# set -e
if [ -z "$1" ]
then
 printf "\nNo device picked, please type device name as an argument.\n\n  i.e.: bash build_cwm_zip.sh harpia\n"
 exit 1
else
 DEVCDN="$1"
 ZIPPATH='cwm_flash_zip'
 rm -f arch/arm/boot/dts/*.dtb
 rm -f "$ZIPPATH/boot.img"
 make ARCH=arm -j10 zImage
 rm -rf squid_install
 mkdir -p squid_install
 cp arch/arm/boot/zImage "$ZIPPATH/tools/"
 VERSION=$(cat Makefile | grep "EXTRAVERSION = -" | sed 's/EXTRAVERSION = -//')
 rm -f "arch/arm/boot/SomeAthK$VERSION-$DEVCDN.zip"
 cd "$ZIPPATH"
 zip -r "../arch/arm/boot/SomeAthK$VERSION-$DEVCDN.zip" ./
 exit 0
fi
