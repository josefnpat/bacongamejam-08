local game = {}
playerclass = require("libs.playerclass")

function game.new()
  local self={}
  self.makePlayers=game.makePlayers
  self.update=game.update
  self.draw=game.draw
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
  self:makePlayers()
  return self
end

function game:makePlayers()
  self._players = {}
  print("making players")
  for i=1,3,1 do
    local p = playerclass.new()
	p:setHealth(10)
	p:setDamage(1)
	p:setPosition( math.random(400,1400) )
	table.insert(self._players, p)
  end
end

function game:addBullet( val )
  table.insert( self._bullets, val )
end

function game:update(dt)
  if self._players == nil then self._players = {} end
  for i,player in pairs(self._players) do
    player:update(dt)
  end
  if self._bullets == nil then self._bullets = {} end
  for i,bullet in pairs(self._bullets) do
    bullet:update(dt)
  end
end

function game:draw()
  if self._players == nil then self._players = {} end
  for i,player in pairs(self._players) do
    player:draw()
  end
  if self._bullets == nil then self._bullets = {} end
  for i,bullet in pairs(self._bullets) do
    bullet:draw()
  end
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