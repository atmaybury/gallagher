--[[
    FINAL PROJECT
    2020

    -- Entity Spawner --
]]

EntitySpawner = Class{}

function EntitySpawner:spawn(enemies)
    -- init enemy
    table.insert(enemies, Enemy {
        animations = ENTITY_DEFS['enemy-basic'].animations,
        x = math.random(SPRITE_SIZE, VIRTUAL_WIDTH - SPRITE_SIZE),
        y = ENEMY_SPAWN_Y,
        dy = ENEMY_SPEED,
        health = 3
    })
end
