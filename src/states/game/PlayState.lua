--[[
    FINAL PROJECT
    2020

    -- states/game/PlayState --
--]]

PlayState = Class{__includes = BaseState}

function PlayState:init()

    -- scrolling stars
    self.stars1Scroll = 0
    self.stars2Scroll = 0

    self.entitySpawner = EntitySpawner{}
    self.enemies = {}
    self.projectiles = {}
    
    -- init player
    self.player = Player {
        animations = ENTITY_DEFS['player'].animations,
        x = VIRTUAL_WIDTH / 2 - SPRITE_SIZE / 2,
        y = VIRTUAL_HEIGHT - (SPRITE_SIZE * 3),
        hp = 5
    }

    self.playerHealthBar = ProgressBar {
        x = 50,
        y = VIRTUAL_HEIGHT - 6 - 50,
        width = 152,
        height = 6,
        color = {r = .74, g = .12, b = .12},
        value = self.player.hp,
        max = 10
    }
end


function PlayState:update(dt)

    -- scrolling stars
    self.stars1Scroll = (self.stars1Scroll + STARS1_SCROLL_SPEED * dt) % STARS1_LOOP_POINT
    self.stars2Scroll = (self.stars2Scroll + STARS2_SCROLL_SPEED * dt) % STARS2_LOOP_POINT
   
    --[[
        INPUT CHECKS
    ]]
    -- direction inputs    
    if love.keyboard.isDown('left')
    or joystick and joystick:getGamepadAxis('leftx') < -0.5 then
        if self.player.x > 0 then
            self.player.x = self.player.x - PLAYER_MOVE_SPEED * dt
        end
    end
    if love.keyboard.isDown('right')
    or joystick and joystick:getGamepadAxis('leftx') > 0.5 then
        if self.player.x < VIRTUAL_WIDTH - SPRITE_SIZE then
            self.player.x = self.player.x + PLAYER_MOVE_SPEED * dt
        end
    end
    if love.keyboard.isDown('up') 
    or joystick and joystick:getGamepadAxis('lefty') < -0.5 then
        if self.player.y > 0 then
            self.player.y = self.player.y - PLAYER_MOVE_SPEED * dt
        end
    end
    if love.keyboard.isDown('down')
    or joystick and joystick:getGamepadAxis('lefty') > 0.5 then
        if self.player.y < VIRTUAL_HEIGHT - SPRITE_SIZE then
            self.player.y = self.player.y + PLAYER_MOVE_SPEED * dt
        end
    end

    -- fire projectiles
    if love.keyboard.isDown('space') 
    or joystick and joystick:getGamepadAxis('triggerright') == 1 then
        self.player:fire(self.projectiles, dt) 
    end
    
    --[[
        UPDATES
    ]]
    self.player:update(dt)
    self.playerHealthBar:setValue(self.player.hp)
    
    for i, enemy in pairs(self.enemies) do
        enemy:update(dt)
    end
    
    for i, projectile in pairs(self.projectiles) do
        projectile:update(dt)
    end

    -- spawn new enemies
    if next(self.enemies) == nil then
        self.entitySpawner:spawn(self.enemies)
    end

    --[[
        COLLISIONS
    ]]
    -- projectiles
    for j, projectile in pairs(self.projectiles) do

        -- check if in bounds
        if projectile.y < 0 or projectile.y > VIRTUAL_HEIGHT then
            projectile:destroy(self.projectiles, j)
        end

        -- projectile/player
        if self.player:collides(projectile) then
            self.player:hit()
            projectile:destroy(self.projectiles, j)
            gSounds['start']:play()
        end
        
        -- enemy/projectile
        for k, enemy in pairs(self.enemies) do
            if enemy:collides(projectile) then
                enemy:hit(self.enemies, k)
                projectile:destroy(self.projectiles, j)
                gSounds['start']:stop()
                gSounds['start']:play()
            end
        end
    end

    -- enemies
    for k, enemy in pairs(self.enemies) do
        -- check enemy is in bounds
        if enemy.y > VIRTUAL_HEIGHT then
            enemy:destroy(self.enemies, k)
        -- player/enemy
        elseif enemy:collides(self.player) then
            enemy:hit(self.enemies, k)
            self.player:hit()
            print(self.player.hp)
            gSounds['start']:stop()
            gSounds['start']:play()
        end
    end

    -- spawn new enemies
    if next(self.enemies) == nil then
        self.entitySpawner:spawn(self.enemies)
    end
end


function PlayState:render()

    -- scrolling stars
    love.graphics.draw(gTextures['stars1'], 0, -VIRTUAL_HEIGHT + self.stars1Scroll) 
    love.graphics.draw(gTextures['stars2'], 0, -VIRTUAL_HEIGHT + self.stars2Scroll) 

    self.player:render()
    self.playerHealthBar:render()

    -- render enemies
    for i, enemy in pairs(self.enemies) do
        enemy:render()
    end

    -- render projectiles
    for i, projectile in pairs(self.projectiles) do
        projectile:render()
    end
end
