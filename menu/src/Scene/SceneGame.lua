local SceneGame = {
  id        = "",
  background = nil,
  characters = nil,
  effects = nil,
  GUI = nil,
  
  displayGUI = true
}

function new_SceneGame(id)
  local o = {}
  setmetatable(o, SceneGame)
  SceneGame.__index = SceneGame
  o.id = id
  o.characters = {}
  o.effects = {}
  return o
end

function SceneGame:getId()
  return self.id
end

function SceneGame:setBackground(background)
  self.background = background
end

function SceneGame:addCharacter(character)
  table.insert(self.characters, character)
end

function SceneGame:addFX(effect)
  table.insert(self.effects, effect)
end

function SceneGame:setGUI(GUI)
  self.GUI = GUI
end

function SceneGame:removeCharacter(character)
  table.remove(self.characters, character)
end

function SceneGame:removeFX(effect)
  table.remove(self.effects, effect)
end

function SceneGame:setDisplay(flag)
  self.displayGUI = flag
end

function SceneGame:getBackground()
  return self.background
end

function SceneGame:getCharacter(id)
  for i, c in ipairs(self.characters) do
    if c:getId() == id then return c end
  end
end

function SceneGame:getFX(id)
  for i, f in ipairs(self.effects) do
    if f:getId() == id then return f end
  end
end

function SceneGame:getGUI()
  return self.GUI
end

function SceneGame:update(dt)
  for i, c in ipairs(self.characters) do c:update(dt) end
  for i, f in ipairs(self.effects)    do f:update(dt) end
  self.GUI:update(dt)
end

function SceneGame:draw()
  self.background:draw()
  for i, c in ipairs(self.characters) do c:draw() end
  for i, f in ipairs(self.effects) do f:draw() end
  self.GUI:draw()
end

function SceneGame:mousepressed(x, y, button, istouch)
  self.GUI:mousepressed(x, y, button, istouch)
end

function SceneGame:mousereleased(x, y, button, istouch)
  self.GUI:mousereleased(x, y, button, istouch)
end

function SceneGame:mousemoved(x, y, dx, dy, istouch)
  self.GUI:mousehover(x, y, dx, dy, istouch)
end