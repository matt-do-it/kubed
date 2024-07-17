minikube start --driver=qemu \
	--qemu-firmware-path=/opt/local/share/qemu/edk2-aarch64-code.fd \
	--socket-vmnet-client-path=/opt/local/bin/socket_vmnet_client \
	--socket-vmnet-path=/var/run/socket_vmnet \
	--network socket_vmnet