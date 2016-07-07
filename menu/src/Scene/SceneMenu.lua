local SceneMenu = {
  id        = "",
  elements  = nil
}

function new_SceneMenu(id)
  local o = {}
  setmetatable(o, SceneMenu)
  SceneMenu.__index = SceneMenu
  o.id = id
  o.elements = {}
  
  return o
end

function SceneMenu:getId()
  return self.id
end

function SceneMenu:add(element)
  table.insert(self.elements, element)
end

function SceneMenu:remove(element)
  table.remove(self.elements, element)
end

function SceneMenu:getElementbyId(id)
  for i, e in ipairs(self.elements) do
    if e:getId() == id then return e end
  end
end

function SceneMenu:update(dt)
  for i, e in ipairs(self.elements) do e:update(dt) end
end

function SceneMenu:draw()
  for i, e in ipairs(self.elements) do e:draw() end
end

function SceneMenu:mousepressed(x, y, button, istouch)
  for i, e in ipairs(self.elements) do e:mousepressed(x, y, button, istouch) end
end

function SceneMenu:mousereleased(x, y, button, istouch)
  for i, e in ipairs(self.elements) do e:mousereleased(x, y, button, istouch) end
end

function SceneMenu:mousemoved(x, y, dx, dy, istouch)
  for i, e in ipairs(self.elements) do e:mousehover(x, y, dx, dy, istouch) end
end

function SceneMenu:keypressed(key, scancode, isrepeat)
  for i, e in ipairs(self.elements) do e:keypressed(key, scancode, isrepeat) end
end
  
function SceneMenu:keyreleased(key, scancode, isrepeat)
  for i, e in ipairs(self.elements) do e:keyreleased(key, scancode, isrepeat) end
end