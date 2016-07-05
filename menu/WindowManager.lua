WINDOW_WIDTH = 1920
WINDOW_HEIGHT = 1080
local scale = 1
local borderX = 0
local borderY = 0
local width = WINDOW_WIDTH
local height = WINDOW_HEIGHT

function love.resize()
  width, height = love.window.getDesktopDimensions()
  if width / height > WINDOW_WIDTH / WINDOW_HEIGHT then
    scale = height / WINDOW_HEIGHT
    borderX = (width - WINDOW_WIDTH * scale) / 2
    borderY = 0
  else
    scale = width / WINDOW_WIDTH
    borderY = (height - WINDOW_HEIGHT * scale) / 2 
    borderX = 0
  end
end
function windowManager_relCoord(x, y)
  return (x - borderX) / scale, (y - borderY) / scale
end
function windowManager_draw(image, x, y, r, sx, sy, ox, oy)
  if ox and oy then
    love.graphics.draw(image, x * scale + borderX, y * scale + borderY, r, scale * sx, scale * sy, ox, oy)
  elseif sx and sy then
    love.graphics.draw(image, x * scale + borderX, y * scale + borderY, r, scale * sx, scale * sy)
  elseif r then
    love.graphics.draw(image, x * scale + borderX, y * scale + borderY, r, scale, scale)
  elseif x and y then
    love.graphics.draw(image, x * scale + borderX, y * scale + borderY, 0, scale, scale)
  else
    love.graphics.draw(image, borderX, borderY, 0, scale, scale)
  end
end
function windowManager_print(text, x, y, r, sx, sy, ox, oy)
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
  if borderX > 0 then
    love.graphics.rectangle("fill", 0, 0, borderX, height)
    love.graphics.rectangle("fill", width - borderX, 0, borderX, height)
  elseif borderY > 0 then
    love.graphics.rectangle("fill", 0, 0, width, borderY)
    love.graphics.rectangle("fill", 0, height - borderY, width, borderY)
  end
end

