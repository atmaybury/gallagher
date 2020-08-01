--[[
    FINAL PROJECT
    2020

    -- Entity defs --
]]

ENTITY_DEFS = {

    -- player entity
    ['player'] = {
        --TODO: Entity speed
        animations = {
            ['straight'] = {
                texture = 'player',
                frames = {2}
            },
            ['left'] = {
                texture = 'player',
                frames = {1}
            },
            ['right'] = {
                texture = 'player',
                frames = {3}
            }
        }
    },

    -- enemy entities
    ['enemy-basic'] = {
        --TODO: Entity speed
         animations = {
            ['straight'] = {
                texture = 'enemy-basic',
                frames = {2}
            },
            ['left'] = {
                texture = 'enemy-basic',
                frames = {1}
            },
            ['right'] = {
                texture = 'enemy-basic',
                frames = {3}
            }
        }
    }
}
