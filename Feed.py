#!/usr/bin/env python

import time
import datetime
import picamera
import RPi.GPIO as GPIO
#define recording period as sec.

#Recording duration = befAc (sec) + aftAc (sec)
befAc = 10
#GPIO interfacing is performed between befAc and aftAc.
aftAc = 10

#Video-recording
file = open ("/home/pi/Desktop/MachineID", "r")
try: MachineID = file.read()
finally:
        file.close()
        print ('MachineID: ' + MachineID)

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
	GPIO.setup(17, GPIO.OUT) #GPIO.pin-17 is connected to LED lamp
	GPIO.setup(18, GPIO.OUT) #GPIO.pin-18 is connected to auto-feeding device
	GPIO.output(17, 1)
	time.sleep(5)
	GPIO.output(18, 1)
	time.sleep(5)
	GPIO.output(17, 0)
	GPIO.output(18, 0)
	GPIO.cleanup()
	camera.wait_recording(aftAc)
	camera.stop_recording()
print ('Finished running.')

