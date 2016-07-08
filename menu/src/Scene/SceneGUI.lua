local SceneGUI = {
  id        = "",
  elements  = nil
}

function new_SceneGUI(id)
  local o = {}
  setmetatable(o, SceneGUI)
  SceneGUI.__index = SceneGUI
  o.id = id
  o.elements = {}  
  return o
end

function SceneGUI:getId()
  return self.id
end

function SceneGUI:add(element)
  table.insert(self.elements, element)
end

function SceneGUI:remove(element)
  table.remove(self.elements, element)
end

function SceneGUI:getElementbyId(id)
  for i, e in ipairs(self.elements) do
    if e:getId() == id then return e end
  end
end

function SceneGUI:update(dt)
  for i, e in ipairs(self.elements) do e:update(dt) end
end

function SceneGUI:draw()
  for i, e in ipairs(self.elements) do e:draw() end
end

function SceneGUI:mousepressed(x, y, button, istouch)
  for i, e in ipairs(self.elements) do e:mousepressed(x, y, button, istouch) end
end

function SceneGUI:mousereleased(x, y, button, istouch)
  for i, e in ipairs(self.elements) do e:mousereleased(x, y, button, istouch) end
end

function SceneGUI:mousehover(x, y, dx, dy, istouch)
  for i, e in ipairs(self.elements) do e:mousehover(x, y, dx, dy, istouch) end
end

function SceneGUI:keypressed(key, scancode, isrepeat)
  for i, e in ipairs(self.elements) do e:keypressed(key, scancode, isrepeat) end
end
  
function SceneGUI:keyreleased(key, scancode, isrepeat)
  for i, e in ipairs(self.elements) do e:keyreleased(key, scancode, isrepeat) end
end