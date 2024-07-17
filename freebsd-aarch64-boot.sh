#!/bin/zsh

socket_vmnet_client /var/run/socket_vmnet \
qemu-system-aarch64 \
  -M virt \
  -accel hvf \
  -cpu host \
  -smp 4 \
  -m 4096 \
  -drive file=Firmware/code-aarch64.img,format=raw,if=pflash,readonly=on \
  -drive file=Firmware/vars-aarch64.img,format=raw,if=pflash \
  -device virtio-net-pci,netdev=net0 -netdev socket,id=net0,fd=3 \
  -display default,show-cursor=on \
  -device virtio-gpu-pci \
  -device qemu-xhci \
  -device usb-kbd \
  -device usb-tablet \
  -device intel-hda \
  -device hda-duplex \
  -nographic \
  -drive file=Packer/image_freebsd_aarch64/freebsd.img,format=raw,if=virtio,cache=writethrough
