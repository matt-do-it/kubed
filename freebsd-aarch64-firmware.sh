#!/bin/zsh

rm Firmware/code-aarch64.img
rm Firmware/vars-aarch64.img

dd if=edk2-stable202402-r1-bin/aarch64/code.fd of=Firmware/code-aarch64.img conv=notrunc
dd if=edk2-stable202402-r1-bin/aarch64/vars.fd of=Firmware/vars-aarch64.img conv=notrunc
