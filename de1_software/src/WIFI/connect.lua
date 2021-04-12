-- This information is used by the Wi-Fi dongle to make a wireless connection to the router
SSID = "TELUS4136"
SSID_PASSWORD = "g9fh6f9b83"

-- configure ESP as a station
wifi.setmode(wifi.STATION)
wifi.sta.config(SSID,SSID_PASSWORD)
wifi.sta.autoconnect(1)