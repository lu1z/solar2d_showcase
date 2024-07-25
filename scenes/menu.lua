local composer = require("composer")

local scene = composer.newScene()

function scene:create(event)
	local menu = self.view

	local titulo = display.newText(menu, "MENU", w * 0.5, h * 0.1, font, 60)

	local textojogar = display.newText(menu, "JOGAR", w * 0.5, h * 0.40, font, 60)

	local textocreditos = display.newText(menu, "CREDITOS", w * 0.5, h * 0.50, font, 60)

	local textorecordes = display.newText(menu, "RECORDES", w * 0.5, h * 0.60, font, 60)

	local defaultField

	local function textListener(event)
		if event.phase == "began" then
		elseif event.phase == "ended" or event.phase == "submitted" then
			print(event.target.text)
			nome = event.target.text
		elseif event.phase == "editing" then
			nome = event.text
			print(event.text)
		end
	end
	defaultField = native.newTextField(w * 0.5, h * 0.25, 180, 60)
	defaultField:addEventListener("userInput", textListener)
	menu:insert(defaultField)

	local textosair = display.newText({
		font = "assets/fonts/PUSAB___.otf",
		x = w * 0.5,
		y = h * 0.9,
		parent = menu,
		text = "SAIR",
		fontSize = 50,
	})

	local efeitoCena = {
		time = 500,
		effect = "fade",
	}

	textojogar:addEventListener("touch", function(e)
		if e.phase == "began" then
			composer.gotoScene("scenes.game", efeitoCena)
			defaultField:removeSelf()
			composer.removeScene("scenes.menu")
		end
	end)

	textocreditos:addEventListener("touch", function(e)
		if e.phase == "began" then
			composer.gotoScene("scenes.credits", efeitoCena)
			defaultField:removeSelf()
			composer.removeScene("scenes.menu")
		end
	end)

	textorecordes:addEventListener("touch", function(e)
		if e.phase == "began" then
			composer.gotoScene("scenes.records", efeitoCena)
			defaultField:removeSelf()
			composer.removeScene("scenes.menu")
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
