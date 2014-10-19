

dong2 = require"libs.dong2"


function love.update(dt)
  if global_debug_mode then
    require("libs.lovebird").update()
  end



end

function love.keypressed(key)
  if key == "`" then
    global_debug_mode = not global_debug_mode
  end
end
