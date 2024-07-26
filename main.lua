w, h = display.contentWidth, display.contentHeight
font = native.newFont("assets/fonts/PUSAB___.otf")

fonte = "assets/fonts/PUSAB___.ttf"
nome = "player"
audioPonto = audio.loadStream("assets/sounds/collision.mp3")

local composer = require("composer")

composer.gotoScene("scenes.menu")
