local player = {}

function player.new()
  local self={}
  self.update=Player.update
  self.draw=Player.draw
  self.die=Player.die
  self._health=nil --init
  self.getHealth=Player.getHealth
  self.setHealth=Player.setHealth
  self._damage=nil --init
  self.getDamage=Player.getDamage
  self.setDamage=Player.setDamage
  return self
end

function player:update()
end

function player:draw()
end

function player:die()
end

function player:getHealth()
  return self._health
end

function player:setHealth(val)
  self._health=val
end

function player:getDamage()
  return self._damage
end

function player:setDamage(val)
  self._damage=val
end

return player
