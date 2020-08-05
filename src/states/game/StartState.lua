--[[
    FINAL PROJECT
    2020

    -- states/game/StartState --
--]]

StartState = Class{__includes = BaseState}

function StartState:init()
    gSounds['music-woo']:setLooping(true)
    --gSounds['music-woo']:play()
end


function StartState:update()
    if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return')
    or joystick and joystick:isGamepadDown('a') then
    gSounds['start']:play()
        gStateStack:pop()
        gStateStack:push(PlayState())
    end
end


function StartState:render()
    love.graphics.setColor(unpack(GREEN1))
    love.graphics.rectangle('fill', 0, 0, VIRTUAL_WIDTH, VIRTUAL_HEIGHT)
    love.graphics.setColor(unpack(GREEN4))
    love.graphics.setFont(gFonts['pixel-operator-title'])
    love.graphics.printf('GALLAGHER', 0, VIRTUAL_HEIGHT / 2 - 8, VIRTUAL_WIDTH, 'center')
    love.graphics.setColor(1, 1, 1, 1)
end
