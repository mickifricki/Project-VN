require("src/WindowManager/WindowManager")
require("src/GUI/TestButton")
require("src/GUI/TestButton2")
require("src/GUI/Background")
require("src/Scene/SceneMenu")
require("src/Scene/SceneGame")
require("src/FontManager/FontManager")

local fullScreen = false
local scenes = {}
local currentScene = 0

function love.load()
  love.window.setTitle("NV Project ULTRA++ pre-alpha 0.0.0.1.1.Keepo /")
  love.window.setMode(WINDOW_WIDTH, WINDOW_HEIGHT, {})
  addFont("assets/Fonts/DTM-Sans.otf", "Determination Sans")
  love.graphics.setFont(getFont("Determination Sans", 20))
  local image = love.graphics.newImage("assets/Images/botones.png")
  local background = new_Background(love.graphics.newImage("assets/Images/JustRight.png"))
  local background2 = new_Background(love.graphics.newImage("assets/Images/keeppo.png"))
  local b1 = new_TestButton(300, 100, image, "Cerrar", buton1press)
  local b2 = new_TestButton(300, 155, image, "Fullscreen", buton2press)
  local b3 = new_TestButton2(300, 100, image, "Patata", buton3press)
  local b4 = new_TestButton(300, 210, image, "Cambiar", cambiarEscena)
  love.window.setFullscreen(fullScreen)
  
  scenes[0] = new_SceneMenu("testMenu")  
  scenes[0]:add(background)
  scenes[0]:add(b1)
  scenes[0]:add(b2)
  scenes[0]:add(b4)
  
  scenes[1] = new_SceneGame("testMenu2")
  scenes[1]:setBackground(background2)
  scenes[1]:addCharacter(b3)
  scenes[1]:setGUI(b4)
  
end

function love.update(dt)
  
end

function love.draw()  
  love.graphics.setColor(255,255,255)
  scenes[currentScene]:draw()
  
  windowManager_drawBorders()
end

function love.mousepressed(ax, ay , button, istouch)
  local x, y = windowManager_relCoord(ax, ay)
  scenes[currentScene]:mousepressed(x, y, button, istouch)
end

function love.mousereleased(ax, ay , button, istouch)
  local x, y = windowManager_relCoord(ax, ay)
  scenes[currentScene]:mousereleased(x, y, button, istouch)
end

function love.mousemoved(ax, ay , dx, dy, istouch)
  local x, y = windowManager_relCoord(ax, ay)
  scenes[currentScene]:mousemoved(x, y, dx, dy, istouch)
end

function buton1press()
  love.graphics.setColor(0, 0, 0)
  windowManager_print("fuck u")
  love.event.quit(0)
end

function buton2press(button)
  love.window.setFullscreen(not love.window.getFullscreen())
  if(love.window.getFullscreen()) then button:setText("Windowed")
  else button:setText("Fullscreen") end
end

function buton3press(button)
  love.graphics.setColor(0, 0, 0)
  windowManager_print("Stil here", 0, 0)
end

function cambiarEscena(button)
  currentScene = (currentScene + 1) % 2
end