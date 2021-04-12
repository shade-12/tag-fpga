-- adapted from: https://develephant.github.io/dynamodb-coronasdk/example/
local db = require('dynamodb.client')

SSID = "TELUS4136"
SSID_PASSWORD = "g9fh6f9b83"

-- connect to wifi
wifi.setmode(wifi.STATION)
wifi.sta.config(SSID,SSID_PASSWORD)
wifi.sta.autoconnect(1)

tmr.delay(1000000) -- wait 1 second

t_id = "1234"
HOST = "k7t0ap6b0i.execute-api.us-west-2.amazonaws.com"
URI = "/dev/tags/"..t_id.."/sensors"

--initialize
db:init({
  aws_key = "AKIAVIZHQ5FY7Z2CVBGZ",
  aws_secret = "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">,
  aws_region = "us-west-2"
})


--set up listener
function dbEventListener( evt )
  if evt.error then
    print(evt.reason, evt.status)
  else
    local data_table = evt.result
  end
end

--add event listener
db.events:addEventListener( "DynamoDBEvent", dbEventListener )


function update_db_entry(tag_id, poach_res)
    
    --build request payload
    payload = {
        TableName = "sensor-reading",
        Key = {
            tagID = db:S(tag_id)
        },
        UpdateExpression = "SET poach = :val",
        ExpressionAttributeValues = {
            [":val"] = poach_res,
        },
        ReturnValues = "NONE"
    }

    db:request("UpdateItem", payload)
end

function check_wifi()
    ip = wifi.sta.getip()

    if (ip==nil) then
        print("Connecting...")
    else
        tmr.stop(0)
        print("Connected to AP!")
        print(ip)
    end
end