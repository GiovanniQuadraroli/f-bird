TitleScreenState = Class{__includes = BaseState}

function TitleScreenState:init() end
function TitleScreenState:enter() end
function TitleScreenState:exit() end
function TitleScreenState:update(dt)
    if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then
        gStateMachine:change('play')
    end
end
function TitleScreenState:render() 
    love.graphics.setFont(flappyFont)
    love.graphics.printf("F-Bird", 0, 64, V_WIDTH, 'center')

    love.graphics.setFont(mediumFont)
    love.graphics.printf("Press Enter", 0, 100, V_WIDTH, 'center')
end