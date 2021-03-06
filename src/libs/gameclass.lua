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

  self._score = 0
  
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

  self._accu = 30
  self._accu_max = 30*#dongs
  self._accu_dt = 0
  self._accu_t = 1

  self._spawn_dt = 0
  self._spawn_t = 0.1

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
  love.audio.newSource("assets/sfx/".."shoot"..".ogg","static"):play()
end

function game:update(dt)

  self._spawn_dt = self._spawn_dt + dt

  self._accu_dt = self._accu_dt + dt
  if self._accu_dt > self._accu_t then
    self._accu_dt = self._accu_dt - self._accu_t
    self._accu = math.min(self._accu + 1,self._accu_max)
  end

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
	for _,enemy in pairs(self._enemies) do
      local bulletRadius = 32
	  local dx = enemy:getX() - bullet:getX()
	  local dy = enemy:getY() - bullet:getY()
	  if bulletRadius*bulletRadius > dx*dx + dy*dy then
	    enemy:setHealth( enemy:getHealth() - 1 )
		love.audio.newSource("assets/sfx/".."death"..".wav","static"):play()
		table.remove( self._bullets, i )
		if enemy:getHealth() <= 0 then
		  table.remove( self._enemies, _ )
		  self._score = self._score + 10000 + math.random( 1, 9999 )
		end
      end
    end
  end
  
  for _,enemy in pairs(self._enemies) do
    enemy:update(dt)
    for i,player in pairs(self._players) do
	  local enemyRadius = 16
	  local dx = enemy:getX() - player:getX()
	  local dy = enemy:getY() - player:getY()
	  if enemyRadius*enemyRadius > dx*dx + dy*dy then
	    player:takeDamage()
		love.audio.newSource("assets/sfx/".."death"..".wav","static"):play()
		if player:getHealth() <= 0 then
		  Gamestate.switch(gamestates.death)
		end
      end
    end
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
  
  
  love.graphics.setColor(255,255,255,255)
  love.graphics.printf("Score: "..self._score.."\n"..
    "Deployable: "..self._accu.."/"..self._accu_max,
    32,love.graphics.getHeight()/16,love.graphics.getWidth(),"left")
	
	  
  local idx = 1
  for _,player in pairs(self._players) do
    love.graphics.printf("P"..idx.." Health: "..player:getHealth(),
      32,love.graphics.getHeight()/8 + 32*idx,love.graphics.getWidth(),"left")
	idx = idx + 1
  end

  love.graphics.setColor(255,255,255,self._dmplacewarning*255)

  love.graphics.printf("Click outside the box to choose where you deploy.",
    64,bheight/16,bwidth,"center")

  love.graphics.setColor(255,0,0,self._dmplacewarning*255)

  love.graphics.rectangle("line",
    bwidth/10,
    bheight/8,
    bwidth*8/10,
    bheight*6/8)
  love.graphics.setColor(255,255,255)
end

function game:dm_add(x,y)
  if self._spawn_dt > self._spawn_t then
    self._spawn_dt = 0
  else
    return
  end
  if self._accu > 0 then
    self._accu = self._accu - 1
  else
    return
  end

  if x > bwidth/10 and
    x < bwidth*9/10 and
    y > bheight/8 and
    y < bheight*7/8 then
    self._dmplacewarning=1
    if math.random(0,1) == 1 then
      x = math.random(0,bwidth)
      y = math.random(0,1)*bheight
    else
      y = math.random(0,bheight)
      x = math.random(0,1)*bwidth
    end

  end

  local e = enemyclass.new()
  e:setHealth( math.random(1,3) )
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
