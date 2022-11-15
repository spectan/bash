#!/bin/sh

if [ $# -lt 1 ]; then
	echo "Usage: $0 vm_name"
else
	VM_NAME="$1"
	vboxmanage startvm "$VM_NAME" --type headless
fi
