local player = {}

function player.new()
  local self={}
  self.update=player.update
  self.draw=player.draw
  self.die=player.die
  self._health=nil --init
  self.getHealth=player.getHealth
  self.setHealth=player.setHealth
  self._damage=nil --init
  self.getDamage=player.getDamage
  self.setDamage=player.setDamage
  self._x = 0
  self._y = 0
  self.getX=player.getX
  self.getY=player.getY
  self.setX=player.setX
  self.setY=player.setY
  self.setPosition=player.setPosition
  return self
end

function player:update()
end

function player:draw()
  print("drawing player")
  love.graphics.setColor( 255, 255, 0 )
  love.graphics.triangle( "line", 
    self._x - 20, self._y - 20, 
    self._x, self._y + 20, 
    self._x + 20, self._y - 20 
  )
  love.graphics.setColor( 255, 255, 0, 255 )
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

function player:setX(val)
  self._x = val
end

function player:setY(val)
 self._y = val
end

function player:getX()
  return self._x
end

function player:getY()
  return self._y
end

function player:setPosition( x, y )
  self:setX(x)
  self:setY(y)
end

return player
