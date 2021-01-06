#!/bin/bash

echo -e "Hello."
read -p "Is it the first time for setting up RP-unit? If not, you can skip the several steps fpr initial settings, such as WLAN configuration. (y/N): " yn
	case $yn in
		[yY]*)
		cat << EOF >> /etc/dhcpcd.conf
interface wlan0
static ip_address=MACHINEIP/24
static routers=ROUTERIP
static domain_name_servers=ROUTERIP
EOF
		echo "Edited /etc/dhcpcd.conf"

		cat << EOF > /home/pi/Desktop/MachineID
MACHINEID
EOF
		echo "Created /home/pi/Desktop/MachineID"
		echo "Answer the several questions for initial settings below."

		echo -e "Fill in router's IP-address.   e.g. 123.456.7.1"
		read routerip

		echo -e "Fill in NAS's user-name.   e.g. admin"
		read nasun

		echo -e "Fill in NAS's password.   e.g. password"
		read naspw

		echo -e "Fill in NAS's IP-address.   e.g. 123.456.7.8"
		read nasip

		echo -e "Fill in the name of NAS's directory that you want to store the data. For example, if you want to store the data to a directory 'homes' in NAS, fill in 'homes'."
		read nasdir


		echo "Fill in MacineID of this RP-unit.   e.g. 1"
		read machineid
		sed -i -e "s/MACHINEID/$machineid/g" /home/pi/Desktop/MachineID
		echo "Edited MachineID"

		echo "Fill in IP-address of this RP-unit.   e.g. 123.456.7.10"
		read machineip
		sed -i -e "s/MACHINEIP/$machineip/g" /etc/dhcpcd.conf
		echo "Edited IP-address of this machine and dhcpcd.conf"

		chmod 777 /home/pi/Desktop/Record.sh

		sed -i -e "s/ROUTERIP/$routerip/g" /etc/dhcpcd.conf
		sed -i -e "s/NASUN/$nasun/g" /home/pi/Desktop/Record.sh
		sed -i -e "s/NASPW/$naspw/g" /home/pi/Desktop/Record.sh
		sed -i -e "s/NASIP/$nasip/g" /home/pi/Desktop/Record.sh
		sed -i -e "s/NASDIR/$nasdir/g" /home/pi/Desktop/Record.sh
		sed -i -e "s/MACHINEID/$machineid/g" /home/pi/Desktop/MachineID
		sed -i -e "s/MACHINEIP/$machineip/g" /etc/dhcpcd.conf

		mkdir /mnt/NAS
		chmod 777 /mnt/NAS

		mount -t /cifs //$nasip/$nasdir /mnt/NAS -o username=$nasun,password=$naspw,file_mode=0777,dir_mode=0777,iocharset=utf8,rw,uid=1000,gid=1000
		cat << EOF >> /etc/fstab
//$nasip/$nasdir /mnt/NAS cifs username=$nasun,password=$naspw,file_mode=0777,dir_mode=0777,iocharset=utf8,rw,uid=1000,gid=1000,defaults 0 0
EOF
		echo "Mounted NAS"

		echo "Created RP-unit." ;;

		*)
		echo "Skipped several steps for initial settings."
		echo "Fill in MacineID of this RP-unit."
		read machineid
		rm /home/pi/Desktop/MachineID
		cat << EOF >> /home/pi/Desktop/MachineID
$machineid
EOF

		echo "Fill in IP-address of this RP-unit."
		read machineip
		Num1=$(grep -n "^interface wlan0" /etc/dhcpcd.conf|sed -e 's/:.*//g')
		sed -i -e "${Num1}d" /etc/dhcpcd.conf
		Num2=$(grep -n "^static ip_address=" /etc/dhcpcd.conf|sed -e 's/:.*//g')
        	sed -i -e "${Num2}d" /etc/dhcpcd.conf
		Num3=$(grep -n "^static routers" /etc/dhcpcd.conf|sed -e 's/:.*//g')
        	sed -i -e "${Num3}d" /etc/dhcpcd.conf
		Num4=$(grep -n "^static domain_name_servers=" /etc/dhcpcd.conf|sed -e 's/:.*//g')
        	sed -i -e "${Num4}d" /etc/dhcpcd.conf

		cat << EOF >> /etc/dhcpcd.conf
interface wlan0
static ip_address=$machineip/24
static routers=ROUTERIP
static domain_name_servers=ROUTERIP
EOF

		echo "Edited IP-address of this machine and dhcpcd.conf"
	esac

echo "Setup is now completed."
