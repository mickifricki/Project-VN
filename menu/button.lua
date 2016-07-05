Button = {
  x = 0, 
  y = 0, 
  text = "", 
  image = nil,
  func = nil,
  
  x2 = 0,
  y2 = 0, 
  pressed = false
}
function Button:new(x, y, image, text, func)
  o = {}
  setmetatable(o, self)
  self.__index = self
  o.x = x
  o.y = y
  o.image = image
  o.text = text
  o.func = func
  width = 100
  height = 50
  o.x2 = x + width
  o.y2 = y + height
  return o
end
function Button:draw()
  love.graphics.setColor(255,255,255)
  windowManager_draw(self.image, self.x, self.y, 0, 1 ,1 ,width, height)
  love.graphics.setColor(0, 0, 0)
  windowManager_print(tostring(self.pressed), self.x - 10, self.y)
  windowManager_print(self.text, self.x + (self.image:getWidth()/2) - (font:getWidth(self.text)/2), self.y + (self.image:getHeight()/2) - (font:getHeight(self.text)/2))
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