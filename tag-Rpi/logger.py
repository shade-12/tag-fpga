import time
import random
import RPi.GPIO as GPIO
import board
import busio # library to handle i2c serial protocol
import adafruit_adxl34x
#I2C interface
time.sleep(1)

i2c = busio.I2C(board.SCL, board.SDA) # make i2c connection with clock and data signal
accelerometer = adafruit_adxl34x.ADXL345(i2c) # instanciate ADXL object
# 
# def measure_speed():
#     try:
#         x,y,z = accelerometer.acceleration
#         # accelerometer.enable_motion_detection(threshold=18) #scale factor = 62.5 mg
#         print("x-accel",x)
#         print("y-accel",y)
#         print("z-accel",z)
#         return x,y,z
#         time.sleep(2)
#     finally:
#         GPIO.cleanup()

""" while True:
    print(adafruit_adxl34x.Range.RANGE_2_G)
    print(accelerometer.range)
    measure_speed() """

print("script starts")
try:
    file = open("log_Run.txt","a")
    print("run!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!111")
    print("run!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!111")
    print("run!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!111")
    print("run!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!111")
    print("run!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!111")
    print("run!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!111")
    for i in range(15):
        h = 129 + random.randint(4+9,66)
        print(i+1)
        time.sleep(1)
        ax,ay,az = accelerometer.acceleration
        file.write("h= "+ str(h)+", ax= " + str(ax) + ", ay= " + str(ay) + ", az= " + str(az) + "\n")
    file.write("------------------------------------------------------------------------------\n")
    file.close()
finally:
    GPIO.cleanup()
    