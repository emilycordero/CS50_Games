--[[
    GD2022
    Pong remake

    Original Author: Colton Ogden
    cogden@cs50.harvard.edu

    Author of this version code: Emily Cordero
    cordeemi130@gmail.com

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

    -- We are adding the retro font for any text. We reference the font file and add the size
    smallFont = love.graphics.newFont('font.ttf', 8)





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
-- We will be adding a new feature to clear the screen with a specific color to make it similar to some versions of the original pong
-- We also will drawing the text towards the top as we add the paddles and the ball to the screen
function love.draw()
        push:apply('start')

        love.graphics.clear(40/255, 25/255, 52/255, 255/255)

        love.graphics.printf('Hello Pong!', 0, 20, VIRTUAL_WIDTH, 'center')

        -- Rendering the first paddle to be on the left side of the screen
        love.graphics.rectangle('fill', 10,30,5,20)

        -- Rendering the second paddle to be on the right side of the screen 
        love.graphics.rectangle('fill', VIRTUAL_WIDTH - 10, VIRTUAL_HEIGHT -50, 5, 20)

        -- Rendering the ball at the cnenter of the screen 
        love.graphics.rectangle('fill', VIRTUAL_WIDTH / 2 - 2, VIRTUAL_HEIGHT / 2 -2, 4, 4)
        push:apply('end')
end

