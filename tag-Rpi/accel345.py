import time
import RPi.GPIO as GPIO
import board
import busio
import adafruit_adxl34x

i2c = busio.I2C(board.SCL, board.SDA)
accelerometer = adafruit_adxl34x.ADXL345(i2c)

def measure_speed():
    try:
        x,y,z = accelerometer.acceleration
        print("x-accel",x)
        print("y-accel",y)
        print("z-accel",z)
        time.sleep(1)
    finally:
        GPIO.cleanup()
        
measure_speed()