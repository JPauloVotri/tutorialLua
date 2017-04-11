HC = require("scripts.HC")

local bullet = {}

function bullet:new(x, y, width, height, speed)
  return setmetatable({
    body  = HC.rectangle(x, y, width, height),
    speed = speed
  }, {__index = self})
end

function bullet:update(dt)
  self.x, self.y, self.width, self.height = self.body:bbox()
  self.width = self.width - self.x
  self.height = self.height - self.y
  
  self.body:move(0, -self.speed*dt)
end

function bullet:draw()
  love.graphics.rectangle("fill", self.x, self.y, self.width, self.height)
end

return bullet