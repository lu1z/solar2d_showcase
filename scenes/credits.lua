local composer = require("composer")

local scene = composer.newScene()

function scene:create(event)
	local credits = self.view

	local fundo = display.newImageRect(credits, "assets/images/" .. math.random(1, 4) .. ".jpg", w, h)
	fundo.x = w / 2
	fundo.y = h / 2

	local efeitoCena = {
		time = 500,
		effect = "fade",
	}

	display.newText({
		parent = credits,
		x = w * 0.5,
		y = h * 0.3,
		text = "Luiz",
		font = fonte,
		fontSize = 50,
	})
	display.newText({
		parent = credits,
		x = w * 0.5,
		y = h * 0.4,
		text = "Leo",
		font = fonte,
		fontSize = 50,
	})
	display.newText({
		parent = credits,
		x = w * 0.5,
		y = h * 0.5,
		text = "Jaime",
		font = fonte,
		fontSize = 50,
	})
	display.newText({
		parent = credits,
		x = w * 0.5,
		y = h * 0.6,
		text = "Eduardo",
		font = fonte,
		fontSize = 50,
	})

	local texto = display.newText(credits, "CREDITOS", w * 0.5, h * 0.1, fonte, 60)

	local textosair = display.newText(credits, "SAIR", w * 0.5, h * 0.9, fonte, 50)

	textosair:addEventListener("touch", function(e)
		if e.phase == "began" then
			composer.gotoScene("scenes.menu", efeitoCena)
		end
	end)
end
scene:addEventListener("create", scene)
return scene
