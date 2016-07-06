require("src/WindowManager/WindowManager")

local Background = {
  image = nil
}

function new_Background(background)
  local o = {}
  setmetatable(o, Background)
  Background.__index = Background
  o.image = background
  return o
end

function Background:draw()
  windowManager_draw(self.image)
end

function Background:mousepressed(x, y, b)
end

function Background:mousereleased(x, y, b)
end

function Background:mousehover(x, y, b)
end