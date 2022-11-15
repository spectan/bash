#!/bin/sh
if [ $# -lt 2 ]; then
	echo "Usage: $0 vm_name os_type"
	exit 1
else
	VM_NAME="$1"
	OS_TYPE="$2"
fi

vboxmanage modifyvm "$VM_NAME" --ostype "$OS_TYPE"
