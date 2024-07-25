local composer = require("composer")

local scene = composer.newScene()

function scene:create(event)
	local credits = self.view

	local efeitoCena = {
		time = 500,
		effect = "fade",
	}

	local texto = display.newText(credits, "CREDITOS", w * 0.5, h * 0.1, font, 60)

	local textosair = display.newText(credits, "SAIR", w * 0.5, h * 0.9, font, 50)

	textosair:addEventListener("touch", function(e)
		if e.phase == "began" then
			composer.gotoScene("scenes.menu", efeitoCena)
		end
	end)
end
scene:addEventListener("create", scene)
return scene
