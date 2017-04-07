enemy                      = {}
enemies_controller         = {}
enemies_controller.enemies = {}
enemies_controller.image   = love.graphics.newImage("images/enemy.png")


function enemies_controller:spawnEnemy(x, y)
  enemy          = {}
  enemy.x        = x
  enemy.y        = y
  enemy.width    = 10
  enemy.height   = 10
  enemy.bullets  = {}
  enemy.cooldown = 40
  enemy.speed    = 0.01
  table.insert(self.enemies, enemy)
end


function enemy:fire()
  if self.cooldown <= 0 then
    self.cooldown = 40
    bullet        = {}
    bullet.x      = self.x + 7
    bullet.y      = self.y
    table.insert(self.bullets, bullet)
  end
end