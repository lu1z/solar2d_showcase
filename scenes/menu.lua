local composer = require("composer")

local scene = composer.newScene()

function scene:create(event)
	local menu = self.view

	local fundo = display.newImageRect(menu, "assets/images/" .. math.random(1, 4) .. ".jpg", w, h)
	fundo.x = w / 2
	fundo.y = h / 2

	local titulo = display.newText(menu, "ARKANOIA", w * 0.5, h * 0.1, fonte, 60)

	local textojogar = display.newText(menu, "JOGAR", w * 0.5, h * 0.40, fonte, 60)

	local textocreditos = display.newText(menu, "CREDITOS", w * 0.5, h * 0.50, fonte, 60)

	local textorecordes = display.newText(menu, "RECORDES", w * 0.5, h * 0.60, fonte, 60)

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
		font = fonte,
		x = w * 0.5,
		y = h * 0.9,
		parent = menu,
		text = "SAIR",
		fontSize = 50,
	})

	display.newText({
		font = fonte,
		x = w * 0.5,
		y = h * 0.2,
		parent = menu,
		text = "Nickname:",
		fontSize = 35,
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
