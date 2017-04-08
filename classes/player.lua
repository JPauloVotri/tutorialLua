local player      = {}
player.cooldown   = 0
player.bullets    = {}
player.image      = love.graphics.newImage("images/player.png")
player.fire_sound = love.audio.newSource('audio/Laser_Shoot2.wav')

function player:new(x, y, width, height, speed)
  return setmetatable({
    x          = x,
    y          = y,
    width      = width,
    height     = height,
    speed      = speed
  }, {__index = self})
end

function player:fire()
  if self:getCooldown() <= 0 then
    self:setCooldown(80, false)
    love.audio.play(self.fire_sound)
    bullet   = {}
    bullet.x = self.x + 4
    bullet.y = self.y + 2
    table.insert(self.bullets, bullet)
  end
end

function player:setCooldown(value, incrise)
  if incrise then
    self.cooldown = self.cooldown + value
    return
  end

  self.cooldown = value
end

function player:getCooldown()
  return self.cooldown
end

--[[function player:setX(x)
  self.x = x
end

function player:getX()
  return self.x
end]]

return player