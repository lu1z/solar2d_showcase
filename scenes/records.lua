local composer = require("composer")

local records_api_adapter = require("records_api_adapter")

local scene = composer.newScene()

function scene:create(e)
	local mainGroup = self.view

	display.newText({
		parent = mainGroup,
		x = w * 0.5,
		y = h * 0.1,
		text = "Recordes",
	})

	records_api_adapter.getRecords(function(response)
		local records = ""
		for _, record in ipairs(response) do
			records = records .. record.player .. ": " .. record.score .. "\n"
		end
		display.newText({
			parent = mainGroup,
			x = w * 0.5,
			y = h * 0.5,
			text = records,
		})
	end)
	-- EXEMPLO DE COMO REGISTRAR UM RECORDE
	-- records_api_adapter.postRecord("luiz", 69, function(response)
	--   if response.message ~= nil then
	--     print("Resolva estes problemas no seu código: " .. response.message)
	--   end
	-- end)
end

scene:addEventListener("create", scene)

return scene
