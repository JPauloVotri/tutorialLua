local enemy = {}
enemy.image = love.graphics.newImage("images/enemy.png")

function enemy:new(x, y, width, height, speed)
  return setmetatable({
    body  = HC.rectangle(x, y, width, height),
    speed = speed
  }, {__index = self})
end

function enemy:update(dt)
  self.x, self.y, self.width, self.height = self.body:bbox()
  self.width  = self.width - self.x
  self.height = self.height - self.y
  self.cx, self.cy = self.x + self.width/2, self.y + self.height/2

  if self.y >= love.graphics.getHeight()/5 then
    game_over = true
  end
  self.body:move(0, self.speed*dt)
end

function enemy:draw()
  love.graphics.draw(self.image, self.x, self.y)
end

return enemy