import requests

def find_loc():
    res = requests.get('https://ipinfo.io/')
    data = res.json()
    location = data['loc'].split(',')
    lat = float(location[0])
    lon = float(location[1])
    print(lat)
    print(lon) 
    return lat,lon

find_loc()