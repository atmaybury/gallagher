--[[
    FINAL PROJECT
    2020

    -- entities/Entity --
]]

Entity = Class{}

function Entity:init(def)
    self.x = def.x
    self.y = def.y

    self.dx = def.dx or 0
    self.dy = def.dy or 0

    self.width = SPRITE_SIZE
    self.height = SPRITE_SIZE

    -- animations
    self.animations = self:createAnimations(def.animations)
    self:changeAnimation('straight')
    local anim = self.currentAnimation

    -- max health and current health
    self.hp = def.hp
    self.currentHP = self.hp

    self.invulnerable = false
    self.invulnerableTimer = 0

    self.flashing = false
    self.flashTimer = 0

    -- time to wait between firing
    self.cooldown = 1 / FIRING_RATE
    -- starts at cooldown value so can always shoot immediately
    self.cooldownTimer = self.cooldown
end


function Entity:update(dt)
    if self.currentAnimation then self.currentAnimation:update(dt) end

    self.x = self.x + self.dx * dt
    self.y = self.y + self.dy * dt

    -- flash when damaged
    if self.flashing then
        self.flashTimer = self.flashTimer + dt
        if self.flashTimer > FLASH_DURATION then
            self.flashing = false
            self.flashTimer = 0
        end
    end

    -- brief invulnerability for conatct between entities
    if self.invulnerable then
        self.invulnerableTimer = self.invulnerableTimer + dt

        if self.invulnerableTimer > INVULNERABLE_DURATION then
            self.invulnerable = false
            self.invulnerableTimer = 0
        end
    end
end


function Entity:render()
    -- draw sprite slightly transparent while invulnerable
    if self.flashing then
        love.graphics.setColor(1, 1, 1, .25)
    -- set color back to light green
    else love.graphics.setColor(unpack(GREEN4)) end

    -- render sprite
    local anim = self.currentAnimation
    love.graphics.draw(gTextures[anim.texture], gFrames[anim.texture][anim:getCurrentFrame()], self.x, self.y)
end


function Entity:collides(target) 
    -- AABB collision detection
    if self.x > target.x + target.width or target.x > self.x + self.width then
        return false
    elseif self.y > target.y + target.height or target.y > self.y + self.height then
        return false
    else
        self.flashing = true
        return true
    end
end


function Entity:takeDamage()
    self.currentHP = self.currentHP - 1
end


-- remove self from the state's list of entities
function Entity:destroy(entities, i)
    table.remove(entities, i)
end


-- fire projectile
function Entity:fire(projectiles, dt, dy, dir)
    -- set projectile.y based on whether its from player(up) or enemy(down)
    local tempY
    if dir == 'up' then
        tempY = self.y - SPRITE_SIZE
    else
        tempY = self.y + SPRITE_SIZE
    end
    -- fire projectile
    if self.cooldownTimer >= self.cooldown then
        table.insert(projectiles, Projectile {
            x = self.x + SPRITE_SIZE / 2,
            y = tempY,
            dy = dy
        })
        self.cooldownTimer = (self.cooldownTimer + dt) % self.cooldown
    else
        self.cooldownTimer = self.cooldownTimer + dt
    end
end


-- create Animation for each animation def for this entity
function Entity:createAnimations(animations)
    local animationsReturned = {}

    for k, animationsDef in pairs(animations) do
        animationsReturned[k] = Animation {
            texture = animationsDef.texture,
            frames = animationsDef.frames,
            interval = animationsDef.interval
        }
    end

    return animationsReturned
end


-- set current animation from array returned by createAnimations
function Entity:changeAnimation(name)
    self.currentAnimation = self.animations[name]
end
