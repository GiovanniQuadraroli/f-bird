push = require 'push'

WINDOW_HEIGHT = 720
WINDOW_WIDTH = 1280

V_HEIGHT = 288
V_WIDTH = 512

local background = love.graphics.newImage('Assets/Images/background.png')
local backgroundScroll = 0
local BACKGROUND_SCROLL_SPEED = 30
local BACKGROUND_LOOPING_POINT = 413

local ground = love.graphics.newImage('Assets/Images/ground.png')
local groundScroll = 0
local GROUND_SCROLL_SPEED = 60

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

function love.keypressed(key)
    if key == 'escape' then
        love.event.quit()
    end

end

function love.update(dt)
    backgroundScroll = (backgroundScroll + BACKGROUND_SCROLL_SPEED * dt) % BACKGROUND_LOOPING_POINT
    groundScroll = (groundScroll + GROUND_SCROLL_SPEED * dt) % V_WIDTH
end

function love.draw()
    push:start()
    love.graphics.draw(background, -backgroundScroll, 0)
    love.graphics.draw(ground, -groundScroll, V_HEIGHT - 16)
    push:finish()
end
