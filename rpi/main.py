#!/usr/bin/env python

from gps import find_loc
from accel345 import measure_speed
from temp_sensor import find_temp
from heart import heartrate_measure

import string
import random
import requests
import time
import math

tagId = '1234'
 
# The limit for the extended ASCII Character set
MAX_LIMIT = 255
readingId = ''
 
for _ in range(10):
    random_integer = random.randint(0, MAX_LIMIT)
    # Keep appending random characters using chr(x)
    readingId += (chr(random_integer))

# get data from sensor
heartRate = heartrate_measure()
latitude,longitude = find_loc()
temperature = find_temp()
ax,ay,az = measure_speed()

# create json payload with sensor data
payload = {
    "readingId": readingId,
    "latitude": latitude,
    "longitude": longitude,
    "temperature": temperature,
    "heartRate": heartRate,
    "accel_x": ax,
    "accel_y": ay,
    "accel_z": az,
    "time": math.floor(time.time()),
}

res = requests.post(
    'https://k7t0ap6b0i.execute-api.us-west-2.amazonaws.com/dev/tags/' + tagId + '/sensors', json=payload)

print("inserted item")
