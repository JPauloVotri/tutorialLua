HC = require("scripts.HC")
bullet = require("scripts.bullet")

local player      = {}
player.bullets    = {}
player.image      = love.graphics.newImage("images/player.png")
player.fire_sound = love.audio.newSource("audio/Laser_Shoot2.wav")
player.cooldown   = 0
player.width      = player.image:getWidth()
player.height     = player.image:getHeight()

local screen_width = love.graphics.getWidth() / 5
local screen_height = love.graphics.getHeight() / 5

function player:new(x, y, width, height, speed)
  return setmetatable({
    body  = HC.rectangle(x, y, width, height),
    speed = speed
  }, {__index = self})
end

function player:fire()
  if self:getCooldown() <= 0 then
    self:setCooldown(40, false)
    love.audio.play(self.fire_sound)
    table.insert(self.bullets, bullet:new(self.x+3, self.y+2, 1, 1, 100))
    table.insert(self.bullets, bullet:new(self.x+6, self.y+2, 1, 1, 100))
  end
end

function player:update(dt)
  self.x, self.y = self.body:bbox()
  self.cx, self.cy = self.body:center()
  self:setCooldown(-1, true)

  if love.keyboard.isDown("right") then
    if self.x < screen_width-self.width then
      self.body:move(self.speed*dt,0)
    else
      self.body:moveTo(screen_width-(self.width/2), self.cy)
    end
  elseif love.keyboard.isDown("left") then
    if self.x > 0 then
      self.body:move(-self.speed*dt,0)
    else
      self.body:moveTo(self.width/2, self.cy)
    end
  end

  if love.keyboard.isDown("space") then
    self:fire()
  end

  for i,b in ipairs(player.bullets) do
    b:update(dt)

    if b.y < -10 then
      table.remove(player.bullets, i)
    end
  end
end

function player:draw()
  love.graphics.draw(self.image, self.x, self.y)

  -- Draw the bullets
  love.graphics.setColor(255, 255, 255, 255)
  for _,b in pairs(self.bullets) do
    b:draw()
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

return player