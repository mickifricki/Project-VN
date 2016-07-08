local MenuButton = {  
  x = 0,
  y = 0,
  w = 0,
  h = 0,
  text = "",
  func = nil,
  texture = nil,
  sprites = nil,
  
  x2 = 0,
  y2 = 0,
  midWidth = 0,
  spriteWidth = 0,
  
  hovered = false,
  selected = false,

  font = nil
}

function new_MenuButton(x, y, image, text, func)
  local o = {}
  setmetatable(o, MenuButton)
  MenuButton.__index = MenuButton
  o.x = x
  o.y = y
  o.h = image:getHeight()
  o.text = text
  o.func = func
  o.texture = image
  o.sprites = {}
  o.font = love.graphics.getFont()
  
  local w = image:getWidth()
  o.spriteWidth = w/6
  
  local tw = o.font:getWidth(text)
  local fw = tw + o.spriteWidth - tw % o.spriteWidth
  
  o.w = fw + 2 * o.spriteWidth
  o.x2 = x + o.w
  o.y2 = y + o.h
  o.midWidth = fw / o.spriteWidth
  
  for i = 0, 5 do o.sprites[i] = love.graphics.newQuad(i * o.spriteWidth , 0, o.spriteWidth, o.h, w, o.h) end
  return o
end


function MenuButton:getPosition()
  return self.x, self.y
end

function MenuButton:setPosition(x, y)
  self.x = x
  self.y = y
end

function MenuButton:getDimensions()
  return self.w, self.h
end

function MenuButton:getText()
  return self.text
end

function MenuButton:isHovered()
  return self.hovered
end

function MenuButton:inBounds(x, y)
  return x >= self.x and x <= self.x2 and y >= self.y and y <= self.y2
end

function MenuButton:draw()
  love.graphics.setColor(255, 255, 255)    
  if self.selected then
    windowManager_draw(self.texture, self.sprites[3], self.x, self.y)
    local x =self.x + self.spriteWidth
    
    for i = 1, self.midWidth, 1 do
      windowManager_draw(self.texture, self.sprites[4], x, self.y)
      x = x + self.spriteWidth
    end
       
    windowManager_draw(self.texture, self.sprites[5], x, self.y)    
  else
    windowManager_draw(self.texture, self.sprites[0], self.x, self.y)
    local x = self.x + self.spriteWidth
    
    for i = 1, self.midWidth, 1 do
      windowManager_draw(self.texture, self.sprites[1], x, self.y)
      x = x + self.spriteWidth
    end
      
    windowManager_draw(self.texture, self.sprites[2], x, self.y)
  end
  
  love.graphics.setFont(self.font)
  love.graphics.setColor(0,0,0)
  windowManager_print(self.text, self.x + self.w/2 - self.font:getWidth(self.text)/2, self.y + self.h/2 - self.font:getHeight(self.text)/2)
end

function MenuButton:mousepressed(x, y, b)
end

function MenuButton:mousereleased(x, y, b)
end

function MenuButton:mousehover(x, y, dx, dy)
  self.hovered = self:inBounds(x, y)
  self.selected = self.hovered
end

function MenuButton:keypressed(key, scancode, isrepeat)
end
  
function MenuButton:keyreleased(key, scancode, isrepeat)  
end

function MenuButton:deselect()
  self.selected = false
end