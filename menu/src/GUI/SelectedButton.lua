require("src/WindowManager/WindowManager")
require("src/GUI/ButtonBase")

local SelectedButton = {
  buttonBase = nil,
  texture = nil,
  sprites = nil,
  selected = false
}

function new_SelectedButton(x, y, image, text, func, init)
  local o = {}
  setmetatable(o, SelectedButton)
  SelectedButton.__index = SelectedButton
  local w = image:getWidth()
  local h = image:getHeight()
  local w2 = w/2
  local h2 = h/2  
  o.buttonBase = new_ButtonBase(x, y, w2, h2, text, func)
  o.texture = image
  o.sprites = {}
  o.selected = init
  
  o.sprites[0] = love.graphics.newQuad(0  , 0  , w2, h2, w, h)
  o.sprites[1] = love.graphics.newQuad(w2 , 0  , w2, h2, w, h)
  o.sprites[2] = love.graphics.newQuad(0  , h2 , w2, h2, w, h)
  o.sprites[3] = love.graphics.newQuad(w2 , h2 , w2, h2, w, h)
  return o
end

function SelectedButton:draw()
  love.graphics.setColor(255, 255, 255)
  if self.selected then
    windowManager_draw(self.texture, self.sprites[1], self.buttonBase:getPosition())
  else
    if self.buttonBase:isHovered() then windowManager_draw(self.texture, self.sprites[2], self.buttonBase:getPosition())
    else windowManager_draw(self.texture, self.sprites[0], self.buttonBase:getPosition()) end
  end
  self.buttonBase:draw()
end

function SelectedButton:mousepressed(x, y, b)
  if not self.selected then 
    self.buttonBase:mousepressed(x, y, b)
    if self.buttonBase:isPressed() then self.selected = true end
  end
end

function SelectedButton:mousereleased(x, y, b)
  self.buttonBase:mousereleased(x, y, b)
end

function SelectedButton:mousehover(x, y, dx, dy)
  self.buttonBase:mousehover(x, y, dx, dy)
end

function SelectedButton:isPressed()
  return self.buttonBase:isPressed()
end

function SelectedButton:deselect()
  self.selected = false
end