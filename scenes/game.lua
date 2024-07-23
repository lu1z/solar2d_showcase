local composer = require("composer")
local physics = require("physics")

local scene = composer.newScene()

-- 2, 3, 7
-- 4, 6, 8
-- 9, 6, 8
local retangleRefs = {}

function scene:create(e)
	local mainGroup = self.view
	physics.start()

	physics.setDrawMode("normal")
	physics.setGravity(0, 0)

	local topWall = display.newRect(mainGroup, w / 2, 0, w, 3)
	topWall.alpha = 0
	physics.addBody(topWall, "static")
	local bottonWall = display.newRect(mainGroup, w / 2, h, w, 3)
	bottonWall.alpha = 0
	physics.addBody(bottonWall, "static", { isSensor = true })
	local leftWall = display.newRect(mainGroup, 0, h / 2, 3, h)
	leftWall.alpha = 0
	physics.addBody(leftWall, "static")
	local rightWall = display.newRect(mainGroup, w, h / 2, 3, h)
	rightWall.alpha = 0
	physics.addBody(rightWall, "static")

	local ball = display.newCircle(mainGroup, w / 2, h / 2, w * 0.02)
	physics.addBody(ball, "dynamic", { bounce = 1, radius = w * 0.02 })
	ball:setLinearVelocity(0, -500)
	ball.id = "ball"
	ball:addEventListener("collision", function(event)
		if event.phase == "began" then
			if event.other.id == "block" then
				timer.performWithDelay(0, function()
					event.other:removeSelf()
					retangleRefs[event.other.j][event.other.i] = nil
				end)
			end
		end
	end)

	local player = display.newRect(mainGroup, w * 0.5, h * 0.7, w * 0.2, h * 0.02)
	physics.addBody(player, "static")
	local mouseListener = Runtime:addEventListener("mouse", function(event)
		if player == nil then
			return
		end
		if event.x < w * 0.1 or event.x > w * 0.9 then
			return
		end
		player.x = event.x
	end)

	for j = 1, 10, 1 do
		retangleRefs[j] = {}
		for i = 1, 10, 1 do
			local rect = display.newRect(mainGroup, w * (0.1 * (i - 0.55)), h * 0.02 * j, w * 0.09, h * 0.015)
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
					for j = 1, 10, 1 do
						for i = 1, 10, 1 do
							if retangleRefs[j][i] ~= nil then
								retangleRefs[j][i]:removeSelf()
								retangleRefs[j][i] = nil
							end
						end
					end
					ball:removeSelf()
					ball = nil
					Runtime:removeEventListener("mouse", mouseListener)
					mouseListener = nil
					player:removeSelf()
					player = nil
					topWall:removeSelf()
					topWall = nil
					bottonWall:removeSelf()
					bottonWall = nil
					leftWall:removeSelf()
					leftWall = nil
					rightWall:removeSelf()
					rightWall = nil
				end)
				composer.gotoScene("scenes.end", { effect = "crossFade", time = 800 })
			end
		end
	end)
end

scene:addEventListener("create", scene)

return scene
