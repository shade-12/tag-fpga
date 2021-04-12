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

--build request payload
local payload =
{
  TableName = "sensor-reading",
  Key = 
  {
    tagID = db:S("123"),
    poach = db:S("hello")
  }
}

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

--make DynamoDB request
db:request("GetItem", payload)
-------------------------------------------------------------------
p = result from algo 
-------------------------------------------------------------
payload =
{
  TableName = "sensor-reading",
  Key = 
  {
    tagID = db:S("123"),
    poach = db:S("hello")
  },
    UpdateExpression = "SET poach = :val1",\
    ExpressionAttributeValues = 
    {
      [":val1"] = p,
    },
    ReturnValues = "ALL_NEW"
  }
    
db:request("UpdateItem", payload)