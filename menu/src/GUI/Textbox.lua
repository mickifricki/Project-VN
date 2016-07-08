require("lib/UTF8/utf8")

velocity = 0.01

local Textbox = {
  x = 0,
  y = 0,
  w = 0,
  h = 0,
  text = nil,
  font = "Arial",
  size = 20,
  mode = "normal",
  
  nl = 0,
  
  timer = 0,
  index = 1,
  line = 0,
  currentLine = 1
}

function new_Textbox(x, y, w, h, font, size, mode)
  local o = {}
  setmetatable(o, Textbox)
  Textbox.__index = Textbox
  o.x = x
  o.y = y
  o.w = w
  o.h = h
  text = {}
  if font then o.font = font end
  if size then o.size = size end
  if mode then o.mode = mode end
  
  o.nl = math.floor(o.h / o.size)
  return o
end

function Textbox:format(text)
  local lines = {}
  local font = getFont(self.font, self.size)
  local currentLine = ""
  for i in string.gmatch(text, "[^ ]+[ \t]*") do
    if string.find(i, "\n") == nil and font:getWidth(currentLine .. i) <= self.w then
      currentLine = currentLine .. string.match(i, "%S+") .. " "
    else
      table.insert(lines, currentLine)
      currentLine = string.match(i, "%S+") .. " "
    end
  end
  table.insert(lines, currentLine)
  return lines
end

function Textbox:setLines(lines)
  self.text = lines
end

function Textbox:draw()
  setFont(self.font, self.size, 0, 0, 0)
  local font = getFont(self.font, self.size)
  local l = 0
  
  if self.mode == "normal" then
    while l < self.nl and l < table.getn(self.text) do
      windowManager_print(self.text[l + self.currentLine], self.x, self.y + l * self.size)
      l = l + 1
    end
  elseif self.mode == "typewriter" then
    while l < self.nl and l < self.line do
      windowManager_print(self.text[l + self.currentLine], self.x, self.y + l * self.size)
      l = l + 1
    end
    if self.line < self.nl and self.line + self.currentLine <= table.getn(self.text) then
      windowManager_print(string.utf8sub(self.text[l + self.currentLine], 0, self.index), self.x, self.y + l * self.size)
      local currentTime = love.timer.getTime()
      if currentTime - self.timer >= velocity then
        self.timer = currentTime
        if self.index < string.utf8len(self.text[l + self.currentLine]) then self.index = self.index + 1
        else
          self.index = 1
          self.line = self.line + 1
        end
      end
    end
  end
end

function Textbox:mousepressed(x, y, b)
  if self.line + self.currentLine <= table.getn(self.text) then
    if self.line < self.nl then
      self.line = math.min(table.getn(self.text) - self.currentLine + 1, self.nl)
      self.index = 1
    else
      self.currentLine = self.currentLine + self.nl
      self.line = 0
    end
  end
end

function Textbox:mousereleased(x, y, b)
end

function Textbox:mousehover(x, y, dx, dy)
end

function Textbox:keypressed(key, scancode, isrepeat)
  if key == "return" or key == "z" or key == "space" then self:mousepressed(0, 0, 0) end
end
  
function Textbox:keyreleased(key, scancode, isrepeat)  
end








