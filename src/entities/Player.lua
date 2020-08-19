--[[
GALLAGHER    FINAL PROJECT
    2020

    -- entities/Player --
]]

Player = Class{__includes = Entity}

function Player:init(def)
    Entity.init(self, def)
end


function Player:update(dt)
    Entity.update(self, dt)
end


function Player:render()
    Entity.render(self)
end


function Player:hit()
    self:takeDamage()
    if self.currentHP == 0 then
        gStateStack:pop()
        gStateStack:push(GameOverState())
        print('death')
    end
end
