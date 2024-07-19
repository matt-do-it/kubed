#!/bin/zsh

socket_vmnet_client /var/run/socket_vmnet \
qemu-system-x86_64 \
  -boot strict=off \
  -machine q35 \
  -cpu max \
  -accel tcg \
  -smp 4 \
  -m 4096 \
  -drive file=Firmware/code-ubuntu-amd64.img,format=raw,if=pflash,readonly=on \
  -drive file=Packer/image_ubuntu_amd64/efivars.fd,format=raw,if=pflash \
  -device virtio-gpu-pci \
  -display default,show-cursor=on \
  -device qemu-xhci \
  -device usb-kbd \
  -device usb-tablet \
  -device intel-hda \
  -device hda-duplex \
  -drive id=main,if=none,file=Packer/image_ubuntu_amd64/ubuntu.img,format=raw,cache=writethrough \
  -device virtio-blk-pci,drive=main \
  -device virtio-net-pci,mac=52:54:00:12:34:56,netdev=user.0 \
  -netdev socket,id=user.0,fd=3 \
  -nographic
