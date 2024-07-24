local composer = require("composer")

local scene = composer.newScene()

function scene:create(e)
	local mainGroup = self.view

	display.newText({
		parent = mainGroup,
		x = w * 0.5,
		y = h * 0.1,
		text = "Perdeu Otário!",
	})

	local buttonRecords = display.newText({
		parent = mainGroup,
		x = w * 0.5,
		y = h * 0.5,
		text = "Records",
	})
	buttonRecords:addEventListener("touch", function(e)
		if e.phase == "began" then
			composer.gotoScene("scenes.records", { effect = "crossFade", time = 800 })
		end
	end)
end

scene:addEventListener("create", scene)

return scene
