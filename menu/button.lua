Button = {
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
function Button:new(x, y, w, h, text, func)
  local o = {}
  setmetatable(o, self)
  self.__index = self
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
function Button:draw()
  --love.graphics.setColor(255,255,255)
  --windowManager_draw(self.image, self.x, self.y, 0, 1 ,1 ,width, height)
  love.graphics.setColor(0, 0, 0)
  windowManager_print(self.text, self.x + (self.w/2) - (font:getWidth(self.text)/2), self.y + (self.h/2) - (font:getHeight(self.text)/2))
  if self.pressed then
    self.func()
  end
end
function Button:mousepressed(x, y, b)
  if x >= self.x and x <= self.x2 and y >= self.y and y <= self.y2 then
    self.pressed = true
  end
end
function Button:mousereleased(x, y, b)
    self.pressed = false
end