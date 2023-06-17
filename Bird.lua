Bird = Class{}

local GRAVITY = 3
local JUMP_SPEED = -1.5

function Bird:init()
    self.image = love.graphics.newImage('Assets/Images/bird.png')
    self.width = self.image:getWidth()
    self.height = self.image:getHeight()

    self.x = V_WIDTH / 2 - (self.width / 2)
    self.y = V_HEIGHT / 2 - (self.height / 2)

    self.dy = 0

end

function Bird:collision(entity)
    -- Check if the entity collides with the bird
    if entity.x < self.x + self.width and
       entity.x + entity.width > self.x and
       entity.y < self.y + self.height and
       entity.y + entity.height > self.y then
        return true
    else
        return false
    end
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