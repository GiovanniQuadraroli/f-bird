PipePair = Class {}

local GAP_HEIGHT = 90

function PipePair:init(y)
    self.x = V_WIDTH + 32
    self.y = y

    self.pipes = {
        ['upper'] = Pipe(self.y, 'top'),
        ['lower'] = Pipe(self.y + PIPE_HEIGHT + GAP_HEIGHT)
    }

    self.remove = false
end

function PipePair:update(dt)
    if self.x > -PIPE_WIDTH then
        self.x = self.x - PIPE_SPEED * dt
        self.pipes['lower'].x = self.x
        self.pipes['higher'].x = self.x
    else
        self.remove = true
    end
end

function PipePair:render()
    for k, pipe in self.pipes do
        pipe:render()
    end
end