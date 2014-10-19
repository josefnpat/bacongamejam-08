local state = {}

function state:enter()
  music:play()
end

function state:leave()
  music:stop()
end

function state:init()
  self._game = gameclass.new()
end

function state:draw()
  if love.window.getFullscreen( ) then
    local gwidth,gheight = love.window.getDesktopDimensions()
    love.graphics.scale( gwidth/bwidth, gheight/bheight)
  end
  self._game:draw()
end

function state:update(dt)
  if love.mouse.isDown("l") then
    local x,y = love.mouse.getPosition()
    self._game:dm_add(x,y)
  end
  self._game:update(dt)
end

function state:mousepressed(x,y,button)
end

function state:keypressed(key)
  if key == "escape" then
  self._game = gameclass.new()
    Gamestate.switch(gamestates.main)
  end
end

return state
