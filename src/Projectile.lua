--[[
    FINAL PROJECT
    2020

    -- Projectile -- 
]]

Projectile = Class{}

function Projectile:init(def)
    self.x = def.x
    self.y = def.y

    self.dx = def.dx or 0
    self.dy = def.dy or 0

    self.width = PROJECTILE_SIZE
    self.height = PROJECTILE_SIZE
end


function Projectile:update(dt)
    self.x = self.x + self.dx * dt
    self.y = self.y + self.dy * dt
end


function Projectile:render()
    love.graphics.draw(gTextures['projectile'], self.x, self.y, 0, 1, 1, 0, 0)
end


function Projectile:destroy(projectiles, i)
    table.remove(projectiles, i)
end
