local state = {}

function state:init()
end

function state:draw()
  if love.window.getFullscreen( ) then
    local gwidth,gheight = love.window.getDesktopDimensions()
    love.graphics.scale( gwidth/bwidth, gheight/bheight)
  end

  love.graphics.printf("SCORE: "..gamestates.game._game._score.."\nGood job!",
    0,bheight/2,bwidth,"center")

end

function state:update(dt)
  if anydong("confirm") then
    Gamestate.switch(gamestates.menu)
  end
end

return state
