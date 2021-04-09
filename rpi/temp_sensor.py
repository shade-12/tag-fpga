import RPi.GPIO as GPIO
import time
import dht11

import numpy as np

# Set to BCM mode
GPIO.setmode(GPIO.BCM)
GPIO.setwarnings(False)
# Set GPIO Pins
GPIO_DHT = 18

# Create a DHT11 instance
ts = dht11.DHT11(pin = GPIO_DHT)

# Get temperature in °C from DHT11
def find_temp():
    return ts.read().temperature
    
try:
    print(temp())

except KeyboardInterrupt:
    print("\n")

finally:
    GPIO.cleanup()




