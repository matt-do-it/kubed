#!/bin/sh
set -e

growfs_enable="YES"

#pkg install -y net/cloud-init
#sysrc cloudinit_enable=YES

#pkg install -y java/openjdk17

## Enable linux subsystem
sysrc linux_enable="YES"

