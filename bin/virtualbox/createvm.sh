#!/bin/sh
#check for args
if [ $# -lt 1 ]; then
	echo "Usage: $0 vm_name vrde_port"
	exit 1
fi

#set required variables from user input
VM_NAME="$1"
VRDE_PORT="$2"

#check if configuration file does exist
#if it does exist, read the file and set related variables
echo "Reading vm.conf"
if [ -f "$HOME/bin/vm.conf" ]; then
	. "$HOME/bin/vm.conf"
	echo $IDE_CONTROLLER
	echo $SATA_CONTROLLER
	echo $HDD_SIZE
	echo $MEM_SIZE
	echo $NIC_NAME
	HDD_NAME="$VM_NAME.vdi"
	echo $HDD_NAME
else
	echo "Error: $HOME/bin/vm.conf does not exist."
	exit 2
fi

#create a vm and register the vm
echo "Creating the VM"
vboxmanage createvm --name "$VM_NAME" --register
RESULT="$?"
if [ $RESULT -ne 0 ]; then
	echo "Error: Cannot create $VM_NAME -Code ($RESULT)"
	exit 3
fi

# create IDE controller for the VM
echo "Creating the IDE controller"
vboxmanage storagectl "$VM_NAME"  --name "$IDE_CONTROLLER" --add ide
RESULT="$?"
if [ $RESULT -ne 0 ]; then
	echo "Error: Cannot create IDE controller $IDE_CONTROLLER -Code: ($RESULT)"
	exit 4
fi

#create serial ATA controller for the VM
echo "Creating the serial ATA controller"
vboxmanage storagectl "$VM_NAME" --name "$SATA_CONTROLLER" --add SATA --controller intelahci
RESULT="$?"
if [ $RESULT -ne 0 ]; then
	echo "Error: Cannot create SATA controller $SATA_CONTROLLER -Code: ($RESULT)"
	exit 5
fi

#create an HDD for the VM
echo "Creating the HDD"
vboxmanage createhd --filename "$HOME/VirtualBox VMs/$VM_NAME/$HDD_NAME" --size "$HDD_SIZE"
RESULT="$?"
if [ $RESULT -ne 0 ]; then
	echo "Error: Cannot create HDD $HDD_NAME -Code ($RESULT)"
	exit 6
fi

#attach the HDD to the VM
echo "Attaching the HDD to the VM"
vboxmanage storageattach "$VM_NAME" --storagectl "$SATA_CONTROLLER" --port 0 --device 0 --type hdd --medium "$HOME/VirtualBox VMs/$VM_NAME/$HDD_NAME"
if [ $RESULT -ne 0 ]; then
	echo "Error: Cannot attach the HDD $HDD_NAME - Code ($RESULT)"
	exit 7
fi

#modify the VM with the given default configuration info
echo "Applying default configuration info"
vboxmanage modifyvm "$VM_NAME" --memory "$MEM_SIZE" --chipset ich9 --acpi on --boot1 dvd --nic1 bridged --bridgeadapter1 "$NIC_NAME" --vrdeport "$VRDE_PORT" --vrde on
RESULT="$?"
if [ $RESULT -ne 0 ]; then
	echo "Error: Cannotm modify the VM's configuration - Code ($RESULT)"
	exit 8
fi

echo "Done!"
