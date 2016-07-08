local Character = {
  id = "",
  x = 0,
  y = 0,
  poses = nil,
  currentPose = "",
  
  ix = 0,
  iy = 0,
  mx = 0,
  my = 0,
  ms = 0,
  mt = 0
}

function new_Character(id)
  local o = {}
  setmetatable(o, Character)
  Character.__index = Character
  o.id = id
  o.poses = {}
  return o
end

function Character:addPose(id, pose)
  self.poses[id] = pose
end

function Character:setPose(pose)
  self.currentPose = self.poses[pose]
end

function Character:triggerAnimation(animation)
  if animation == "eyes" then self.currentPose:triggerEyes()
  elseif animation == "mouth" then self.currentPose:triggerMouth() end
end

function Character:draw()
  self.currentPose:draw(self.x, self.y)
end

function Character:move(x, y, time)
  self.ix = self.x
  self.iy = self.y
  self.mx = x
  self.my = y
  self.ms = time
  self.mt = love.timer.getTime()
end

function Character:update(dt)
  if self.ms ~= 0 then
    local time = love.timer.getTime() - self.mt
    if time < self.ms then
      self.x = self.ix + (time / self.ms) * self.mx
      self.y = self.iy + (time / self.ms) * self.my
    else
      self.x = self.mx
      self.y = self.my
      self.ms = 0
    end
  end
end

function Character:mousepressed(x, y, b)
end

function Character:mousereleased(x, y, b)
end

function Character:mousehover(x, y, dx, dy)
end

function Character:keypressed(key, scancode, isrepeat)
end
  
function Character:keyreleased(key, scancode, isrepeat)  
end