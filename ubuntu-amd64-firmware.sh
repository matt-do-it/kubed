#!/bin/zsh

mkdir Firmware

rm Firmware/code-ubuntu-amd64.img

dd if=Firmware/edk2-stable202402-r1-bin/x64/code.fd of=Firmware/code-ubuntu-amd64.img conv=notrunc
dd if=Firmware/edk2-stable202402-r1-bin/x64/vars.fd of=Firmware/vars-ubuntu-amd64.img conv=notrunc
