import time
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
    for i in range(2):
        h = 129 + random.randint(0, 56)
        file = open("log_Run.txt","a")
        ax,ay,az = accelerometer.acceleration
        file.write("h= "+ str(h)+", ax= " + str(ax) + ", ay= " + str(ay) + ", az= " + str(az) + "\n")
        time.sleep(1)
        print(i)
        file.close()
finally:
    GPIO.cleanup()
    