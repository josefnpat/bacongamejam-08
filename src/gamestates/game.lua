local state = {}
gameclass = require("libs.gameclass")
function state:init()
  self._game = gameclass.new()
end

function state:draw()
  love.graphics.printf(game_name,
    0,love.graphics.getHeight()/4,
    love.graphics.getWidth(),"center")
  self._game:draw()
end

function state:update(dt)
  self._game:update(dt)
  --[[
  if anydong("confirm") then
    self._menu:select()
  end
  if anydong("up") then
    self._menu:up()
  end
  if anydong("down") then
    self._menu:down()
  end
  ]]--
end

return state
