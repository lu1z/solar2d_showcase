local composer = require("composer")

local scene = composer.newScene()

function scene:create(event)
	local menu = self.view

	local titulo = display.newText(menu, "MENU", w * 0.5, h * 0.1, nil, 60)

	local textojogar = display.newText(menu, "JOGAR", w * 0.5, h * 0.40, nil, 60)

	local textorecordes = display.newText(menu, "CREDITOS", w * 0.5, h * 0.50, nil, 60)

	local textosair = display.newText(menu, "SAIR", w * 0.5, h * 0.9, nil, 50)

	local efeitoCena = {
		time = 500,
		effect = "fade",
	}

	textojogar:addEventListener("touch", function(e)
		if e.phase == "began" then
			composer.gotoScene("scenes.game", efeitoCena)
		end
	end)

	textorecordes:addEventListener("touch", function(e)
		if e.phase == "began" then
			composer.gotoScene("scenes.credits", efeitoCena)
		end
	end)

	textosair:addEventListener("touch", function(e)
		if e.phase == "began" then
			native.requestExit()
		end
	end)
end
scene:addEventListener("create", scene)
return scene
