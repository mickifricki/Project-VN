require("src/WindowManager/WindowManager")
require("src/GUI/MenuButton")

local MenuArray = {
  buttons = nil,
  selected = 1
}

function new_MenuArray()
  local o = {}
  setmetatable(o, MenuArray)
  MenuArray.__index = MenuArray
  o.buttons = {}
  return o
end

function MenuArray:draw()
  for i, e in ipairs(self.buttons) do e:draw() end
end

function MenuArray:mousepressed(x, y, button, istouch)
end

function MenuArray:mousereleased(x, y, button, istouch)
end

function MenuArray:mousehover(x, y, dx, dy, istouch)
  for i, e in ipairs(self.buttons) do
    if self.selected ~= i then
      e:mousehover(x, y, button, istouch)
      if e:isHovered() then
        self.buttons[self.selected]:deselect()
        self.selected = i
      end
    end
  end
end

function MenuArray:keypressed(key, scancode, isrepeat)
end
  
function MenuArray:keyreleased(key, scancode, isrepeat)  
end

function MenuArray:add(button)
  table.insert(self.buttons, button)
end