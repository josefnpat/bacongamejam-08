local state = {}

function state:init()
  self._game = gameclass.new()
end

function state:draw()
  self._game:draw()
end

function state:update(dt)
  self._game:update(dt)
end

function state:mousepressed(x,y,button)
  self._game:dm_add(x,y)
end

return state
