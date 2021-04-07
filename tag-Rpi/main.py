import gps
import accel345
import temp_sensor
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

heartRate = 72
latitude = 49.26586906787906
longitude = -123.25706776922407
temperature = 32 # temp()
ax,ay,az = measure_speed()


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
