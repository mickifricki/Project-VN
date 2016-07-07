local ButtonBase = {
  x = 0,
  y = 0,
  w = 0,
  h = 0,
  text = "",
  func = nil,
  
  x2 = 0,
  y2 = 0,
  pressed = false,
  hovered = false
}

function new_ButtonBase(x, y, w, h, text, func)
  local o = {}
  setmetatable(o, ButtonBase)
  ButtonBase.__index = ButtonBase
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

function ButtonBase:getPosition()
  return self.x, self.y
end

function ButtonBase:setPosition(x, y)
  self.x = x
  self.y = y
end

function ButtonBase:getDimensions()
  return self.w, self.h
end

function ButtonBase:setDimensions(w, h)
  self.w = w
  self.h = h
end

function ButtonBase:getText()
  return self.text
end

function ButtonBase:setText(text)
  self.text = text
end

function ButtonBase:isPressed()
  return self.pressed
end

function ButtonBase:isHovered()
  return self.hovered
end

function ButtonBase:inBounds(x, y)
  return x >= self.x and x <= self.x2 and y >= self.y and y <= self.y2
end

function ButtonBase:draw()
  love.graphics.setColor(0, 0, 0)
  local font = love.graphics.getFont()
  windowManager_print(self.text, self.x + self.w/2 - font:getWidth(self.text)/2, self.y + self.h/2 - font:getHeight(self.text)/2)
end

function ButtonBase:mousepressed(x, y, b)
  if self:inBounds(x, y) then
    self.pressed = true
    if self.func then self.func(self) end
  end
end

function ButtonBase:mousereleased(x, y, b)
  self.pressed = false
end

function ButtonBase:mousehover(x, y, b)
    self.hovered = self:inBounds(x, y)
end

function ButtonBase:keypressed(key, scancode, isrepeat)
end
  
function ButtonBase:keyreleased(key, scancode, isrepeat)  
end