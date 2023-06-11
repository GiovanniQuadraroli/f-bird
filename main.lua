push = require 'push'
Class = require 'class'

require 'Bird'
require 'Pipe'
require 'PipePair'

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

local bird = Bird()

local pipesPairs = {}

local spawnTimer = 0

local lastY = -PIPE_HEIGHT + math.random(80) + 20

function love.load()
    love.graphics.setDefaultFilter('nearest', 'nearest')
    love.window.setTitle('F-Bird')

    push:setupScreen(V_WIDTH, V_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
        vsync = true,
        fullscreen = false,
        resizable = true
    })

    love.keyboard.keysPressed = {}
end

function love.resize(w, h)
    push:resize(w, h)
end

function love.keypressed(key)

    love.keyboard.keysPressed[key] = true

    if key == 'escape' then
        love.event.quit()
    end

end

function love.keyboard.wasPressed(key)
    if love.keyboard.keysPressed[key] == true then
        return true
    else
        return false
    end

end

function love.update(dt)
    backgroundScroll = (backgroundScroll + BACKGROUND_SCROLL_SPEED * dt) % BACKGROUND_LOOPING_POINT
    groundScroll = (groundScroll + GROUND_SCROLL_SPEED * dt) % V_WIDTH
    spawnTimer = spawnTimer + dt
    if spawnTimer > 2 then
        local y = math.max(-PIPE_HEIGHT + 10, math.min(lastY + math.random(-20, 20), V_HEIGHT - 90 - PIPE_HEIGHT))
        lastY = y
        table.insert(pipesPairs, PipePair(y))
        spawnTimer = 0
    end
    bird:update(dt)

    for k, pair in pairs(pipesPairs) do
        pair.update(dt)
    end

    for k, pair in pairs(pipesPairs) do
        if pair.remove then
            table.remove(pipesPairs, k)
        end
    end
end

function love.draw()
    push:start()
    love.graphics.draw(background, -backgroundScroll, 0)
    for k, pair in pairs(pipesPairs) do
        pair:render()
    end
    love.graphics.draw(ground, -groundScroll, V_HEIGHT - 16)
    bird:render()
    push:finish()
end
