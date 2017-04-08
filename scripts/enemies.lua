local enemy = {}
enemy.image = love.graphics.newImage("images/enemy.png")

function enemy:new(x, y, width, height, speed)
  return setmetatable({
    x        = x,
    y        = y,
    width    = width,
    height   = height,
    speed    = speed
  }, {__index = self})
end

return enemy