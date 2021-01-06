#!/usr/bin/env python

import time
import datetime
import picamera
import RPi.GPIO as GPIO
#define recording period as sec.

#Recording duration = befAc (sec) + aftAc (sec)
befAc = 10
#GPIO interfacing is performed between befAc and aftAc
aftAc = 10

#number of turning of electricity in one trial (sec)
numTurning=10
#interval of turning of electricity (sec)
interval=10

#Video-recording
file = open("/home/pi/Desktop/MachineID", "r")
try:MachineID = file.read()
finally:
    file.close()
    print('MachineID: ' + MachineID)

with picamera.PiCamera() as camera:
    camera.resolution = (640, 480)
    camera.framerate = 25
    timestamp = datetime.datetime.today()
    timestamp = timestamp.strftime("%Y%m%d-%H%M%S")
    filename = '/home/pi/Videos/[camera' + str(int(MachineID)) + ']' + str(timestamp) + '.h264'
    camera.start_recording(str(filename))
    print ('Start recording: ' + filename)
    camera.wait_recording(befAc)
    print ('GPIO interfacing...')
    GPIO.setmode(GPIO.BCM)
    GPIO.setup(22, GPIO.OUT)
    GPIO.setup(23, GPIO.OUT)
    sets=0
    num=0
    while sets < numTurning:
        while num < numTurning:
		GPIO.output(23, 1) #GPIO.pin-23 is connected to the circuit including the battery.
        	time.sleep(0.5)
		GPIO.output(23, 0)
		time.sleep(0.5)
		num += 1
	GPIO.output(22, 0)
	time.sleep(interval)
	num=0
	sets += 1
	GPIO.output(22, 0)
 	GPIO.cleanup()
    camera.wait_recording(aftAc)
    camera.stop_recording()
    print ('Finished recording.')
