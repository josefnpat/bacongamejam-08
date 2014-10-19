local state = {}

function state:draw()
  local info = "Press "
  for _,dong in pairs(dongs) do
    info = info .. dong:getBindName("confirm")..", "
  end
  info = info .. "to start the game!"
  love.graphics.print(info)
end

function state:update(dt)
  if anydong("confirm") then
    Gamestate.switch(gamestates.game)
  end
end

return state
