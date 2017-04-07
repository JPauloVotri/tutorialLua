player            = {}
player.x          = 0
player.y          = 110
player.bullets    = {}
player.cooldown   = 40
player.speed      = 0.25
player.image      = love.graphics.newImage("images/player.png")
player.fire_sound = love.audio.newSource('audio/Laser_Shoot2.wav')
player.fire       = function()
  if player.cooldown <= 0 then
    player.cooldown = 80
    love.audio.play(player.fire_sound)
    bullet   = {}
    bullet.x = player.x + 4
    bullet.y = player.y + 2
    table.insert(player.bullets, bullet)
  end
end