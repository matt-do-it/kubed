#!/bin/sh


/opt/local/bin/mkisofs \
    -output Packer/cloudinit_ubuntu.img \
    -volid cidata -rational-rock -joliet \
    Packer/cloudinit_ubuntu/user-data Packer/cloudinit_ubuntu/meta-data Packer/cloudinit_ubuntu/network-config