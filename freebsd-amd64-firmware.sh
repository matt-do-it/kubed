#!/bin/zsh

rm Firmware/code-freebsd-amd64.img

dd if=Firmware/edk2-stable202402-r1-bin/x64/code.fd of=Firmware/code-freebsd-amd64.img conv=notrunc
dd if=Firmware/edk2-stable202402-r1-bin/x64/vars.fd of=Firmware/vars-freebsd-amd64.img conv=notrunc
