# bin/virtualbox
Assorted scripts for the administration of virtualbox virtual machines.

- **chostype.sh**: Changes the OStype for the virtual machine
- **createvm.sh**: Creates a VM using vm_name and vrde_port args while reading the rest from vm.conf.
- **lsrvms.sh**: Shortcut to list running VMs.
- **lsvms.sh**: Shortcut to list all VMs.
- **mountmedia.sh**: Takes a vm_name and media (in .iso) argument and attempts to mount it to the provided VM name.
- **pbutton.sh**: Powers off a machine through the powerbutton method.
- **poff.sh**: Forcefully powers off a machine.
- **rmvm.sh**: Takes a vm_name arg and attempts to remove said VM.
- **shvm.sh**: Takes a vm_name arg and shows VM details using less.
- **startvm.sh**: Takes a vm_name arg and starts the VM.
- **vm.conf**: Assorted configuration data for createvm.sh and mountmedia.sh
- **vrdeoff.sh**: Takes a vm_name arg and attempts to disable VRDE.
- **vrdeon.sh**: Takes a vm_name arg and attempts to enable VRDE.
