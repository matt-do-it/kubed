#!/bin/sh
set -e

growfs_enable="YES"

#pkg install -y net/cloud-init
#sysrc cloudinit_enable=YES

#pkg install -y java/openjdk17

pkg install curl
pkg install fusefs-sshfs
pkg install debootstrap

mkdir /root/.ssh

## add to sysrc kld_list="fusefs"

## Enable linux subsystem
sysrc linux_enable="YES"

