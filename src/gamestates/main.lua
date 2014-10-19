local state = {}

function state:init()
  self._menu = menuclass.new()

  self._menu:add(menuitemclass.new("New Game",
    function()
      Gamestate.switch(gamestates.game)
    end
  ))

  self._menu:add(menuitemclass.new("Toggle Fullscreen",
    function()
      if love.window.getFullscreen() then
        love.window.setMode(bwidth,bheight)
        love.window.setFullscreen(false, "desktop")
      else
        local gwidth, gheight = love.window.getDesktopDimensions()
        love.window.setMode(gwidth,gheight)
        love.window.setFullscreen(true, "desktop")
      end
      -- MEOW
    end
  ))

  self._menu:add(menuitemclass.new("Quit",
    function()
      love.event.quit()
    end
  ))
end

function state:draw()
  if love.window.getFullscreen( ) then
    local gwidth,gheight = love.window.getDesktopDimensions()
    love.graphics.scale( gwidth/bwidth, gheight/bheight)
  end
  love.graphics.printf(game_name,
    0,love.graphics.getHeight()/4,
    bwidth,"center")
  self._menu:draw()
end

function state:update(dt)
  self._menu:update(dt)
  if anydong("confirm") then
    self._menu:select()
  end
  if anydong("up") then
    self._menu:up()
  end
  if anydong("down") then
    self._menu:down()
  end
end

return state
