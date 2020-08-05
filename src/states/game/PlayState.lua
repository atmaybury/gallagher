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

    score = 0
    self.hits = 0
    self.misses = 0
    self.accuracy = 0
    
    --[[ init player
    local def = ENTITY_DEFS['player']
    self.player = Player {
        animations = def.animations,
        x = VIRTUAL_WIDTH / 2 - SPRITE_SIZE / 2,
        y = BOTTOM_EDGE - (SPRITE_SIZE * 3),
        hp = def.hp
    }
    ]]
    
    --
    local def = ENTITY_DEFS['player-medium']
    self.player = Player {
        animations = def.animations,
        x = (VIRTUAL_WIDTH / 2) - 32,
        y = BOTTOM_EDGE - 92,
            hp = def.hp
    }
    

    --- panel to show health / score / accuracy
    self.panel = Panel(0, VIRTUAL_HEIGHT - PANEL_HEIGHT, VIRTUAL_WIDTH, PANEL_HEIGHT)
    
    self.playerHealthBar = ProgressBar {
        x = PANEL_HEIGHT / 2,
        y = VIRTUAL_HEIGHT - 3 - PANEL_HEIGHT / 2,
        width = 152,
        height = 6,
        color = {r = .74, g = .12, b = .12},
        value = self.player.currentHP,
        max = self.player.hp
    }
end


function PlayState:update(dt)

    -- scrolling stars
    self.stars1Scroll = (self.stars1Scroll + STARS1_SCROLL_SPEED * dt) % STARS1_LOOP_POINT
    self.stars2Scroll = (self.stars2Scroll + STARS2_SCROLL_SPEED * dt) % STARS2_LOOP_POINT

    -- update accuracy
    if self.hits + self.misses > 0 then
        self.accuracy = math.floor(self.hits * 100 / (self.hits + self.misses))
    else
        self.accuracy = 0
    end
   
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
        if self.player.y < BOTTOM_EDGE - SPRITE_SIZE then
            self.player.y = self.player.y + PLAYER_MOVE_SPEED * dt
        end
    end

    -- fire projectiles
    if love.keyboard.isDown('space') 
    or joystick and joystick:getGamepadAxis('triggerright') == 1 then
        self.player:fire(self.projectiles, dt, -PROJECTILE_SPEED, 'up') 
    end
    
    --[[
        UPDATES
    ]]
    self.player:update(dt)
    self.playerHealthBar:setValue(self.player.currentHP)
    
    for i, enemy in pairs(self.enemies) do
        enemy:update(self.projectiles, dt)
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
        if projectile.y < 0 then
            projectile:destroy(self.projectiles, j)
            self.misses = self.misses + 1
        elseif projectile.y > BOTTOM_EDGE then
            projectile:destroy(self.projectiles, j)
        end

        -- projectile/player
        if self.player:collides(projectile) then
            self.player:hit()
            projectile:destroy(self.projectiles, j)
            gSounds['start']:play()
        end
        
        -- projectile/enemy
        for k, enemy in pairs(self.enemies) do
            if enemy:collides(projectile) then
                -- dy will be negative if fired by player
                if projectile.dy < 0 then 
                    self.hits = self.hits + 1
                end
                enemy:hit(self.enemies, k)
                projectile:destroy(self.projectiles, j)
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
            gSounds['start']:stop()
            gSounds['start']:play()
        end
    end
end


function PlayState:render()

    -- background color
    love.graphics.setColor(unpack(GREEN1))
    love.graphics.rectangle('fill', 0, 0, VIRTUAL_WIDTH, VIRTUAL_HEIGHT)

    -- scrolling stars
    love.graphics.setColor(unpack(GREEN4))
    love.graphics.draw(gTextures['stars1'], 0, -VIRTUAL_HEIGHT + self.stars1Scroll) 
    love.graphics.draw(gTextures['stars2'], 0, -VIRTUAL_HEIGHT + self.stars2Scroll) 
    love.graphics.setColor(1, 1, 1, 1)

    self.player:render()

    -- render enemies
    for i, enemy in pairs(self.enemies) do
        enemy:render()
    end

    -- render projectiles
    for i, projectile in pairs(self.projectiles) do
        projectile:render()
    end

    -- render panel with health bar / score / accuracy
    self.panel:render()
    self.playerHealthBar:render()
    love.graphics.setFont(gFonts['pixel-operator'])
    love.graphics.setColor(unpack(GREEN4))
    love.graphics.print("Score: " .. tostring(score), VIRTUAL_WIDTH / 2, BOTTOM_EDGE + 5)
    love.graphics.print("Accuracy: " .. tostring(self.accuracy), VIRTUAL_WIDTH / 2, VIRTUAL_HEIGHT - PANEL_HEIGHT / 2)
    love.graphics.setColor(1, 1, 1, 1)
end
