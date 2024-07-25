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
		font = font,
		fontSize = 50,
	})

	records_api_adapter.getRecords(function(response)
		local function ordenar(a, b)
			return a.score > b.score
		end
		table.sort(response, ordenar)

		local records = ""
		-- local minimo = #response
		for i = 1, 10 do
			records = records .. response[i].player .. ": " .. response[i].score .. "\n"
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

	local textosair = display.newText({
		parent = mainGroup,
		text = "SAIR",
		x = w * 0.5,
		y = h * 0.9,
		font = font,
		fontSize = 50,
	})

	textosair:addEventListener("touch", function(e)
		if e.phase == "began" then
			composer.gotoScene("scenes.menu")
		end
	end)
end
scene:addEventListener("create", scene)

return scene
