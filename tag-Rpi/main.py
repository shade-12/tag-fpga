import boto3

from datetime import datetime
import calendar
import gps
import accel345
import temp_sensor
import string
import random

# Get the service resource.
dynamodb = boto3.resource('dynamodb')

# Instantiate a table resource object
table = dynamodb.Table('sensor-reading')
print(table.creation_date_time)

tagId = 123
 
# The limit for the extended ASCII Character set
MAX_LIMIT = 255
readingId = ''
 
for _ in range(10):
    random_integer = random.randint(0, MAX_LIMIT)
    # Keep appending random characters using chr(x)
    readingId += (chr(random_integer))

activity = " " 
heartRate = 72
latitude = 49.26586906787906
longitude = -123.25706776922407
temperature = 32 # temp()
ax,ay,az = measure_speed()

d = datetime.utcnow()
unixtime = calendar.timegm(d.utctimetuple())

table.put_item(
   Item={
        'tagId': tagId,
        'readingId': readingId,
        'time': unixtime,
        'activity': activity,
        'heartRate': heartRate,
        'latitude': latitude,
        'longitude': longitude,
        'temperature': temperature,
        'accel_x': ax,
        'accel_y': ay,
        'accel_z': az,
    }
)

print("inserted item")
