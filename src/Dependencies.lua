--[[
    FINAL PROJECT
    2020

    -- Dependencies --
]]

-- LIBRARIES --
Class = require 'lib/class'
Event = require 'lib/knife.event'
push = require 'lib/push'
Timer = require 'lib/knife.timer'

require 'src/Animation'
require 'src/constants'
require 'src/Util'
require 'src/gui/ProgressBar'
require 'src/gui/Panel'

-- GAME STATES -- 
require 'src/StateMachine'
require 'src/states/StateStack'
require 'src/states/BaseState'

require 'src/states/game/StartState'
require 'src/states/game/PlayState'

-- ENTITIES -- 
require 'src/EntitySpawner'
require 'src/entities/Entity'
require 'src/entities/Player'
require 'src/entities/Enemy'
require 'src/entities/entity_defs'

require 'src/Projectile'

gTextures = {
    ['stars1'] = love.graphics.newImage('graphics/backgrounds/stars1-576x2048.png'),
    ['stars2'] = love.graphics.newImage('graphics/backgrounds/stars2-576x2048.png'),

    ['player'] = love.graphics.newImage('graphics/sprites/player-48x16.png'),
    ['player-medium'] = love.graphics.newImage('graphics/sprites/player-32x96.png'),
    ['player-large'] = love.graphics.newImage('graphics/sprites/player-64x192.png'),
    ['enemy-basic'] = love.graphics.newImage('graphics/sprites/enemy-basic-48x16.png'),
    ['enemy-medium'] = love.graphics.newImage('graphics/sprites/enemy-32x96.png'),
    ['enemy-large'] = love.graphics.newImage('graphics/sprites/enemy-64x192.png'),

    ['projectile'] = love.graphics.newImage('graphics/projectile-5x5.png'),
    ['particle'] = love.graphics.newImage('graphics/particles/particle.png')
}

gFrames = {
    ['player'] = GenerateQuads(gTextures['player'], 16, 16),
    ['player-medium'] = GenerateQuads(gTextures['player-medium'], 32, 32),
    ['player-large'] = GenerateQuads(gTextures['player-large'], 64, 64),
    ['enemy-basic'] = GenerateQuads(gTextures['enemy-basic'], 16, 16),
    ['enemy-medium'] = GenerateQuads(gTextures['enemy-medium'], 32, 32),
    ['enemy-large'] = GenerateQuads(gTextures['enemy-large'], 64, 64)
}

gFonts = {
    ['pixel-operator'] = love.graphics.newFont('fonts/PixelOperator.ttf', 16),
    ['pixel-operator-title'] = love.graphics.newFont('fonts/PixelOperator.ttf', 32)
}

gSounds = {
    ['music-woo'] = love.audio.newSource('sounds/music/Woo.mp3', 'stream'),
    ['start'] = love.audio.newSource('sounds/start.wav', 'static'),
    ['enemy-hit'] = love.audio.newSource('sounds/enemy-hit.wav', 'static'),
    ['enemy-destroy'] = love.audio.newSource('sounds/enemy-destroy.flac', 'static'),
    ['player-destroy'] = love.audio.newSource('sounds/player-destroy.mp3', 'static')
}
