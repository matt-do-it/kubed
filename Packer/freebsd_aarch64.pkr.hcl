packer {
  required_plugins {
    qemu = {
      version = "~> 1"
      source  = "github.com/hashicorp/qemu"
    }
  }
}

source "qemu" "freebsd" {
  iso_url           = "file:///Users/herold/Virtual%20Machines/Cloud-Images/FreeBSD-14.1-RELEASE-arm64-aarch64-zfs.img"
  iso_checksum 		= "sha256:c81b98fa4142f4824f223b36c8432514458078ededb7a7fd49b84319702af631"
  disk_image 		= true
  output_directory  = "image_freebsd_aarch64"
  qemu_binary       = "qemu-system-aarch64"
  machine_type		= "virt"
  disk_size         = "10G"
  format            = "raw"
  accelerator       = "hvf"
  display 			= "cocoa"
  ssh_username      = "root"
  ssh_password      = "packer"
  ssh_timeout       = "30m"
  vm_name           = "freebsd.img"
  net_device        = "virtio-net"
  disk_interface    = "virtio"
  boot_wait         = "5s"
  http_directory    = "http_freebsd"
  shutdown_command  = "poweroff"
  
  qemuargs=[           
	  ["-cpu", "host"],
      ["-bios", "/opt/local/share/qemu/edk2-aarch64-code.fd"],    
      ["-boot", "strict=off"],
      ["-device", "qemu-xhci"],
      ["-device", "usb-kbd"],
      ["-device", "usb-tablet"],
      ["-device", "intel-hda"],
      ["-device", "hda-duplex"],
      ["-monitor", "stdio"]
 ]
 
  boot_command = [
  	"<esc><wait>", 
  	"boot<enter>", 
  	"<wait30s>", 
  	"root<enter><wait><enter><enter><wait5>",
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