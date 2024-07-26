local composer = require("composer")

local scene = composer.newScene()

function scene:create(e)
	local mainGroup = self.view
	local fundo = display.newImageRect(mainGroup, "assets/images/" .. math.random(1, 4) .. ".jpg", w, h)
	fundo.x = w / 2
	fundo.y = h / 2

	display.newText({
		parent = mainGroup,
		x = w * 0.5,
		y = h * 0.1,
		text = "PERDEU!",
		font = fonte,
		fontSize = 50,
	})

	local buttonRecords = display.newText({
		parent = mainGroup,
		x = w * 0.5,
		y = h * 0.5,
		text = "Records",
		font = fonte,
		fontSize = 50,
	})
	buttonRecords:addEventListener("touch", function(e)
		if e.phase == "began" then
			composer.gotoScene("scenes.records", { effect = "crossFade", time = 800 })
		end
	end)
end

scene:addEventListener("create", scene)

return scene
