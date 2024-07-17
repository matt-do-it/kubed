#!/bin/sh

mkdir -p Firmware
cd Firmware

curl -OL https://github.com/rust-osdev/ovmf-prebuilt/releases/download/edk2-stable202402-r1/edk2-stable202402-r1-bin.tar.xz

tar xzf edk2-stable202402-r1-bin.tar.xz