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

    self.animations = self:createAnimations(def.animations)
    self.hp = def.health or 10

    self:changeAnimation('straight')

    local anim = self.currentAnimation

    self.psystem = love.graphics.newParticleSystem(gTextures['particle'], 64)
    self.psystem:setParticleLifetime(1, 3)
    self.psystem:setLinearAcceleration(-15, 0 , 15, 80)
    self.psystem:setEmissionArea('normal', 10, 10)
end


function Entity:update(dt)
    if self.currentAnimation then self.currentAnimation:update(dt) end
    self.psystem:update(dt)

    self.x = self.x + self.dx * dt
    self.y = self.y + self.dy * dt

    --[[
    if self.dx < 0 then
        self:changeAnimation('left')
    elseif self.dx > 0 then
        self:changeAnimation('right')
    end
    ]]
end


function Entity:render()
    -- render sprite
    local anim = self.currentAnimation
    love.graphics.draw(gTextures[anim.texture], gFrames[anim.texture][anim:getCurrentFrame()], self.x, self.y)
    -- render particle effects
    love.graphics.draw(self.psystem, self.x, self.y)
end


function Entity:collides(target) 
    -- AABB collision detection
    if self.x > target.x + target.width or target.x > self.x + self.width then
        return false
    elseif self.y > target.y + target.height or target.y > self.y + self.height then
        return false
    else
        return true
    end
end


function Entity:takeDamage()
    self.hp = self.hp - 1
    -- particle effects for damage
    self.psystem:setColors(1, 1, 1, 1, .3, .5, .2, 0)
    self.psystem:emit(64)
end


-- remove self from the state's list of entities
function Entity:destroy(entities, i)
    table.remove(entities, i)
end


-- fire projectile
function Entity:fire(projectiles)
    table.insert(projectiles, Projectile {
        x = self.x,
        y = self.y - SPRITE_SIZE,
        dy = -PROJECTILE_SPEED
    })
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
