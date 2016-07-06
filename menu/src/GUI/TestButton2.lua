require("src/GUI/TestButton")
require("src/WindowManager/WindowManager")

local TestButton2 = {
  testButton = nil,
  func = nil
}

function new_TestButton2(x, y, image, text, func)
  local o = {}
  setmetatable(o, TestButton2)
  TestButton2.__index = TestButton2
  o.testButton = new_TestButton(x, y, image, text)
  o.func = func
  return o
end

function TestButton2:draw()
  self.testButton:draw()
  if self.testButton:isPressed() then self.func(button) end
end

function TestButton2:mousepressed(x, y, b)
  self.testButton:mousepressed(x, y, b)
end

function TestButton2:mousereleased(x, y, b)
  self.testButton:mousereleased(x, y, b)
end

function TestButton2:mousehover(x, y, b)
  self.testButton:mousehover(x, y, b)
end