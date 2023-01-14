--[[
    GD2022
    Pong remake

    Original Author: Colton Ogden
    cogden@cs50.harvard.edu

    Author of this version code: Emily Cordero
    cordeemi130@gmail.com

    
    Originally programmed by Atari in 1972. Features two
    paddles, controlled by players, with the goal of getting
    the ball past your opponent's edge. First to 10 points wins.

    This version is built to more closely resemble the NES than
    the original Pong machines or the Atari 2600 in terms of
    resolution, though in widescreen (16:9) so it looks nicer on 
    modern systems.
]]

WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

-- Initializes the game 
function love.load()
    love.window.setMode(WINDOW_WIDTH, WINDOW_HEIGHT, {
        fullscreen = false, 
        resizable = false, 
        vsync = true
    })
end

-- Used to draw anything to the screen
function love.draw()
    love.graphics.printf(
        'Hello Pong!',          -- Renders 'Hello Pong' to screen
        0,                      -- Starting X at 0 since it will center it
        WINDOW_HEIGHT / 2 - 6,  -- Starting Y halfway down the screen
        WINDOW_WIDTH,           -- Number of picels to center within screen 
        'center')               -- 'center', 'left', or 'right'
end


