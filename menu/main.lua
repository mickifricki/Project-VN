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
  
  setFont("Papyrus", 35)
  
  local image = love.graphics.newImage("assets/Images/botonesv2.0.png")
  local b1 = new_TestButton(1150, 800, image, "Cerrar", buton1press)
  local b2 = new_TestButton(750, 800, image, "Configuracion", cambiarEscena)
  local b3 = new_TestButton(350, 800, image, "Jugar", cambiarEscena)
  
  local b4 = new_TestButton(300, 100, image, "Pantalla Completa", buton2press)
  local b5 = new_TestButton2(300, 300, image, "Patata", buton3press)
  local b6 = new_TestButton(1150, 800, image, "Aceptar", cambiarEscena)
  
  local b7 = new_TestButton(1150, 800, image, "Salir al menú", cambiarEscena)
  love.window.setFullscreen(fullScreen)
  
  scenes[0] = new_SceneMenu("mainMenu")
  scenes[0]:add(new_Background(love.graphics.newImage("assets/Images/FINALBACKGROUND.png")))
  scenes[0]:add(b1)
  scenes[0]:add(b2)
  scenes[0]:add(b3)
  
  scenes[1] = new_SceneMenu("configMenu")
  scenes[1]:add(new_Background(love.graphics.newImage("assets/Images/fondo.jpg")))
  scenes[1]:add(b4)
  scenes[1]:add(b5)
  scenes[1]:add(b6)
  
  scenes[2] = new_SceneGame("game")
  scenes[2]:setBackground(new_Background(love.graphics.newImage("assets/Images/JustRight.png")))
  scenes[2]:addCharacter(b3)
  scenes[2]:setGUI(b7)
  
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
  local fs = not love.window.getFullscreen()
  love.window.setFullscreen(fs)
  windowManager_update(fs)
  if(love.window.getFullscreen()) then button:setText("Windowed")
  else button:setText("Fullscreen") end
end

function buton3press(button)
  love.graphics.setColor(0, 0, 0)
  windowManager_print("Stil here", 0, 0)
end

function cambiarEscena(button)
  local text = button:getText()
  if text == "Configuracion" then
    currentScene = 1
  elseif text == "Aceptar" or text == "Salir al menú" then
    currentScene = 0
  elseif text == "Jugar" then
    currentScene = 2
  end
end