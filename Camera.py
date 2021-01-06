#!/usr/bin/env python

import time
import datetime
import picamera
import RPi.GPIO as GPIO
#define recording period as sec.

#Recording duration (sec)
Rec = 10

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
        camera.wait_recording(Rec)
        camera.stop_recording
        print('Finished recording.')
