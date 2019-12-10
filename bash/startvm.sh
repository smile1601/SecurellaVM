#! /bin/bash
VM_1_NAME=vm_1
VM_HOME=/home/$USER/vm
VM_IMAGE=/vm_image
R_DELAY=1

if [ ! -e $VM_HOME/$VM_1_NAME ]
then
	mkdir -p $VM_HOME/$VM_1_NAME
	VBoxManage setproperty machinefolder $VM_HOME/$VM_1_NAME
	VBoxManage import $VM_IMAGE/$VM_1_NAME.ovf
fi

VBoxManage startvm $VM_1_NAME

if [ -e $VM_HOME/$VM_1_NAME ]
then
	while true
	do
		vb_status=$(pgrep -c VirtualBox)
		if [ $vb_status -ne 1 ]
		then
			#reboot
			poweroff
		fi
		sleep $R_DELAY
	done
fi
