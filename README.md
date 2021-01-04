# RP-units

## Description
 RP-unit is an automated animal behavior recording system using Raspberry Pi, which enables you remotely perform video-recording of animal behavior. It also frees you from laborious procedures such as file-naming, encoding and transferring the files to a storage.　Thus, by using RP-units, behavioral recordings will be performed more efficiently and accurately, without unintentional human errors caused by experimental operations. 
 
## Requirement
 This system required the hardware listed below:
   -	Raspberry Pi
   -	microSD card
   -	Raspberry Pi Camera Module V2
   -	Wireless rooter
   -	NAS (if you use multiple RP-units, we recommend you prepare it.)
 Connection diagram of these hardware is represented in the paper.
 
 ## Usage
 ### Initial setting of the RP-unit
1.	Built the WLAN and connect the NAS. In the present study, we connected the NAS to WLAN through the Ethernet cable.
2.	Install the Raspberry Pi OS (called ‘Raspbian’ before) to the microSD card. We had confirmed that the present system works on Raspbian ver.3.1.1 or later. For this step, it is easy to use ‘Raspberry Pi Imager (https://www.raspberrypi.org/software/)’, which is an application for installation of Raspberry Pi OS.
3.	Insert the microSD and connect the Raspberry Pi Camera Module V2 to the Raspberry Pi.
4.	Connect the display, keyboard and mouse to the Raspberry Pi. 
5.	Boot the Raspberry Pi and make initial setting (When firstly booting Raspberry Pi, the initial setting will be automatically started). Connect the Raspberry Pi to the WLAN in the step for network configuration.
6.	Make the Camera Module available. To open the configuration tool, run the following from the command line:
```sudo raspi-config
```
