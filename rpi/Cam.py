from picamera import PiCamera
from time import sleep

camera = PiCamera()

def take_pic():
    camera.start_preview()
    for i in range(3):
        sleep(2)
        camera.capture('/home/pi/Desktop/image%s.jpg' % i)
        print("done")
    camera.stop_preview()

take_pic()

