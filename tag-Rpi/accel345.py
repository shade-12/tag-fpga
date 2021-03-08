import time
import board
import busio
import adafruit_adxl34x

i2c = busio.I2C(board.SCL, board.SDA)
accelerometer = adafruit_adxl34x.ADXL345(i2c)

def measure_speed():
    while True:
        print("%f %f %f"%accelerometer.acceleration)
        time.sleep(0.5)