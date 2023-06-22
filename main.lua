
local player = { x = 100, y = 100, width = 50, height = 50, speed = 200 }
local target = { x = 500, y = 300, width = 50, height = 50 }
local obstacles = {}
local objects = {}
local gameOver = false

function love.load()
    love.window.setTitle("Obstacle Game")
    math.randomseed(os.time())
    
    -- Create obstacles
    for i = 1, 5 do
        local obstacle = { x = math.random(0, 600), y = math.random(0, 400), width = 50, height = 50, speed = math.random(50, 150) }
        table.insert(obstacles, obstacle)
    end
    
    -- Create other objects
    for i = 1, 3 do
        local object = { x = math.random(0, 600), y = math.random(0, 400), width = 30, height = 30 }
        table.insert(objects, object)
    end
end

function love.update(dt)
    if not gameOver then
        -- Handle player movement
        if love.keyboard.isDown("left") then
            player.x = player.x - player.speed * dt
        elseif love.keyboard.isDown("right") then
            player.x = player.x + player.speed * dt
        end
    
        if love.keyboard.isDown("up") then
            player.y = player.y - player.speed * dt
        elseif love.keyboard.isDown("down") then
            player.y = player.y + player.speed * dt
        end
    
        -- Update obstacle positions
        for _, obstacle in ipairs(obstacles) do
            obstacle.x = obstacle.x + obstacle.speed * dt
            
            -- Check for collision with player
            if checkCollision(player, obstacle) then
                gameOver = true
            end
            
            -- Reset obstacle position when it goes off-screen
            if obstacle.x > love.graphics.getWidth() then
                obstacle.x = -obstacle.width
                obstacle.y = math.random(0, love.graphics.getHeight() - obstacle.height)
            end
        end
    
        -- Check for collision with objects
        for _, object in ipairs(objects) do
            if checkCollision(player, object) then
                gameOver = true
            end
        end
    
        -- Check if player reached the target
        if checkCollision(player, target) then
            gameOver = true
            print("You Win!")
        end
    else
        -- Restart the game
        if love.keyboard.isDown("r") then
            resetGame()
        end
    end
end

function love.draw()
    -- Draw player
    love.graphics.rectangle("fill", player.x, player.y, player.width, player.height)
    
    -- Draw target
    love.graphics.rectangle("line", target.x, target.y, target.width, target.height)
    
    -- Draw obstacles
    for _, obstacle in ipairs(obstacles) do
        love.graphics.rectangle("fill", obstacle.x, obstacle.y, obstacle.width, obstacle.height)
    end
    
    -- Draw objects
    for _, object in ipairs(objects) do
        love.graphics.rectangle("fill", object.x, object.y, object.width, object.height)
    end
    
    -- Draw game over message
    if gameOver then
        love.graphics.print("Game Over! Press 'R' to restart.", 200, 200)
    end
end

function checkCollision(a, b)
    -- Check if two rectangles overlap
    return a.x < b.x + b.width and
           a.x + a.width > b.x and
           a.y < b.y + b.height and
           a.y + a.height > b.y
end

function resetGame()
    player.x = 100
    player.y = 100
    gameOver = false
end

local player = { x = 100, y = 100, width = 50, height = 50, speed = 200 }
local target = { x = 500, y = 300, width = 50, height = 50 }
local obstacles = {}
local objects = {}
local gameOver = false
local lives = 3

function love.load()
    love.window.setTitle("Obstacle Game")
    math.randomseed(os.time())
    
    -- Create obstacles
    for i = 1, 5 do
        local obstacle = { x = math.random(0, 600), y = math.random(0, 400), width = 50, height = 50, speed = math.random(50, 150) }
        table.insert(obstacles, obstacle)
    end
    
    -- Create other objects
    for i = 1, 3 do
        local object = { x = math.random(0, 600), y = math.random(0, 400), width = 30, height = 30 }
        table.insert(objects, object)
    end
end

function love.update(dt)
    if not gameOver then
        -- Handle player movement
        if love.keyboard.isDown("left") then
            player.x = player.x - player.speed * dt
        elseif love.keyboard.isDown("right") then
            player.x = player.x + player.speed * dt
        end
    
        if love.keyboard.isDown("up") then
            player.y = player.y - player.speed * dt
        elseif love.keyboard.isDown("down") then
            player.y = player.y + player.speed * dt
        end
    
        -- Update obstacle positions
        for _, obstacle in ipairs(obstacles) do
            obstacle.x = obstacle.x + obstacle.speed * dt
            
            -- Check for collision with player
            if checkCollision(player, obstacle) then
                lives = lives - 1
                
                if lives <= 0 then
                    gameOver = true
                else
                    resetPlayerPosition()
                end
            end
            
            -- Reset obstacle position when it goes off-screen
            if obstacle.x > love.graphics.getWidth() then
                obstacle.x = -obstacle.width
                obstacle.y = math.random(0, love.graphics.getHeight() - obstacle.height)
            end
        end
    
        -- Check for collision with objects
        for _, object in ipairs(objects) do
            if checkCollision(player, object) then
                lives = lives - 1
                
                if lives <= 0 then
                    gameOver = true
                else
                    resetPlayerPosition()
                end
            end
        end
    
        -- Check if player reached the target
        if checkCollision(player, target) then
            gameOver = true
            print("You Win!")
        end
    else
        -- Restart the game
        if love.keyboard.isDown("r") then
            resetGame()
        end
    end
end

function love.draw()
    -- Draw player
    love.graphics.rectangle("fill", player.x, player.y, player.width, player.height)
    
    -- Draw target
    love.graphics.rectangle("line", target.x, target.y, target.width, target.height)
    
    -- Draw obstacles
    for _, obstacle in ipairs(obstacles) do
        love.graphics.rectangle("fill", obstacle.x, obstacle.y, obstacle.width, obstacle.height)
    end
    
    -- Draw objects
    for _, object in ipairs(objects) do
        love.graphics.rectangle("fill", object.x, object.y, object.width, object.height)
    end
    
    -- Draw lives
    love.graphics.print("Lives: " .. lives, 10, 10)
    
    -- Draw game over message
    if gameOver then
        love.graphics.print("Game Over! Press 'R' to restart.", 200, 200)
    end
end

function checkCollision(a, b)
    -- Check if two rectangles overlap
    return a.x < b.x + b.width and
           a.x + a.width > b.x and
           a.y < b.y + b.height and
           a.y + a.height > b.y
end

function resetGame()
    resetPlayerPosition()
    lives = 3
    gameOver = false
end

function resetPlayerPosition()
    player.x = 100
    player.y = 100
end