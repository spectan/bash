#!/bin/sh

#check args
if [ $# -lt 2 ]; then
	echo "Usage: $0 vm_name media"
	exit 1
else
	VM_NAME="$1"
	MEDIA="$2"
fi

#check if vm.conf exists in directory
if [ -f "$HOME/bin/vm.conf" ]; then
	. "/$HOME/bin/vm.conf"
else
	echo "Error: Cannot find the configuration file ($HOME/bin/vm.conf)"
	exit 2
fi
vboxmanage storageattach "$VM_NAME" --storagectl "$IDE_CONTROLLER" --port 1 --device 0 --type dvddrive --medium "$MEDIA"
