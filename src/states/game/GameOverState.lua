--[[
    FINAL PROJECT
    2020

    -- states/game/GameOverState --
--]]

GameOverState = Class{__includes = BaseState}

function GameOverState:init()
end


function GameOverState:update()
    if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return')
    or joystick and joystick:isGamepadDown('a') then
    gSounds['start']:play()
        gStateStack:pop()
        gStateStack:push(StartState)
    end
end


function GameOverState:render()
    love.graphics.setColor(unpack(GREEN1))
    love.graphics.rectangle('fill', 0, 0, VIRTUAL_WIDTH, VIRTUAL_HEIGHT)
    love.graphics.setColor(unpack(GREEN4))
    love.graphics.setFont(gFonts['pixel-operator-title'])
    love.graphics.printf('GAME OVER', 0, VIRTUAL_HEIGHT / 2 - 8, VIRTUAL_WIDTH, 'center')
    love.graphics.setFont(gFonts['pixel-operator'])
    love.graphics.printf('KILLS: ' .. tostring(kills), 0, VIRTUAL_HEIGHT / 2 + 32, VIRTUAL_WIDTH, 'center')
    love.graphics.printf('ACCURACY : ' .. tostring(accuracy), 0, VIRTUAL_HEIGHT / 2 + 56, VIRTUAL_WIDTH, 'center')
    love.graphics.printf('SCORE: ' .. tostring(score), 0, VIRTUAL_HEIGHT / 2 + 80, VIRTUAL_WIDTH, 'center')
    love.graphics.setColor(1, 1, 1, 1)
end
