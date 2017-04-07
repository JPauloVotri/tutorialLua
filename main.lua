require "classes/particles"
require "classes/player"
require "classes/enemies"

love.graphics.setDefaultFilter('nearest', 'nearest')


function checkCollisions(enemies, bullets)
  for i,e in ipairs(enemies) do
    for _,b in pairs(bullets) do
      if b.y <= e.y + e.height and b.x > e.x and b.x < e.x + e.width then
        particle_systems:spawn(e.x, e.y)
        table.remove(enemies, i)
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
    enemies_controller:spawnEnemy(i*15, 0)
  end
end


function love.update(dt)
  particle_systems:update(dt)
  player.cooldown = player.cooldown - 1

  if love.keyboard.isDown("right") then
    player.x = player.x + player.speed
  elseif love.keyboard.isDown("left") then
    player.x = player.x - player.speed
  end

  if love.keyboard.isDown("space") then
    player.fire()
  end

  if love.keyboard.isDown("escape") then
    love.event.quit()
  end

  if #enemies_controller.enemies == 0 then
    -- The player win
    game_win = true
  end

  for _,e in pairs(enemies_controller.enemies) do
    if e.y >= love.graphics.getHeight()/5 then
      game_over = true
    end
    e.y = e.y + e.speed
  end

  for i,b in ipairs(player.bullets) do
    if b.y < -10 then
      table.remove(player.bullets, i)
    end
    b.y = b.y - 0.5
  end

  checkCollisions(enemies_controller.enemies, player.bullets)
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
  love.graphics.draw(player.image, player.x, player.y, 0)

  for _,e in pairs(enemies_controller.enemies) do
    love.graphics.draw(enemies_controller.image, e.x, e.y, 0)
  end

  -- Draw the bullets
  love.graphics.setColor(255, 255, 255, 255)
  for _,b in pairs(player.bullets) do
    love.graphics.rectangle("fill", b.x, b.y, 2, 2)
  end
end