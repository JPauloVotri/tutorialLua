require "scripts/particles"
local player = require "scripts/player"
local enemy  = require("scripts/enemies")

enemies = {}

player = player:new(0, 110, 10, 10, 100)

love.graphics.setDefaultFilter('nearest', 'nearest')


function checkCollisions(enemies, bullets)
  for i,e in ipairs(enemies) do
    for j,b in pairs(bullets) do
      if e.body:collidesWith(b.body) then
        table.remove(enemies, i)
        table.remove(player.bullets, j)
        particle_systems:spawn(e.x, e.y)
      end
    end
  end
end


function love.load()
  local music = love.audio.newSource("audio/music.mp3")
  music:setLooping(true)
  love.audio.play(music)

  game_over = false
  game_win  = false
  
  background_image = love.graphics.newImage('images/background.png')

  for i=0, 10 do
    table.insert(enemies, enemy:new(i*15, 0, 10, 10, 15))
  end
end


function love.update(dt)
  player:update(dt)
  for _,e in pairs(enemies) do
    e:update(dt)
  end
  particle_systems:update(dt)

  if love.keyboard.isDown("escape") then
    love.event.quit()
  end

  if #enemies == 0 then
    -- The player win
    game_win = true
  end

  checkCollisions(enemies, player.bullets)
end


function love.draw()
  love.graphics.scale(5)
  love.graphics.draw(background_image)
  if game_over then
    love.graphics.print("Game Over!")
    return
  elseif game_win then
    love.graphics.print("You Won!")
  end
  particle_systems:draw()
  love.graphics.setColor(255, 255, 255, 255)

  -- Draw the player
  player:draw()

  for _,e in pairs(enemies) do
    e:draw()
  end
end