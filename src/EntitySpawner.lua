--[[
    FINAL PROJECT
    2020

    -- Entity Spawner --
]]

EntitySpawner = Class{}

function EntitySpawner:spawn(enemies)
    -- init up to five enemies
    for i = 1, math.random(3) do
        --local def = ENTITY_DEFS['enemy-basic']
        local def = ENTITY_DEFS['enemy-medium']
        table.insert(enemies, Enemy {
            animations = def.animations,
            x = math.random(SPRITE_SIZE, VIRTUAL_WIDTH - SPRITE_SIZE),
            y = ENEMY_SPAWN_Y,
            dy = ENEMY_SPEED,
            hp = def.hp
        })
    end
end
