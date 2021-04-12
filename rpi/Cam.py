from picamera import PiCamera
from time import sleep

camera = PiCamera()

def take_pic():
    camera.start_preview()
    camera.capture('/home/pi/Desktop/image0.jpg')
    print("done")
    camera.stop_preview()

take_pic()

