local menu = {}

function menu.new()
  local self={}
  self.draw=menu.draw
  self.update=menu.update
  self.up=menu.up
  self.down=menu.down
  self.adjust=menu.adjust
  self.select=menu.select
  self.add=menu.add

  self._selected=1
  self._items={}

  return self
end

function menu:draw()
  local width = 320
  local x = (bwidth - width)/2
  local height = love.graphics.getFont():getHeight()*1.8
  local padding = height
  local y = (bheight - (height+padding)*#self._items)/2
  for index,item in pairs(self._items) do
    item:draw(x,y+index*(height+padding),width,height,index==self._selected)
  end
end

function menu:update(dt)
  for _,item in pairs(self._items) do
    item:update(dt)
  end
end

function menu:up()
  self._selected = self._selected - 1
  if self._selected <= 0 then
    self._selected = #self._items
  end
end

function menu:down()
  self._selected = self._selected + 1
  if self._selected > #self._items then
    self._selected = 1
  end
end

function menu:adjust()
end

function menu:select()
  self._items[self._selected]:select()
end

function menu:add(item)
  table.insert(self._items,item)
end

return menu
