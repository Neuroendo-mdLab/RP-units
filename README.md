# RP-units

## Description
 RP-unit is an automated animal behavior recording system using Raspberry Pi, which enables you automatically perform video-recording of animal behavior. It also frees you from laborious procedures such as file-naming, encoding and transferring the files to a storage. Thus, by using multiple RP-units, behavioral recordings will be performed more efficiently and accurately, without unintentional human errors caused by experimental operations. All Raspberry pis and a computer for operation are supposed to be connected in a closed network via WLAN rooter.
 
## Requirement
 This system required the hardware listed below:
   -	Raspberry Pi
   -	microSD card
   -	Raspberry Pi Camera Module V2
   -	Wireless rooter
   -	NAS (If you use multiple RP-units, we recommend you to prepare it.)
 
 Connection diagram of these hardware is represented in a paper that is is under consideration in a journal.
 
## Usage
### Initial setting of the RP-unit
1.	Built the WLAN and connect the NAS. In the present study, we connected the NAS to WLAN through the Ethernet cable.

2.	Install the Raspberry Pi OS (called ‘Raspbian’ before) to the microSD card. We had confirmed that the present system works on Raspbian ver.3.1.1 or later. For this step, it is easy to use ‘Raspberry Pi Imager (https://www.raspberrypi.org/software/)’, which is an application for installation of Raspberry Pi OS.

3.	Insert the microSD card and connect the Raspberry Pi Camera Module V2 to the Raspberry Pi.

4.	Connect the display, keyboard and mouse to the Raspberry Pi. 

5.	Boot the Raspberry Pi and make initial setting (When firstly booting Raspberry Pi, the initial setting will be automatically started). Connect the Raspberry Pi to the WLAN in the step for network configuration.

6.	Make the Camera Module available. To open the configuration tool, run the following from the command line: `sudo raspi-config`<br>
   Select ‘enabled’ in the menu of ‘Interface Options > Camera’ and once reboot the Raspberry Pi.<br>
   After rebooting, it recommends you checking whether the camera module is successfully recognized to Raspberry Pi by using the command line: `vcgencmd get_camera` <br>
   If the message `supported=1 detected=1` , the camera module is successfully recognized.

7.	Place the files *Setup.sh*/*Record.sh*/*Camera.py*/*MachineID* to the desktop of Raspberry Pi (/home/pi/Desktop).

8.	Modify the file permission of *Setup.sh* to make users read, write, execute and delete by using the command line:<br> `sudo chmod 777 /home/pi/Desktop/Setup.sh` <br>
   
9.	Run the *Setup.sh*. A question of whether it is the first time to setup the RP-unit appears in terminal window, so fill in “y”.

10.	Configure some items listed below:
    - Router's IP-address
    - NAS's username
    - NAS's password
    - NAS's IP-address
    - NAS's directory that you want to store the data
    - RP-unit's MachineID
    - RP-unit's IP-address
    <br>
    After answering, setup of RP-units will be finished. It becomes possible to access and operate the RP-units though the SSH remote login.

### Cloning of RP-units
1.	Save the entire data of initial RP-units as a disk image (.iso).

2.	Copy the disk image to a new microSD card.

3.	Insert the microSD and connect the Raspberry Pi Camera Module V2 to the Raspberry Pi.

4.	Connect the display, keyboard and mouse to the Raspberry Pi. 

5.	Boot the Raspberry Pi.

6.	Run the *Setup.sh*. A question of whether it is the first time to setup the RP-unit appears in terminal window, so fill in “y”.

7.	Configure some items listed below:
    - RP-unit's MachineID
    - RP-unit's IP-address 
    <br>
   After answering, cloning of RP-units will be finished. It becomes possible to access and operate the RP-units though the SSH remote login.

### Video-recording
1.	Access to the multiple RP-units through SSH remote login. By doing this, it becomes possible to simultaneously execute subsequent operations in multiple RP-units.

2.	Configure the duration of video-recording by editing the line 10 of *Camera.py*. Recording duration is defined in seconds. It is defined as 10 seconds by default setting.

3.	Run *Record.sh*. Video-recording, file-naming, encoding and transferring video file will be automatically performed. By default setting, video files are temporary saved to the directory of each RP-unit (/home/pi/Videos), and transfer to the NAS’s directory. NAS’s directory that are set when running Setup.sh is mounted to the directory /mnt/NAS (Here is the mount-point). Video files that recorded by each RP-unit and named “~converted.mp4” will be sorted in the NAS.


## Note
 We also uploaded two python scripts *Feed.py* and *Voltage.py*, which is run for operating the external devices (LED lamp and auto-feeding device) or switching on/off of the power of the circuit using 9V alkaline battery, respectively.

## Author
 - Soma Tomihara (The University of Tokyo)
 - Shinji Kanda (The University of Tokyo)
