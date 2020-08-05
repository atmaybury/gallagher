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

    -- particle effect system
    self.psystem = love.graphics.newParticleSystem(gTextures['particle'], 64)
    self.psystem:setParticleLifetime(1, 3)
    self.psystem:setLinearAcceleration(-15, -WORLD_SPEED, 15, 0)
    self.psystem:setEmissionArea('normal', 10, 10)
end


function Enemy:update(projectiles, dt)

    Entity.update(self, dt)
    self.psystem:update(dt)

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
    -- render particle effects
    love.graphics.draw(self.psystem, self.x, self.y)
    Entity.render(self)
end


function Enemy:hit(entities, i)
    self:takeDamage()

    -- if destroyed
    if self.currentHP == 0 then
        gSounds['enemy-destroy']:stop()
        gSounds['enemy-destroy']:play()
        -- give points for destroyed enemies, as long as they are not destroyed on screen exit
        if self.y < BOTTOM_EDGE then
            score = score + 1
        end
        self:destroy(entities, i)

    else
        -- particle effects for damage
        self.psystem:setColors(GREEN3, GREEN4)
        self.psystem:emit(64)

        gSounds['enemy-hit']:stop()
        gSounds['enemy-hit']:play()
    end
end
