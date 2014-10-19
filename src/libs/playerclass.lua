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
  
  -- lazy alloc of global texture
  if player_img == nil then
    player_img = love.graphics.newImage("assets/cell.png")
  end
  
  player_img:setFilter("nearest","nearest")
  self._idlequads = {}
  self._deathquads = {}
  for i = 0,3 do
    for j = 0,3 do
	  if i < 2 then
	    table.insert(self._idlequads,love.graphics.newQuad(64*j,64*i,64,64,256,256))
	  elseif i == 2 then
	    table.insert(self._deathquads,love.graphics.newQuad(64*j,64*i,64,64,256,256))
	  end
	end
  end
  self._dying = false
  self._frameDuration = 0.1
  self._animTime = self._frameDuration
  self._frameIdx = 1
  
  return self
end

function player:update(dt)
  local vx,vy = self._dong:getBind("move")
  self._x = self._x + vx*dt*self:getSpeed()
  self._y = self._y + vy*dt*self:getSpeed()
  
  self._animTime = self._animTime - dt
  if self._animTime <= 0 then
    self._animTime = self._frameDuration + self._animTime
    self._frameIdx = self._frameIdx + 1
	if self._dying ~= true then
	  if self._frameIdx > 8 then self._frameIdx = 1 end
	else
	  if self._frameIdx > 4 then self._frameIdx = 5 end
	end
  end
end

function player:draw()
  
  local quad = nil
  if not self._dying then
    quad = self._idlequads[self._frameIdx]
  elseif self._frameIdx < 5 then
    quad = self._deathquads[self._frameIdx]
  end
  love.graphics.draw( player_img, quad, self:getX()-32, self:getY()-32 )
  
  love.graphics.setColor( 255, 255, 0 )
  love.graphics.circle( "line", 
    self:getX(), self:getY(), 
    16, 20
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
