--[[
    FINAL PROJECT
    2020

    -- entities/Enemy -- 
]]


Enemy = Class{__includes = Entity}

function Enemy:init(def)
    Entity.init(self, def)
end


function Enemy:update(dt)
    Entity.update(self, dt)
end


function Enemy:render()
    Entity.render(self)
end


function Enemy:hit(entities, i)
    --self.hp = self.hp - 1
    self:takeDamage()
    if self.hp == 0 then
        if self.y < VIRTUAL_HEIGHT then
            score = score + 1
        end
        self:destroy(entities, i)
    end
end
