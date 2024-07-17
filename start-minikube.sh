
minikube start --v 8 --driver=qemu \
	--qemu-firmware-path=/Users/herold/Virtual\ Machines/Firmware/code-aarch64.img \
	--socket-vmnet-client-path=/opt/local/bin/socket_vmnet_client \
	--socket-vmnet-path=/var/run/socket_vmnet \
	--network socket_vmnet