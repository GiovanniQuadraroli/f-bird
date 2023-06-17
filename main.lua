push = require 'push'
Class = require 'class'

require 'Bird'
require 'Pipe'
require 'PipePair'

require 'StateMachine'

require 'states/BaseState'
require 'states/PlayState'
require 'states/TitleScreenState'
require 'states/ScoreState'
require 'states/CountdownState'


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

scrolling = true

function love.load()
    love.graphics.setDefaultFilter('nearest', 'nearest')
    love.window.setTitle('F-Bird')

    smallFont = love.graphics.newFont('Assets/Fonts/font.ttf', 8)
    mediumFont = love.graphics.newFont('Assets/Fonts/flappy.ttf', 14)
    flappyFont = love.graphics.newFont('Assets/Fonts/flappy.ttf', 28)
    hugeFont = love.graphics.newFont('Assets/Fonts/font.ttf', 56)
    

    sounds = {
        ['jump'] = love.audio.newSource('Assets/Sounds/jump.wav','static'),
        ['explosion'] = love.audio.newSource('Assets/Sounds/explosion.wav','static'),
        ['hurt'] = love.audio.newSource('Assets/Sounds/hurt.wav','static'),
        ['score'] = love.audio.newSource('Assets/Sounds/score.wav','static'),
        ['music'] = love.audio.newSource('Assets/Sounds/marios_way.mp3','static'),
        ['bip'] = love.audio.newSource('Assets/Sounds/bip.wav', 'static')
    }

    sounds['music']:setLooping(true)
    sounds['music']:play()

    push:setupScreen(V_WIDTH, V_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
        vsync = true,
        fullscreen = false,
        resizable = true
    })

    gStateMachine = StateMachine {
        ['title'] = function() return TitleScreenState() end,
        ['play'] = function() return PlayState() end,
        ['score'] = function() return ScoreState() end,
        ['count'] = function() return CountdownState() end
    }

    gStateMachine:change('title')

    love.keyboard.keysPressed = {}
    love.mouse.buttonsPressed = {}

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

function love.mousepressed(x,y,button)
    love.mouse.buttonsPressed[button] = true
end

function love.mouse.wasPressed(button)
    return love.mouse.buttonsPressed[button]
end

function love.keyboard.wasPressed(key)
    if love.keyboard.keysPressed[key] == true then
        return true
    else
        return false
    end
end

function love.update(dt)
    if scrolling then
        backgroundScroll = (backgroundScroll + BACKGROUND_SCROLL_SPEED * dt) % BACKGROUND_LOOPING_POINT
        groundScroll = (groundScroll + GROUND_SCROLL_SPEED * dt) % V_WIDTH
    end
    gStateMachine:update(dt)
    love.keyboard.keysPressed = {}
    love.mouse.buttonsPressed = {}
end

function love.draw()
    push:start()
    love.graphics.draw(background, -backgroundScroll, 0)
    gStateMachine:render()
    love.graphics.draw(ground, -groundScroll, V_HEIGHT - 16)
    push:finish()
end
