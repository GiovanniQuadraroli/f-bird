push = require 'push'

WINDOW_HEIGHT = 720
WINDOW_WIDTH = 1280

V_HEIGHT = 288
V_WIDTH = 512

local background = love.graphics.newImage('Assets/Images/background.png')
local ground = love.graphics.newImage('Assets/Images/ground.png')

function love.load()
    love.graphics.setDefaultFilter('nearest', 'nearest')
    love.window.setTitle('F-Bird')

    push:setupScreen(V_WIDTH, V_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
        vsync = true,
        fullscreen = false,
        resizable = true
    })
end

function love.resize(w, h)
    push:resize(w, h)
end

function love.draw()
    push:start()
    love.graphics.draw(background, 0, 0)
    love.graphics.draw(ground, 0, V_HEIGHT - 16)
    push:finish()
end
