#!/bin/sh

if [ $# -lt 1 ]; then
	echo "Usage: $1 vm_name"
	exit 1
else
	VM_NAME="$1"
fi
vboxmanage unregistervm "$VM_NAME" --delete
