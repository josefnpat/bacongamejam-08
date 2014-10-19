local bullet = {}

function bullet.new()
  local self={}
  self.update=bullet.update
  self.draw=bullet.draw
  self.setPosition=bullet.setPosition
  self._x=nil --init
  self.getX=bullet.getX
  self.setX=bullet.setX
  self._y=nil --init
  self.getY=bullet.getY
  self.setY=bullet.setY
  self._angle=nil --init
  self.getAngle=bullet.getAngle
  self.setAngle=bullet.setAngle
  self._speed=200 --init
  self.getSpeed=bullet.getSpeed
  self.setSpeed=bullet.setSpeed
  self._damage=nil --init
  self.getDamage=bullet.getDamage
  self.setDamage=bullet.setDamage
  self._owner=nil --init
  self.getOwner=bullet.getOwner
  self.setOwner=bullet.setOwner
  return self
end

function bullet:update(dt)
  self:setX( self:getX() + math.cos(self:getAngle())*self:getSpeed()*dt)
  self:setY( self:getY() + math.sin(self:getAngle())*self:getSpeed()*dt)
end

function bullet:draw()
  love.graphics.circle("fill",self:getX(),self:getY(),4)
end

function bullet:setPosition(x,y)
  self:setX(x)
  self:setY(y)
end

function bullet:getX()
  return self._x
end

function bullet:setX(val)
  self._x=val
end

function bullet:getY()
  return self._y
end

function bullet:setY(val)
  self._y=val
end

function bullet:getAngle()
  return self._angle
end

function bullet:setAngle(val)
  self._angle=val
end

function bullet:getSpeed()
  return self._speed
end

function bullet:setSpeed(val)
  self._speed=val
end

function bullet:getDamage()
  return self._damage
end

function bullet:setDamage(val)
  self._damage=val
end

function bullet:getOwner()
  return self._owner
end

function bullet:setOwner(val)
  self._owner=val
end

return bullet
