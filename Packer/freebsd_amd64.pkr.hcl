packer {
  required_plugins {
    qemu = {
      version = "~> 1"
      source  = "github.com/hashicorp/qemu"
    }
  }
}

source "qemu" "freebsd" {
  iso_url           = "file:///Users/herold/Virtual%20Machines/Cloud-Images/FreeBSD-14.1-RELEASE-amd64-zfs.img"
  iso_checksum 		= "sha256:8322798d11a794f8bb99ce2e620af7a315fb085993ad7184b989bac723b13ef7"
  disk_image 		= true
  efi_firmware_code = "/Users/herold/Virtual Machines/Firmware/code-amd64.img"
  efi_firmware_vars = "/Users/herold/Virtual Machines/Firmware/vars-amd64.img"
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