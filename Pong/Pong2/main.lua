--[[
    GD2022
    Pong remake

    Original Author: Colton Ogden
    cogden@cs50.harvard.edu

    Author of this version code: Emily Cordero
    cordeemi130@gmail.com

    
    Originally programmed by Atari in 1972. Features two paddles, controlled by players, with the goal of getting the ball past your opponent's edge. First to 10 points wins.
    This version is built to more closely resemble the NES than the original Pong machines or the Atari 2600 in terms of resolution, though in widescreen (16:9) so it looks nicer on modern systems.
]]

-- the push library will help us draw the game at a virtual res instead of how large the window is; the goal to make it more retro
-- https://github.com/Ulydev/push
push = require 'push'

WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

-- We are adding the dimensions for the virtual window
VIRTUAL_WIDTH = 432
VIRTUAL_HEIGHT = 243

-- Initializes the game 
function love.load()
    -- We are going to add the 'nearest neighbor' filtering to help prevent blrring of text/graphics
    love.graphics.setDefaultFilter('nearest', 'nearest')

    -- Initialize our virtual resolution which will be rendered within out actual window regardless its dimensions. 
    -- We are replacing the love.window.setMode
    --[[love.window.setMode(WINDOW_WIDTH, WINDOW_HEIGHT, {
        fullscreen = false, 
        resizable = false, 
        vsync = true
    })
end
]]
push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
    fullscreen = false, 
    resizable = false,
    vsync = true
})
end

-- We are adding keyboard handling which is called by LOVE2D at each frame and it passes in the key we press to have access.
function love.keypressed(key)
    -- Keys can be accessed by string name and we will use a function LOVE2D gives us to terminate app
    if key == 'escape' then
        love.event.quit()
    end
end

-- Used to draw anything to the screen. I will be condensing the love.graphics.print function and will use push:apply to begin the render at virtual res and add another to end the rendering
function love.draw()
        push:apply('start')

        love.graphics.printf('Hello Pong!', 0, VIRTUAL_HEIGHT / 2 - 6, VIRTUAL_WIDTH, 'center')

        push:apply('end')
end

