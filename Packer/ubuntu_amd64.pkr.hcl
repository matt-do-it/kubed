packer {
  required_plugins {
    qemu = {
      version = "~> 1"
      source  = "github.com/hashicorp/qemu"
    }
  }
}

source "qemu" "ubuntu" {
  iso_url           = "https://cloud-images.ubuntu.com/releases/24.04/release/ubuntu-24.04-server-cloudimg-amd64.img"
  iso_checksum 		= "sha256:5d482ff93a2ba3cf7e609551733ca238ed81a6afdaafcdce53140546b09a6195"
  disk_image 		= true
  efi_firmware_code = "../Firmware/code-ubuntu-amd64.img"
  efi_firmware_vars = "../Firmware/vars-ubuntu-amd64.img"
  output_directory  = "image_ubuntu_amd64"
  qemu_binary       = "qemu-system-x86_64"
  disk_size         = "10G"
  format            = "raw"
  display 			= "cocoa"
  ssh_username      = "dev"
  ssh_password      = "dev"
  ssh_timeout       = "20m"
  vm_name           = "ubuntu.img"
  net_device        = "virtio-net-pci"
  disk_interface    = "virtio"
  boot_wait         = "5s"
  http_directory    = "http_ubuntu"
  shutdown_command  = "sudo shutdown -P now"
  
  qemuargs=[           
      ["-boot", "strict=off"],
      ["-device", "qemu-xhci"],
      ["-device", "usb-kbd"],
      ["-device", "usb-tablet"],
      ["-device", "intel-hda"],
      ["-device", "hda-duplex"],
      ["-cdrom", "./cloudinit_ubuntu.img"]
  ]
 
  boot_command = [
  ]
}

build {
  name    = "build-ubuntu"
  sources = [
    "source.qemu.ubuntu"
  ]
  provisioner "shell" {
    execute_command = "chmod +x {{ .Path }}; env {{ .Vars }} sudo {{ .Path }}"
    scripts         = [
    	"shell/ubuntu-install.sh", 
    ]
  }

}