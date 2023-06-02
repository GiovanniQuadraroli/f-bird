Bird = Class{}

function Bird:init()
    self.image = love.graphics.newImage('Assets/Images/bird.png')
    self.width = self.image:getWidth()
    self.height = self.image:getHeight()

    self.x = V_WIDTH / 2 - (self.width / 2)
    self.y = V_HEIGHT / 2 - (self.height / 2)

end

function Bird:render()
    love.graphics.draw(self.image, self.x, self.y)
end