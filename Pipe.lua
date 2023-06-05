Pipe = Class {}

local PIPE_IMAGE = love.graphics.newImage('Assets/Images/pipe.png')

local PIPE_SCROLL = -60

function Pipe:init()
    self.x = V_WIDTH
    self.y = math.random(V_HEIGHT / 4, V_HEIGHT - 10)
    self.width = PIPE_IMAGE:getWidth()
end

function Pipe:update(dt)
    self.x = self.x + PIPE_SCROLL * dt
end

function Pipe:render()
    love.graphics.draw(PIPE_IMAGE,math.floor(self.x + 0.5), math.floor(self.y))
end
