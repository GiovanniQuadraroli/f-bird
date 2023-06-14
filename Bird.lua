Bird = Class{}

local GRAVITY = 4
local JUMP_SPEED = -2

function Bird:init()
    self.image = love.graphics.newImage('Assets/Images/bird.png')
    self.width = self.image:getWidth()
    self.height = self.image:getHeight()

    self.x = V_WIDTH / 2 - (self.width / 2)
    self.y = V_HEIGHT / 2 - (self.height / 2)
    print("X: ",self.x ,"Y:", self.y)

    self.dy = 0

end

function Bird:update(dt)
    self.dy = self.dy + GRAVITY * dt
    if love.keyboard.wasPressed('space') then
        self.dy = JUMP_SPEED
    end
    self.y = self.y + self.dy
end

function Bird:render()
    love.graphics.draw(self.image, self.x, self.y)
end