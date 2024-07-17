packer {
  required_plugins {
    qemu = {
      version = "~> 1"
      source  = "github.com/hashicorp/qemu"
    }
  }
}

source "qemu" "freebsd" {
  iso_url           = "http://ftp.freebsd.org/pub/FreeBSD/releases/VM-IMAGES/14.1-RELEASE/amd64/Latest/FreeBSD-14.1-RELEASE-amd64-zfs.raw.xz"
  iso_checksum 		= "sha256:e2c4c42a4abbd10c970d516598ede01a0bbdbb0612c41631a8ec2bf5521e7ab0"
  disk_image 		= true
  efi_firmware_code = "/Users/herold/Virtual Machines/Firmware/code-freebsd-amd64.img"
  efi_firmware_vars = "/Users/herold/Virtual Machines/Firmware/vars-freebsd-amd64.img"
  output_directory  = "image_freebsd_amd64"
  qemu_binary       = "qemu-system-x86_64"
  disk_size         = "10G"
  format            = "raw"
  display 			= "cocoa"
  ssh_username      = "root"
  ssh_password      = "packer"
  ssh_timeout       = "20m"
  vm_name           = "freebsd.img"
  net_device        = "virtio-net-pci"
  disk_interface    = "virtio"
  boot_wait         = "5s"
  http_directory    = "http_freebsd"
  shutdown_command  = "poweroff"
  
  qemuargs=[           
      ["-boot", "strict=off"],
      ["-device", "qemu-xhci"],
      ["-device", "usb-kbd"],
      ["-device", "usb-tablet"],
      ["-device", "intel-hda"],
      ["-device", "hda-duplex"]
  ]
 
  boot_command = [
  	"<esc><wait>", 
  	"boot<enter>", 
  	"<wait30s>", 
  	"root<enter>",
  	"service sshd enable<enter>",
  	"passwd<enter>",
  	"packer<enter>",
  	"packer<enter>",
  	"sed -i '' -e 's/^#PermitRootLogin no/PermitRootLogin yes/' /etc/ssh/sshd_config<enter>",
  	"service sshd start<enter>"
  ]
}

build {
  name    = "build-freebsd"
  sources = [
    "source.qemu.freebsd"
  ]
  provisioner "shell" {
    execute_command = "chmod +x {{ .Path }}; env {{ .Vars }} {{ .Path }}"
    scripts         = [
    	"shell/freebsd-update.sh",
    	"shell/freebsd-install.sh", 
    	"shell/freebsd-cleanup.sh"
    ]
  }

}