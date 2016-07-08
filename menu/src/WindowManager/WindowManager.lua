WINDOW_WIDTH = 1920
WINDOW_HEIGHT = 1080
local scale = 1
local borderX = 0
local borderY = 0
local width = WINDOW_WIDTH
local height = WINDOW_HEIGHT

function windowManager_resize(width, height)
  if width and height then love.window.setMode(width, height, {})
  else width, height = love.graphics.getDimensions() end
  if width / height > WINDOW_WIDTH / WINDOW_HEIGHT then
    scale = height / WINDOW_HEIGHT
    borderX = (width - WINDOW_WIDTH * scale) / 2
    if not love.window.getFullscreen() and borderX ~= 0 then
      love.window.setMode(WINDOW_WIDTH - borderX * 2, WINDOW_HEIGHT, {})
      borderX = 0
    end
    borderY = 0
  else
    scale = width / WINDOW_WIDTH
    borderY = (height - WINDOW_HEIGHT * scale) / 2
    borderX = 0
  end
end

function windowManager_fullscreen(flag)
  love.window.setFullscreen(flag)
  windowManager_resize()
end

function windowManager_relCoord(x, y)
  return (x - borderX) / scale, (y - borderY) / scale
end

function windowManager_draw(image, x, y, r, sx, sy, ox, oy, aux)
  if not x then
    love.graphics.draw(image, borderX, borderY, 0, scale, scale)
    return
  end
  
  if type(x) ~= "number" then
    if oy and aux then
      love.graphics.draw(image, x, y * scale + borderX, r * scale + borderY, sx, scale * sy, scale * ox, oy, aux)
    elseif sy and ox then
      love.graphics.draw(image, x, y * scale + borderX, r * scale + borderY, sx, scale * sy, scale * ox)
    elseif sx then
      love.graphics.draw(image, x, y * scale + borderX, r * scale + borderY, sx, scale, scale)
    else
      love.graphics.draw(image, x, y * scale + borderX, r * scale + borderY, 0, scale, scale)
    end
    return
  end
  
  if ox and oy then
    love.graphics.draw(image, x * scale + borderX, y * scale + borderY, r, scale * sx, scale * sy, ox, oy)
  elseif sx and sy then
    love.graphics.draw(image, x * scale + borderX, y * scale + borderY, r, scale * sx, scale * sy)
  elseif r then
    love.graphics.draw(image, x * scale + borderX, y * scale + borderY, r, scale, scale)
  else
    love.graphics.draw(image, x * scale + borderX, y * scale + borderY, 0, scale, scale)
  end
end

function windowManager_print(text, x, y, r, sx, sy, ox, oy, aux)
  if not x then
    love.graphics.print(text, borderX, borderY, 0, scale, scale)
    return
  end
  
  if type(x) ~= "number" then
    local font = love.graphics.getFont()
    love.graphics.setFont(x)
    
    if oy and aux then
      love.graphics.print(text, y * scale + borderX, r * scale + borderY, sx, scale * sy, scale * ox, oy, aux)
    elseif sy and ox then
      love.graphics.print(text, y * scale + borderX, r * scale + borderY, sx, scale * sy, scale * ox)
    elseif sx then
      love.graphics.print(text, y * scale + borderX, r * scale + borderY, sx, scale, scale)
    else
      love.graphics.print(text, y * scale + borderX, r * scale + borderY, 0, scale, scale)
    end
    
    love.graphics.setFont(font)
    return
  end
  
  if ox and oy then
    love.graphics.print(text, x * scale + borderX, y * scale + borderY, r, scale * sx, scale * sy, ox, oy)
  elseif sx and sy then
    love.graphics.print(text, x * scale + borderX, y * scale + borderY, r, scale * sx, scale * sy)
  elseif r then
    love.graphics.print(text, x * scale + borderX, y * scale + borderY, r, scale, scale)
  elseif x and y then
    love.graphics.print(text, x * scale + borderX, y * scale + borderY, 0, scale, scale)
  else
    love.graphics.print(text, borderX, borderY, 0, scale, scale)
  end
end

function windowManager_drawBorders()
  local r, g, b, a = love.graphics.getColor()
  love.graphics.setColor(0, 0, 0, 255)
    
  if borderX > 0 then    
    love.graphics.rectangle("fill", 0, 0, borderX, height)
    love.graphics.rectangle("fill", width - borderX, 0, borderX, height)    
  elseif borderY > 0 then
    love.graphics.rectangle("fill", 0, 0, width, borderY)
    love.graphics.rectangle("fill", 0, height - borderY, width, borderY)
    
  end
  
  love.graphics.setColor(r, g, b, a)
end

