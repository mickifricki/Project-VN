local Pose = {
  image = nil,
  body = nil,
  
  ex = 0,
  ey = 0,
  et = 0,
  eyes = nil,
  
  mx = 0,
  my = 0,
  mt = 0,
  mouth = nil,

  fe = -1,
  fm = -1
}

function new_Pose(image)
  local o = {}
  setmetatable(o, Pose)
  Pose.__index = Pose
  o.image = image
  o.eyes = {}
  o.mouth = {}
  return o
end

function Pose:addQuad(comp, quad, x, y)
  if comp == "body" then self.body = quad
  elseif comp == "eyes" then
    table.insert(self.eyes, quad)
    if x and y then
      self.ex = x
      self.ey = y
    end
  elseif
    comp == "mouth" then table.insert(self.mouth, quad)
    if x and y then
      self.mx = x
      self.my = y
    end
  end
end

function Pose:getQuad(comp, index, x, y)
  if comp == "body" then return self.body
  elseif comp == "eyes" then return self.eyes[index + 1]
  elseif comp == "mouth" then return self.mouth[index + 1] end
end

function Pose:draw(x, y)
  windowManager_draw(self.image, self.body, x, y)
  local currTime = love.timer.getTime()
  print(currTime - self.et, self.fe)
  
  if self.fe >= 0 then
    if self.fe == 3 then self.fe = -1
    else
      windowManager_draw(self.image, self.eyes[(self.fe % 2) + 1], x + self.ex, y + self.ey)
      if (currTime - self.et) >= 0.08 then
        self.et = currTime
        self.fe = self.fe + 1
      end
    end
  end
  
  if self.fm >= 0 then
    self.mt = currTime
    if self.fm == 3 then self.fm = -1
    else
      windowManager_draw(self.image, self.mouth[(self.fm % 2) + 1], x + self.mx, y + self.mx)
      if (currTime - self.mt) >= 0.08 then
        self.mt = currTime
        self.fm = self.fm + 1
      end
    end
  end
end

function Pose:triggerEyes()
  self.fe = 0
  self.et = love.timer.getTime()
end

function Pose:triggerMouth()
  self.fm = 0
  self.mt = love.timer.getTime()
end

function Pose:mousepressed(x, y, b)
end

function Pose:mousereleased(x, y, b)
end

function Pose:mousehover(x, y, dx, dy)
end

function Pose:keypressed(key, scancode, isrepeat)
end
  
function Pose:keyreleased(key, scancode, isrepeat)  
end