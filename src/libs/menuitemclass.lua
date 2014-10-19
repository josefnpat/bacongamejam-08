local menuitem = {}

function menuitem.new(text,onSelect,onAdjust)
  local self={}
  self.draw=menuitem.draw
  self.update=menuitem.update
  self.select=menuitem.select
  self.adjust=menuitem.adjust
  self._onSelect=onSelect --init
  self.getOnSelect=menuitem.getOnSelect
  self.setOnSelect=menuitem.setOnSelect
  self._onAdjust=onAdjust --init
  self.getOnAdjust=menuitem.getOnAdjust
  self.setOnAdjust=menuitem.setOnAdjust
  self._text=text --init
  self.getText=menuitem.getText
  self.setText=menuitem.setText
  return self
end

function menuitem:draw(x,y,w,h,hover)
  if hover then
    love.graphics.setColor(colors.primary_background_active)
  else
    love.graphics.setColor(colors.primary_background)
  end
  love.graphics.rectangle("fill",x,y,w,h)
  love.graphics.setColor(colors.primary_text)
  love.graphics.printf(self._text,
    x,y+love.graphics.getFont():getHeight()*0.4,
    w,"center")
end

function menuitem:update(dt)
end

function menuitem:select()
  if self._onSelect then
    self:_onSelect()
  end
end

function menuitem:adjust()
end

function menuitem:getOnSelect()
  return self._onSelect
end

function menuitem:setOnSelect(val)
  self._onSelect=val
end

function menuitem:getOnAdjust()
  return self._onAdjust
end

function menuitem:setOnAdjust(val)
  self._onAdjust=val
end

function menuitem:getText()
  return self._text
end

function menuitem:setText(val)
  self._text=val
end

return menuitem
