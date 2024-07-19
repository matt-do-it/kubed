packer {
  required_plugins {
    qemu = {
      version = "~> 1"
      source  = "github.com/hashicorp/qemu"
    }
  }
}

source "qemu" "freebsd" {
  iso_url           = "http://ftp.freebsd.org/pub/FreeBSD/releases/VM-IMAGES/14.1-RELEASE/aarch64/Latest/FreeBSD-14.1-RELEASE-arm64-aarch64-zfs.raw.xz"
  iso_checksum 		= "sha256:717049647257c9698e61af7e563f03309eccfc7bb0a6a23edef958a42e69a070"
  disk_image 		= true
  output_directory  = "image_freebsd_aarch64"
  qemu_binary       = "qemu-system-aarch64"
  machine_type		= "virt"
  disk_size         = "20G"
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