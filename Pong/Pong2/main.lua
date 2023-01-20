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

VIRTUAL_WIDTH = 432
VIRTUAL_HEIGHT = 243

-- We are declaring the speed the paddles will move at. In the update it will be multiplied by dt.
PADDLE_SPEED = 200

-- Initializes the game 
function love.load()
    
    love.graphics.setDefaultFilter('nearest', 'nearest')
    -- We are going to "seed" the RNG that way the calls to random are always random. We will use the current time to make sure it will vary every time at start
    math.randomseed(os.time())

    -- We are adding the retro font for any text. We reference the font file and add the size
    smallFont = love.graphics.newFont('font.ttf', 8)
    scoreFont = love.graphics.newFont('font.ttf', 32)

    -- Set the active LOVE2D font to the smallFont
    love.graphics.setFont(smallFont)

push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
    fullscreen = false, 
    resizable = false,
    vsync = true
})

-- Initialize score variables
player1Score = 0
player2Score = 0

-- We are putting the paddle positions on the y axis that way they can only move up/down
player1Y = 30
player2Y = VIRTUAL_HEIGHT - 50

-- We are declaring the velocity and position variables for when the ball is in the play state
ballX = VIRTUAL_WIDTH / 2 -2
ballY = VIRTUAL_HEIGHT / 2 -2

-- math.random returns a random value between the 2 numbers that we want
ballDX = math.random(2) == 1 and 100 or -100
ballDY = math.random(-50,50)

-- The game state variable is used to help transition between different parts of the game (beginning, menus, main game, etc.)The goal is to use this to help determine behavior during rendering and updating. 
gameState = 'start'
end

-- Runs every frame with 'dt' passed in 
-- for the player 1 movement We want to add negative paddle speed to current Y scaled by deltaTime, we are setting bounds on the screen and math.max returns the greater of the 2 values and 0 and player Y makes sure we don't go over. Then when s is pressed we want to add positive paddle speed. 
function love.update(dt)
    -- Player 1 movement
    if love.keyboard.isDown('w') then 
        player1Y = player1Y + -PADDLE_SPEED * dt
    elseif love.keyboard.isDown('s') then
        player1Y = player1Y + PADDLE_SPEED * dt
    end

    -- Player 2 movement 
    if love.keyboard.isDown('up') then 
        player2Y = player2Y + -PADDLE_SPEED * dt
    elseif love.keyboard.isDown('down') then
        player2Y = player2Y + PADDLE_SPEED * dt
    end
end

-- Keyboard handling which is called by LOVE2D at each frame and it passes in the key we press to have access.
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

        -- Swapping the font before printing
        love.graphics.setFont(smallFont)
        love.graphics.printf('Hello Pong!', 0, 20, VIRTUAL_WIDTH, 'center')

        -- Draw score on the right and left center of the screen
        love.graphics.setFont(scoreFont)
        love.graphics.print(tostring(player1Score), VIRTUAL_WIDTH / 2 - 50, VIRTUAL_HEIGHT / 3)
        love.graphics.print(tostring(player2Score), VIRTUAL_WIDTH / 2 + 30, VIRTUAL_HEIGHT / 3)

        -- Rendering the first paddle to be on the left side of the screen by using the players Y variable
        love.graphics.rectangle('fill', 10, player1Y,5,20)

        -- Rendering the second paddle to be on the right side of the screen 
        love.graphics.rectangle('fill', VIRTUAL_WIDTH - 10, player2Y, 5, 20)

        -- Rendering the ball at the cnenter of the screen 
        love.graphics.rectangle('fill', VIRTUAL_WIDTH / 2 - 2, VIRTUAL_HEIGHT / 2 -2, 4, 4)
        push:apply('end')
end

