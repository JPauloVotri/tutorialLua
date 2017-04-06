love.graphics.setDefaultFilter('nearest', 'nearest')

enemy = {}
enemies_controller = {}
enemies_controller.enemies = {}
enemies_controller.image = love.graphics.newImage("enemy.png")

function checkCollisions(enemies, bullets)
  for i,e in ipairs(enemies) do
    for _,b in pairs(bullets) do
      if b.y <= e.y + e.height and b.x > e.x and b.x < e.x + e.width then
        table.remove(enemies, i)
      end
    end
  end
end

function love.load()
  player          = {}
  player.x        = 0
  player.y        = 110
  player.bullets  = {}
  player.cooldown = 40
  player.speed    = 0.25
  player.image    = love.graphics.newImage("player.png")
  player.fire_sound = love.audio.newSource('Laser_Shoot2.wav')
  player.fire     = function()
    if player.cooldown <= 0 then
      player.cooldown = 80
      love.audio.play(player.fire_sound)
      bullet   = {}
      bullet.x = player.x + 4
      bullet.y = player.y + 2
      table.insert(player.bullets, bullet)
    end
  end

  enemies_controller:spawnEnemy(2, 0)
  enemies_controller:spawnEnemy(32, 0)
end


function enemies_controller:spawnEnemy(x, y)
  enemy          = {}
  enemy.x        = x
  enemy.y        = y
  enemy.width    = 10
  enemy.height   = 10
  enemy.bullets  = {}
  enemy.cooldown = 40
  enemy.speed    = 2
  table.insert(self.enemies, enemy)
end


function enemy:fire()
  if self.cooldown <= 0 then
    self.cooldown = 40
    bullet   = {}
    bullet.x = self.x + 7
    bullet.y = self.y
    table.insert(self.bullets, bullet)
  end
end


function love.update(dt)
  player.cooldown = player.cooldown - 1

  if love.keyboard.isDown("right") then
    player.x = player.x + player.speed
  elseif love.keyboard.isDown("left") then
    player.x = player.x - player.speed
  end

  if love.keyboard.isDown("space") then
    player.fire()
  end

  for _,e in pairs(enemies_controller.enemies) do
    e.y = e.y + 0.1
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
  love.graphics.setColor(255, 255, 255, 255)

  -- Draw the player
  love.graphics.draw(player.image, player.x, player.y, 0)

  for _,e in pairs(enemies_controller.enemies) do
    love.graphics.rectangle("fill", e.x, e.y, e.width, e.height)
    love.graphics.draw(enemies_controller.image, e.x, e.y, 0)
  end

  -- Draw the bullets
  love.graphics.setColor(255, 255, 255, 255)
  for _,b in pairs(player.bullets) do
    love.graphics.rectangle("fill", b.x, b.y, 2, 2)
  end
end