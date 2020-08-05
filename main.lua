--[[
    FINAL PROJECT
    2020

    -- Main --
]]

require 'src/Dependencies'


function love.load()
    love.window.setTitle('Final Project')
    love.graphics.setDefaultFilter('nearest', 'nearest')

    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
            fullscreen = true,
            vsync = true,
            resizable = true
        })

    gStateStack = StateStack()
    gStateStack:push(StartState())

    local joysticks = love.joystick.getJoysticks()
    joystick = joysticks[1] or nil
    if joystick and joystick:isGamepad() then
        print('Gamepad working')
    else print('No gamepad') end

    love.keyboard.keysPressed = {}
end


function love.resize(w, h)
    push:resize(w, h)
end


function love.keypressed(key)
    if key == 'escape' then
        love.event.quit()
    end
    
    love.keyboard.keysPressed[key] = true
end


function love.keyboard.wasPressed(key)
    return love.keyboard.keysPressed[key]
end


function love.update(dt)
    Timer.update(dt)
    gStateStack:update(dt)

    love.keyboard.keysPressed = {}
end


function love.draw()
    push:start()
    gStateStack:render()
    push:finish()
end
