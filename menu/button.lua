local Button = {
  x = 0,
  y = 0,
  w = 0,
  h = 0,
  text = "",
  func = nil,
  
  x2 = 0,
  y2 = 0,
  pressed = false
}

function new_Button(x, y, w, h, text, func)
  local o = {}
  setmetatable(o, Button)
  Button.__index = Button
  o.x = x
  o.y = y
  o.w = w
  o.h = h
  o.text = text
  o.func = func
  
  o.x2 = x + w
  o.y2 = y + h
  return o
end

function Button:getPosition()
  return self.x, self.y
end

function Button:setPosition(x, y)
  self.x = x
  self.y = y
end

function Button:getDimensions()
  return self.w, self.h
end

function Button:setDimensions(w, h)
  self.w = w
  self.h = h
end

function Button:getText()
  return self.text
end

function Button:setText(text)
  self.text = text
end

function Button:isPressed()
  return pressed
end


function Button:draw()
  love.graphics.setColor(0, 0, 0)
  windowManager_print(self.text, self.x + self.w/2 - font:getWidth(self.text)/2, self.y + self.h/2 - font:getHeight(self.text)/2)  
  if self.pressed then self.func() end
end

function Button:mousepressed(x, y, b)
  if self:inBounds(x, y) then
    self.pressed = true
  end
end

function Button:mousereleased(x, y, b)
  self.pressed = false
end

function Button:inBounds(x, y)
  return x >= self.x and x <= self.x2 and y >= self.y and y <= self.y2
end