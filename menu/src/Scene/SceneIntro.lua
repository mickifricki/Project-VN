local SceneIntro = {
  id = -1,
  d = nil,
  opening = nil,
  t = 0,
  a = 0
}

function new_SceneIntro()
  local o = {}
  setmetatable(o, SceneIntro)
  SceneIntro.__index = SceneIntro
  
  o.t = love.timer.getTime()
  o.d = love.graphics.newImage("assets/intro/SampleText.png")
  o.opening = love.graphics.newVideo("assets/intro/SIGA.ogv")
  
  return o
end

function SceneIntro:getId()
  return self.id
end

function SceneIntro:update(dt)
  local delta = love.timer.getTime() - self.t
  
  if delta > 6 and delta <= 7 then
    self.d = self.opening
    self.d:play()
    self.a = 255
  end
  
  if delta > 1 and delta < 4 then self.a = ((delta - 1) * 1020) / 2
  elseif delta > 4 and delta < 6 then self.a = (255 - ((delta - 5) * 1020)) / 2 end

  if delta > 10 then currentScene = 0 end
end

function SceneIntro:draw()
  love.graphics.setColor(255,255,255,self.a)
  windowManager_draw(self.d)
end

function SceneIntro:mousepressed(x, y, button, istouch)
  if love.timer.getTime() - self.t < 6 then self.t = love.timer.getTime() - 6 
  else
    self.t = love.timer.getTime() - 11
    if self.d:type() == "Video" then self.d:pause() end
  end
end

function SceneIntro:mousereleased(x, y, button, istouch)
end

function SceneIntro:mousemoved(x, y, dx, dy, istouch)
end

function SceneIntro:keypressed(key, scancode, isrepeat)
end
  
function SceneIntro:keyreleased(key, scancode, isrepeat)
end