local composer = require("composer")
local physics = require("physics")

local records_api_adapter = require("records_api_adapter")

local scene = composer.newScene()

function scene:create(e)
	local mainGroup = self.view
	local fundo = display.newImageRect(mainGroup, "assets/images/" .. math.random(1, 4) .. ".jpg", w, h)
	fundo.x = w / 2
	fundo.y = h / 2
	local contadorPontos = 0

	-- 2, 3, 7
	-- 4, 6, 8
	-- 9, 6, 8
	local retangleRefs = {}

	physics.start()
	physics.pause()

	physics.setDrawMode("normal")
	physics.setGravity(0, 0)

	local topWall = display.newRect(mainGroup, w / 2, 0, w, 3)
	topWall.alpha = 0
	physics.addBody(topWall, "static")
	local bottonWall = display.newRect(mainGroup, w / 2, h, w * 200, 3)
	bottonWall.alpha = 0
	physics.addBody(bottonWall, "static", { isSensor = true })
	local leftWall = display.newRect(mainGroup, 0, h / 2, 3, h)
	leftWall.alpha = 0
	physics.addBody(leftWall, "static")
	local rightWall = display.newRect(mainGroup, w, h / 2, 3, h)
	rightWall.alpha = 0
	physics.addBody(rightWall, "static")

	local pontos = display.newText({
		parent = mainGroup,
		text = "0",
		x = w * 0.5,
		y = h * 0.9,
		font = "assets/fonts/PUSAB___old.otf",
		fontSize = 50,
	})

	local ball = display.newCircle(mainGroup, w / 2, h * 0.6, w * 0.02)
	physics.addBody(ball, "dynamic", { bounce = 1, radius = w * 0.02 })
	ball:setLinearVelocity(0, -500)
	ball.id = "ball"
	ball:addEventListener("collision", function(event)
		if event.phase == "began" then
			if event.other.id == "block" then
				audio.seek(850, audioPonto)
				audio.play(audioPonto)
				timer.performWithDelay(0, function()
					contadorPontos = contadorPontos + 1
					pontos.text = contadorPontos .. ""
					event.other:removeSelf()
					retangleRefs[event.other.j][event.other.i] = nil
				end)
			end
		end
	end)

	local player = display.newRoundedRect(mainGroup, w * 0.5, h * 0.7, w * 0.2, h * 0.02, 15)
	local bolaSeguidora = display.newCircle(mainGroup, w * 0.5, h * 0.755, 0)

	physics.addBody(player, "static", { bounce = 1 })
	physics.addBody(bolaSeguidora, "static", { bounce = 1, radius = 70 })
	local mouseListener = Runtime:addEventListener("mouse", function(event)
		if player == nil or bolaSeguidora == nil then
			return
		end
		if event.x < w * 0.1 or event.x > w * 0.9 then
			return
		end
		bolaSeguidora.x = event.x
		player.x = event.x
	end)

	for j = 1, 10, 1 do
		retangleRefs[j] = {}
		for i = 1, 10, 1 do
			local rect = display.newRect(mainGroup, w * (0.1 * (i - 0.55)), h * 0.05 * j, w * 0.09, h * 0.015)
			rect:setFillColor(math.random(), math.random(), math.random())
			physics.addBody(rect, "static")
			rect.id = "block"
			rect.i = i
			rect.j = j
			retangleRefs[j][i] = rect
		end
	end

	bottonWall:addEventListener("collision", function(event)
		if event.phase == "began" then
			if event.other.id == "ball" then
				timer.performWithDelay(800, function()
					local score = 0
					for j = 1, 10, 1 do
						for i = 1, 10, 1 do
							if retangleRefs[j][i] ~= nil then
								retangleRefs[j][i]:removeSelf()
								retangleRefs[j][i] = nil
							else
								score = score + 1
							end
						end
					end
					records_api_adapter.postRecord(nome, score, function(response)
						if response.message ~= nil then
							print("Resolva estes problemas no seu código: " .. response.message)
						end
					end)
					ball:removeSelf()
					ball = nil
					Runtime:removeEventListener("mouse", mouseListener)
					mouseListener = nil
					player:removeSelf()
					player = nil
					bolaSeguidora:removeSelf()
					bolaSeguidora = nil
					topWall:removeSelf()
					topWall = nil
					bottonWall:removeSelf()
					bottonWall = nil
					leftWall:removeSelf()
					leftWall = nil
					rightWall:removeSelf()
					rightWall = nil
					physics.stop()
					composer.removeScene("scenes.game")
				end)
				composer.gotoScene("scenes.end", { effect = "crossFade", time = 800 })
			end
		end
	end)
end

function scene:show(event)
	local sceneGroup = self.view
	local phase = event.phase

	if phase == "will" then
		-- Code here runs when the scene is still off screen (but is about to come on screen)
	elseif phase == "did" then
		-- Code here runs when the scene is entirely on screen
		physics.start()
	end
end
scene:addEventListener("show", scene)
scene:addEventListener("create", scene)

return scene
