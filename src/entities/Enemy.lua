--[[
    FINAL PROJECT
    2020

    -- entities/Enemy -- 
]]


Enemy = Class{__includes = Entity}

function Enemy:init(def)
    Entity.init(self, def)

    -- delay between chances to fire
    self.firingDelay = 1
    self.firingTimer = 0
end


function Enemy:update(projectiles, dt)

    Entity.update(self, dt)

    -- chance to fire every second
    self.firingTimer = self.firingTimer + dt
    if self.firingTimer >= self.firingDelay then
        self.firingTimer = (self.firingTimer + dt) % self.firingDelay
        if math.random(3) == 1 then
            self:fire(projectiles, dt, PROJECTILE_SPEED, 'down')
        end
    else
        self.firingTimer = self.firingTimer + dt
    end
end


function Enemy:render()
    Entity.render(self)
end


function Enemy:hit(entities, i)
    self:takeDamage()
    if self.hp == 0 then
        -- give points for destroyed enemies, as long as they are not destroyed on screen exit
        if self.y < VIRTUAL_HEIGHT then
            score = score + 1
        end
        self:destroy(entities, i)
    end
end
