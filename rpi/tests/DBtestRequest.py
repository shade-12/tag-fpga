import requests
import time
import math

payload = {
    "readingId": "d891b9fd-10bc-4381-ae51-612312aafb2aa",
    "latitude": "49.26817612347401",
    "longitude": "-123.24758101946856",
    "temperature": "30",
    "heartRate": "95",
    "accel_x": "30",
    "accel_y": "30",
    "accel_z": "30",
    "time": math.floor(time.time()),
}

tagId = '123'
res = requests.post(
    'https://k7t0ap6b0i.execute-api.us-west-2.amazonaws.com/dev/tags/' + tagId + '/sensors', json=payload)

