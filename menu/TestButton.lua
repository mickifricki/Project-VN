require("button")
require("WindowManager")

TestButton = {
  button = nil,
  spriteBatch = nil
}
function TestButton:new(x, y, spriteBatch, text, func)
  o = {}
  setmetatable(o, self)
  self.__index = self
  o.button = Button:new(x, y, , text, func)
  o.spriteBatch = love.graphics.newSpriteBatch(image, 4)
  
  return o
end
function TestButton:draw()
  if button.pressed then
    
  else
    
  end
end