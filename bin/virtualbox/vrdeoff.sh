#!/bin/sh

if [ $# -lt 1 ]; then
	echo "Usage: $0 vm_name"
else
	VM_NAME="$1"
	vboxmanage controlvm "$VM_NAME" vrde off
fi
