#!/bin/zsh

rm Firmware/code-amd64.img

dd if=edk2-stable202402-r1-bin/x64/code.fd of=Firmware/code-amd64.img conv=notrunc
dd if=edk2-stable202402-r1-bin/x64/vars.fd of=Firmware/vars-amd64.img conv=notrunc
