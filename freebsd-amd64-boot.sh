#!/bin/zsh

socket_vmnet_client /var/run/socket_vmnet \
qemu-system-x86_64 \
  -boot strict=off \
  -machine q35 \
  -cpu max \
  -accel tcg \
  -smp 4 \
  -m 4096 \
  -drive file=Firmware/code-freebsd-amd64.img,format=raw,if=pflash,readonly=on \
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
  -device virtio-net-pci,mac=52:54:00:12:34:53,netdev=net0 -netdev socket,id=net0,fd=3 \
  -device virtio-9p-pci,id=fs0,fsdev=fsdev0,mount_tag=hostshare \
  -fsdev local,security_model=mapped,id=fsdev0,path=Shared/ \
  -nographic
