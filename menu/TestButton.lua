require("button")
require("WindowManager")

TestButton = {
  button = nil,
  images = {},
  image = nil
  
}

function TestButton:new(x, y, image, text, func)
  local o = {}
  setmetatable(o, self)
  self.__index = self
  o.button = Button:new(x, y, 100, 50, text, func)
  o.image = image
  o.images[0] = love.graphics.newQuad(0, 0, 100, 50, 200, 100)
  o.images[1] = love.graphics.newQuad(100, 0, 100, 50, 200, 100)
  o.images[2] = love.graphics.newQuad(0, 50, 100, 50, 200, 100)
  o.images[3] = love.graphics.newQuad(100, 50, 100, 50, 200, 100)
  
  return o
end
function TestButton:draw()
  if self.button.pressed then
    love.graphics.setColor(255,255,255)
    windowManager_draw(self.image, self.images[1], self.button.x, self.button.y)
    self.button:draw()
  else
    love.graphics.setColor(255,255,255)
    windowManager_draw(self.image, self.images[0], self.button.x, self.button.y)
    self.button:draw()
  end
end
function TestButton:mousepressed(x, y, b)
  self.button:mousepressed(x, y, b)
end
function TestButton:mousereleased(x, y, b)
  self.button:mousereleased(x, y, b)
end