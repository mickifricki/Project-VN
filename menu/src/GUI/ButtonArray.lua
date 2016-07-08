require("src/GUI/SelectedButton")

local ButtonArray = {
  buttons = nil,
  currentPressed = 1
}

function new_ButtonArray()
  local o = {}
  setmetatable(o, ButtonArray)
  ButtonArray.__index = ButtonArray
  o.buttons = {}
  return o
end

function ButtonArray:update(dt)
end

function ButtonArray:draw()
  for i, e in ipairs(self.buttons) do e:draw() end
end

function ButtonArray:mousepressed(x, y, button, istouch)
  for i, e in ipairs(self.buttons) do
    if self.currentPressed ~= i then
      e:mousepressed(x, y, button, istouch)
      if e:isPressed() then
        self.buttons[self.currentPressed]:deselect()
        self.currentPressed = i
      end
    end
  end
end

function ButtonArray:mousereleased(x, y, button, istouch)
  for i, e in ipairs(self.buttons) do e:mousereleased(x, y, dx, dy, istouch) end
end

function ButtonArray:mousehover(x, y, dx, dy, istouch)
  for i, e in ipairs(self.buttons) do e:mousehover(x, y, dx, dy, istouch) end
end

function ButtonArray:keypressed(key, scancode, isrepeat)
  if key == "right" or key == "" then
  end
end
  
function ButtonArray:keyreleased(key, scancode, isrepeat)  
  for i, e in ipairs(self.buttons) do e:keyreleased(key, scancode, isrepeat) end
end

function ButtonArray:add(button)
  table.insert(self.buttons, button)
end