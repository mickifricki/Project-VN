require("src/WindowManager/WindowManager")
require("src/GUI/SelectedButton")

local HoldingButton = {
  button = nil,
  func = nil
}

function new_HoldingButton(x, y, image, text, func)
  local o = {}
  setmetatable(o, HoldingButton)
  HoldingButton.__index = HoldingButton
  o.button = new_Button(x, y, image, text)
  o.func = func
  return o
end

function HoldingButton:draw()
  self.button:draw()
  if self.button:isPressed() then self.func(button) end
end

function HoldingButton:mousepressed(x, y, b)
  self.button:mousepressed(x, y, b)
end

function HoldingButton:mousereleased(x, y, b)
  self.button:mousereleased(x, y, b)
end

function HoldingButton:mousehover(x, y, b)
  self.button:mousehover(x, y, b)
end