local enemy = {}

enemy.img = love.graphics.newImage("assets/cellenemy.png")

enemy.quads = {}
for y = 1,2 do
  for x = 1,4 do
    table.insert(enemy.quads,
      love.graphics.newQuad((x-1)*64,(y-1)*64,64,64,256,256)
    )
  end
end

function enemy.new()
  local self={}
  self.update=enemy.update
  self.draw=enemy.draw
  self.die=enemy.die
  self.setPosition=enemy.setPosition
  self.moveTo=enemy.moveTo
  self._health=nil --init
  self.getHealth=enemy.getHealth
  self.setHealth=enemy.setHealth
  self._damage=1 --init
  self.getDamage=enemy.getDamage
  self.setDamage=enemy.setDamage
  self._x = nil
  self.getX=enemy.getX
  self.setX=enemy.setX
  self._y = nil
  self.getY=enemy.getY
  self.setY=enemy.setY
  self._speed=math.random(80,120) --init
  self.getSpeed=enemy.getSpeed
  self.setSpeed=enemy.setSpeed

  self._angle=0
  self.getAngle=enemy.getAngle
  self.setAngle=enemy.setAngle

  self._quad_index = 1
  self._quad_dt = 0
  self._quad_t = 0.1

  self._color = {
    math.random(127,255),
    math.random(127,255),
    math.random(127,255)
  }

  return self
end

function enemy:update(dt)
  self._quad_dt = self._quad_dt + dt
  if self._quad_dt > self._quad_t then
    self._quad_dt = 0
    self._quad_index = self._quad_index + 1
    if self._quad_index > #enemy.quads then
      self._quad_index = 1
    end
  end
  local players = gamestates.game._game:getPlayers()
  local best_dist = math.huge
  local best_index
  for i,v in pairs(players) do
    local dist = math.sqrt(
      (v:getX()-self:getX())^2 +
      (v:getX()-self:getX())^2 )
    if dist < best_dist then
      best_dist = dist
      best_index = i
    end
  end
  self:moveTo(dt,players[best_index])
end

function enemy:draw()
  love.graphics.setColor(self._color)
  love.graphics.draw(enemy.img,enemy.quads[self._quad_index],
    self:getX(),self:getY(),
    self:getAngle(),1,1,32,32
  )
  love.graphics.setColor(255,255,255)
end

function enemy:die()
end

function enemy:setPosition(x,y)
  self:setX(x)
  self:setY(y)
end

function enemy:moveTo(dt,target)
  local direction = math.atan2(
    target:getY() - self:getY(),
    target:getX() - self:getX())
  local x = math.cos(direction)*dt*self:getSpeed()
  local y = math.sin(direction)*dt*self:getSpeed()
  self:setPosition(self:getX()+x,self:getY()+y)
  self:setAngle(direction)
end

function enemy:getHealth()
  return self._health
end

function enemy:setHealth(val)
  self._health=val
end

function enemy:getDamage()
  return self._damage
end

function enemy:setDamage(val)
  self._damage=val
end

function enemy:getX()
  return self._x
end

function enemy:setX(val)
  self._x=val
end

function enemy:getY()
  return self._y
end

function enemy:setY(val)
  self._y=val
end

function enemy:getSpeed()
  return self._speed
end

function enemy:setSpeed(val)
  self._speed=val
end

function enemy:getAngle()
  return self._angle
end

function enemy:setAngle(val)
  self._angle = val
end

return enemy
