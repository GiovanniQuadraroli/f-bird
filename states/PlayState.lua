PlayState = Class{__includes = BaseState}

PIPE_SPEED = 60
PIPE_WIDTH = 70
PIPE_HEIGHT = 288

BIRD_WIDTH = 38
BIRD_HEIGHT = 24
PAIR_SPAWN_TIME = 2

paused = false

function PlayState:init()
    self.bird = Bird()
    self.pipePairs = {}
    self.timer = 0

    self.score = 0

    self.lastY = -PIPE_HEIGHT + math.random(80) + 20

end

function PlayState:enter() end
function PlayState:exit() end
function PlayState:update(dt)
    if love.keyboard.wasPressed('p') then
        paused = not paused
        scrolling = not scrolling
    end
    if paused then
        return
    end
    self.timer = self.timer + dt
    if self.timer > PAIR_SPAWN_TIME then
        local y = math.max(-PIPE_HEIGHT + 10, math.min(self.lastY + math.random(-20, 20), V_HEIGHT - 90 - PIPE_HEIGHT))
        self.lastY = y
        table.insert(self.pipePairs, PipePair(y))
        self.timer = 0
        GAP_HEIGHT = math.random(56, 100)
        PAIR_SPAWN_TIME = math.random(2,5)
    end
    self.bird:update(dt)

    for k, pair in pairs(self.pipePairs) do
        if not pair.scored then
            if pair.x + PIPE_WIDTH < self.bird.x then
                self.score = self.score + 1
                pair.scored = true
                sounds['score']:play()
            end
        end
        for l,pipe in pairs(pair.pipes) do
            if self.bird:collision(pipe) then
                sounds['explosion']:play()
                sounds['hurt']:play()
                gStateMachine:change('score', {
                    score = self.score
                })
            end
        end
        pair:update(dt)
    end

    for k, pair in pairs(self.pipePairs) do
        if pair.remove then
            table.remove(self.pipePairs, k)
        end
    end

    if self.bird.y > V_HEIGHT - 15 then
        sounds['explosion']:play()
        sounds['hurt']:play()
        gStateMachine:change('score', {
            score = self.score
        })
    end

end

function PlayState:render()
    self.bird:render()
    for k, pair in pairs(self.pipePairs) do
        pair:render()
    end
    love.graphics.setFont(flappyFont)
    love.graphics.print('Score: ' .. tostring(self.score), 8, 8)
    if paused then
        love.graphics.setFont(mediumFont)
    love.graphics.printf('GAME PAUSED PRESS P TO RESUME', 0, 100, V_WIDTH, 'center')
    end
end

function PlayState:enter()
    scrolling = true
    paused = false
end

function PlayState:exit()
    scrolling = false
    paused = false
end
