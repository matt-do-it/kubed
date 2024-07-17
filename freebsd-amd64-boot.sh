#!/bin/zsh

socket_vmnet_client /var/run/socket_vmnet \
qemu-system-x86_64 \
  -boot strict=off \
  -accel tcg \
  -smp 4 \
  -m 4096 \
  -drive file=Firmware/code-amd64.img,format=raw,if=pflash,readonly=on \
  -drive file=Packer/image_freebsd_amd64/efivars.fd,format=raw,if=pflash \
  -device virtio-gpu-pci \
  -display default,show-cursor=on \
  -device qemu-xhci \
  -device usb-kbd \
  -device usb-tablet \
  -device intel-hda \
  -device hda-duplex \
  -drive id=main,if=none,file=Packer/image_freebsd_amd64/freebsd.img,format=raw,cache=writethrough \
  -device virtio-blk-pci,drive=main \
  -device virtio-net-pci,netdev=net0 -netdev socket,id=net0,fd=3 \
  -nographic
