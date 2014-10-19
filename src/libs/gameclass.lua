local game = {}

game.background = love.graphics.newImage("assets/background1.png")
game.foreground = love.graphics.newImage("assets/background2.png")

function game.new()
  local self={}
  self.makePlayers=game.makePlayers
  self.update=game.update
  self.draw=game.draw
  self.dm_add=game.dm_add
  self._players={} --init
  self.getPlayers=game.getPlayers
  self.setPlayers=game.setPlayers
  self._enemies={} --init
  self.getEnemies=game.getEnemies
  self.setEnemies=game.setEnemies
  self._dm=nil --init
  self.getDm=game.getDm
  self.setDm=game.setDm
  self._bullets={} --init
  self.getBullets=game.getBullets
  self.setBullets=game.setBullets

  self.addBullet=game.addBullet

  self:makePlayers()

  self._dmplacewarning=1

  self._bpm_t = 0.54545454545454545454 -- Thanks unek, we suck
  self._bpm_dt = self._bpm_t

  self._color = {
    math.random(127,255),
    math.random(127,255),
    math.random(127,255)
  }


  return self
end

function game:makePlayers()
  self._players = {}
  for i=1,#dongs do
    local p = playerclass.new()
    p:setHealth(10)
    p:setDamage(1)
    p:setPosition( math.random(140,140*6), math.random(140,140*4) )
    p._dong = dongs[i] -- hack hack hack
    table.insert(self._players, p)
  end
end

function game:addBullet( val )
  table.insert( self._bullets, val )
end

function game:update(dt)
  self._bpm_dt = self._bpm_dt + dt
  if self._bpm_dt >= self._bpm_t then
    self._bpm_dt = self._bpm_dt - self._bpm_t
    self._color = {
      math.random(127,255),
      math.random(127,255),
      math.random(127,255)
    }
  end
  self._dmplacewarning = self._dmplacewarning - dt
  if self._dmplacewarning < 0 then
    self._dmplacewarning = 0
  end
  if self._players == nil then self._players = {} end
  for i,player in pairs(self._players) do
    player:update(dt)
  end
  if self._bullets == nil then self._bullets = {} end
  for i,bullet in pairs(self._bullets) do
    bullet:update(dt)
  end
  for _,enemy in pairs(self._enemies) do
    enemy:update(dt)
  end
end

function game:draw()
  self._color[4] = math.sin(self._bpm_dt)*255
  love.graphics.setColor(255,255,255)
  love.graphics.draw(game.background)
  love.graphics.setColor(self._color)
  love.graphics.draw(game.foreground)
  love.graphics.setColor(255,255,255)

  for _,enemy in pairs(self._enemies) do
    enemy:draw()
  end
  if self._players == nil then self._players = {} end
  for i,player in pairs(self._players) do
    player:draw()
  end
  if self._bullets == nil then self._bullets = {} end
  for i,bullet in pairs(self._bullets) do
    bullet:draw()
  end
  love.graphics.setColor(255,0,0,self._dmplacewarning*255)
  love.graphics.rectangle("line",
    love.graphics.getWidth()/10,
    love.graphics.getHeight()/8,
    love.graphics.getWidth()*8/10,
    love.graphics.getHeight()*6/8)
  love.graphics.setColor(255,255,255)
end

function game:dm_add(x,y)
  if x > love.graphics.getWidth()/10 and
    x < love.graphics.getWidth()*9/10 and
    y > love.graphics.getHeight()/8 and
    y < love.graphics.getHeight()*7/8 then
    self._dmplacewarning=1
    if math.random(0,1) == 1 then
      x = math.random(0,love.graphics.getWidth())
      y = math.random(0,1)*love.graphics.getHeight()
    else
      y = math.random(0,love.graphics.getHeight())
      x = math.random(0,1)*love.graphics.getWidth()
    end

  end

  local e = enemyclass.new()
  e:setHealth(2)
  e:setDamage(1)
  e:setPosition(x,y)
  table.insert(self._enemies,e)
end

function game:getPlayers()
  return self._players
end

function game:setPlayers(val)
  self._players=val
end

function game:getEnemies()
  return self._enemies
end

function game:setEnemies(val)
  self._enemies=val
end

function game:getDm()
  return self._dm
end

function game:setDm(val)
  self._dm=val
end

function game:getBullets()
  return self._bullets
end

function game:setBullets(val)
  self._bullets=val
end

return game
