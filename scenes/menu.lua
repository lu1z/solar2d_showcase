local composer = require("composer")

local scene = composer.newScene()

function scene:create(event)
	local menu = self.view

	local titulo = display.newText(menu, "MENU", w * 0.5, h * 0.1, font, 60)

	local textojogar = display.newText(menu, "JOGAR", w * 0.5, h * 0.40, font, 60)

	local textorecordes = display.newText(menu, "CREDITOS", w * 0.5, h * 0.50, font, 60)

	local textosair = display.newText({
		font = "assets/fonts/PUSAB___.otf",
		x = w * 0.5,
		y = h * 0.9,
		parent = menu,
		text = "SAIR",
		fontSize = 80,
	})

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
