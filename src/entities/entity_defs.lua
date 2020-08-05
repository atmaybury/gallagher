--[[
    FINAL PROJECT
    2020

    -- Entity defs --
]]

ENTITY_DEFS = {

    -- player entity
    ['player'] = {
        --TODO: Entity speed
        hp = 5,
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
        hp = 3,
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
    },
    
    -- player-large
    ['player-large'] = {
        hp = 3,
        animations = {
            ['straight'] = {
                texture = 'player-large',
                frames = {1, 2, 3},
                interval = .15,
                looping = true
            }
        }
    },

    -- enemy-large
    ['enemy-large'] = {
        hp = 3,
        animations = {
            ['straight'] = {
                texture = 'enemy-large',
                frames = {1, 2, 3},
                interval = .15,
                looping = true
            }
        }
    },

    -- player-medium
    ['player-medium'] = {
        hp = 3,
        animations = {
            ['straight'] = {
                texture = 'player-medium',
                frames = {1, 2, 3},
                interval = .15,
                looping = true
            }
        }
    },

    -- enemy-medium
    ['enemy-medium'] = {
        hp = 3,
        animations = {
            ['straight'] = {
                texture = 'enemy-medium',
                frames = {1, 2, 3},
                interval = .15,
                looping = true
            }
        }
    }
}
