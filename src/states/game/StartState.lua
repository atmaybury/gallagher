--[[
    FINAL PROJECT
    2020

    -- states/game/StartState --
--]]

StartState = Class{__includes = BaseState}

function StartState:init()
    gSounds['music-woo']:setLooping(true)
    gSounds['music-woo']:play()
end


function StartState:update()
    if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return')
    or joystick:isGamepadDown('a') then
        gStateStack:pop()
        gStateStack:push(PlayState())
    end
end


function StartState:render()
    love.graphics.setColor(.5, .5, .5, 1)
    love.graphics.setFont(gFonts['pixel-operator-title'])
    love.graphics.printf('FINAL PROJECT', 0, VIRTUAL_HEIGHT / 2 - 8, VIRTUAL_WIDTH, 'center')
end
