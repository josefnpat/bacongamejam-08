local player = {}

function player.new()
  local self={}
  self.update=player.update
  self.draw=player.draw
  self.die=player.die
  self._health=0 --init
  self.getHealth=player.getHealth
  self.setHealth=player.setHealth
  self._damage=0 --init
  self.getDamage=player.getDamage
  self.setDamage=player.setDamage
  self._rotation = 0
  self._setRotation=player.setRotation
  self._getRotation=player.getRotation
  self._x = 0
  self._y = 0
  self.getX=player.getX
  self.getY=player.getY
  self.setX=player.setX
  self.setY=player.setY
  self.setPosition=player.setPosition
  self._velocityX = 0
  self._speed=100
  self.getSpeed=player.getSpeed
  self.setSpeed=player.setSpeed
  return self
end

function player:update(dt)
  local vx,vy = self._dong:getBind("move")
  self._x = self._x + vx*dt*self:getSpeed()
  self._y = self._y + vy*dt*self:getSpeed()
end

function player:draw()
  love.graphics.setColor( 255, 255, 0 )
  love.graphics.circle( "fill", 
    self._x - 20, self:getY() - 20, 
    32, 3
  )
  love.graphics.setColor( 255, 255, 255, 255 )
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
  if self._x == nil then self:setX(0) end
  return self._x
end

function player:getY()
  if self._y == nil then self:setY(0) end
  return self._y
end

function player:setPosition( x, y )
  self:setX(x)
  self:setY(y)
end

function player:getPosition()
  return { self:getX(), self:getY() }
end

function player:getRotation()
  return self._rotation
end

function player:setRotation(val)
  self._rotation = val
end

function player:getSpeed()
  return self._speed
end

function player:setSpeed(val)
  self._speed=  val
end
return player
