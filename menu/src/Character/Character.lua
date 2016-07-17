local Character = {
  id = 0,
  name = "",
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

function new_Character(id, name)
  local o = {}
  setmetatable(o, Character)
  Character.__index = Character

  o.id = id
  o.name = name
  o.poses = {}

  return o
end

function Character:getId()
  return self.id
end
  
function Character:getName()
  return self.name
end

function Character:setPosition(x, y)
  self.x = x
  self.y = y
end

function Character:addPose(id, pose)
  self.poses[id] = pose
end

function Character:setPose(pose)
  self.currentPose = self.poses[pose]
end

function Character:triggerAnimation(animation)
  if animation == "mouth" then self.currentPose:triggerMouth() end
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
  if math.random(0, 150) == 0 then self.currentPose:triggerEyes() end
  
  if self.ms ~= 0 then
    local delta = love.timer.getTime() - self.mt
    if delta < self.ms then
      self.x = self.ix + (delta / self.ms) * self.mx
      self.y = self.iy + (delta / self.ms) * self.my
    else
      self.x = self.ix + self.mx
      self.y = self.iy + self.my
      self.ms = 0
    end
  end
end

function Character:draw()
  self.currentPose:draw(self.x, self.y)
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