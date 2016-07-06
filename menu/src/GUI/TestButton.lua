require("src/WindowManager/WindowManager")
require("src/GUI/Button")

local TestButton = {
  button = nil,
  texture = nil,
  sprites = nil
}

function new_TestButton(x, y, image, text, func)
  local o = {}
  setmetatable(o, TestButton)
  TestButton.__index = TestButton
  local w = image:getWidth()
  local h = image:getHeight()
  local w2 = w/2
  local h2 = h/2
  
  o.button = new_Button(x, y, w2, h2, text, func)
  o.texture = image
  o.sprites = {}
  
  o.sprites[0] = love.graphics.newQuad(0  , 0  , w2, h2, w, h)
  o.sprites[1] = love.graphics.newQuad(w2 , 0  , w2, h2, w, h)
  o.sprites[2] = love.graphics.newQuad(0  , h2 , w2, h2, w, h)
  o.sprites[3] = love.graphics.newQuad(w2 , h2 , w2, h2, w, h)
  return o
end

function TestButton:draw()
  love.graphics.setColor(255, 255, 255)
  if self.button:isPressed() then
    if self.button:isHovered() then windowManager_draw(self.texture, self.sprites[1], self.button:getPosition())
    else windowManager_draw(self.texture, self.sprites[3], self.button:getPosition()) end
  else
    if self.button:isHovered() then windowManager_draw(self.texture, self.sprites[2], self.button:getPosition())
    else windowManager_draw(self.texture, self.sprites[0], self.button:getPosition()) end
  end
  self.button:draw()
end

function TestButton:mousepressed(x, y, b)
  self.button:mousepressed(x, y, b)
end

function TestButton:mousereleased(x, y, b)
  self.button:mousereleased(x, y, b)
end

function TestButton:mousehover(x, y, dx, dy)
  self.button:mousehover(x, y, dx, dy)
end

function TestButton:isPressed()
  return self.button:isPressed()
end