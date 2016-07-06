require("button")
require("WindowManager")
require("TestButton")

local image
local backgrund
local b
local b2
local fullScreen = false

function love.load()
  love.window.setTitle("NV Project pre-alpha 0.0.0.1.1.Kappa")
  love.window.setMode(WINDOW_WIDTH, WINDOW_HEIGHT, {})
  font = love.graphics.newFont("Fonts/Arial.ttf", 20);
  love.graphics.setFont(font)
  image = love.graphics.newImage("botones.png")
  backgrund = love.graphics.newImage("JustRight.png")
  b = new_TestButton(300, 100, image, "Cerrar", buton1press)
  b2 = new_TestButton(300, 300, image, "Batata", buton2press)
  if fullScreen then love.window.setFullscreen(fullScreen) end
  
end
function love.mousepressed(ax, ay , button, istouch)
  local x, y = windowManager_relCoord(ax, ay)
  b:mousepressed(x, y, button)
  b2:mousepressed(x, y, button)
end
function love.mousereleased(ax, ay , button, istouch)
  local x, y = windowManager_relCoord(ax, ay)
  b:mousereleased(x, y, button)
  b2:mousereleased(x, y, button)
end
function love.update(dt)
  
end
function buton1press()
  love.graphics.setColor(0, 0, 0)
  windowManager_print("fuck u")
  love.event.quit(0)
end
function buton2press()
  love.resize()
  love.graphics.setColor(0, 0, 0)
  local width, height = love.window.getDesktopDimensions()
  windowManager_print(width .. ", " .. height)
  love.window.setFullscreen(true)
  --[[x, y, display = love.window.getPosition()
  x = x + math.random(-1,1)
  y = y + math.random(-1,1)
  love.window.setPosition(x, y, display)
  love.graphics.setColor(0, 0, 0)
  love.graphics.print("NOPE")]]--
end


function love.draw()
  love.graphics.setColor(255,255,255)
  windowManager_draw(backgrund)
  b:draw()
  b2:draw()
  windowManager_drawBorders()
end