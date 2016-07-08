require("src/WindowManager/WindowManager")
require("src/GUI/ButtonBase")

local Button = {
  buttonBase = nil,
  texture = nil,
  sprites = nil
}

function new_Button(x, y, image, text, func)
  local o = {}
  setmetatable(o, Button)
  Button.__index = Button
  local w = image:getWidth()
  local h = image:getHeight()
  local w2 = w/2
  local h2 = h/2
  
  o.buttonBase = new_ButtonBase(x, y, w2, h2, text, func)
  o.texture = image
  o.sprites = {}
  
  o.sprites[0] = love.graphics.newQuad(0  , 0  , w2, h2, w, h)
  o.sprites[1] = love.graphics.newQuad(w2 , 0  , w2, h2, w, h)
  o.sprites[2] = love.graphics.newQuad(0  , h2 , w2, h2, w, h)
  o.sprites[3] = love.graphics.newQuad(w2 , h2 , w2, h2, w, h)
  return o
end

function Button:update(dt)
end

function Button:draw()
  love.graphics.setColor(255, 255, 255)
  if self.buttonBase:isPressed() then
    if self.buttonBase:isHovered() then windowManager_draw(self.texture, self.sprites[1], self.buttonBase:getPosition())
    else windowManager_draw(self.texture, self.sprites[3], self.buttonBase:getPosition()) end
  else
    if self.buttonBase:isHovered() then windowManager_draw(self.texture, self.sprites[2], self.buttonBase:getPosition())
    else windowManager_draw(self.texture, self.sprites[0], self.buttonBase:getPosition()) end
  end
  self.buttonBase:draw()
end

function Button:mousepressed(x, y, b)
  self.buttonBase:mousepressed(x, y, b)
end

function Button:mousereleased(x, y, b)
  self.buttonBase:mousereleased(x, y, b)
end

function Button:mousehover(x, y, dx, dy)
  self.buttonBase:mousehover(x, y, dx, dy)
end

function Button:keypressed(key, scancode, isrepeat)
end
  
function Button:keyreleased(key, scancode, isrepeat)  
end

function Button:isPressed()
  return self.buttonBase:isPressed()
end