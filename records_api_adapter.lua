local network = require("network")
local json = require("json")

local BASE_URL = "https://records-api.adaptable.app"

local function callback(action)
	return function(event)
		if event.isError then
			print("NETWORK ERROR: ", event.response)
		else
			print("RESPONSE: " .. event.response)
			if action ~= nil then
				action(json.decode(event.response))
			end
		end
	end
end

local adapter = {
	getRecords = function(action)
		network.request(BASE_URL, "GET", callback(action))
	end,
	postRecord = function(player, score, action)
		local payload = {
			headers = {
				["Content-Type"] = "application/json",
			},
			body = json.encode({ player = player, score = score }),
		}
		network.request(BASE_URL, "POST", callback(action), payload)
	end,
}

return adapter
