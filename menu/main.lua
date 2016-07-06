require("src/WindowManager/WindowManager")
require("src/GUI/Button")
require("src/GUI/HoldingButton")
require("src/GUI/SelectedButton")
require("src/GUI/ButtonArray")
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
  
  setFont("Arial", 20)
  
  local image = love.graphics.newImage("assets/Images/botonesv2.0.png")
  local b3 = new_Button(350, 800, image, "Jugar", cambiarEscena)
  love.window.setFullscreen(fullScreen)
  
  scenes[0] = new_SceneMenu("mainMenu")
  scenes[0]:add(new_Background(love.graphics.newImage("assets/Images/FINALBACKGROUND.png")))
  scenes[0]:add(new_Button(1150, 800, image, "Cerrar", buton1press))
  scenes[0]:add(new_Button(750, 800, image, "Configuracion", cambiarEscena))
  scenes[0]:add(b3)
  
  scenes[1] = new_SceneMenu("configMenu")
  scenes[1]:add(new_Background(love.graphics.newImage("assets/Images/fondo.jpg")))
  scenes[1]:add(new_Button(100, 100, image, "Pantalla Completa", buton2press))
  scenes[1]:add(new_Button(100, 300, image, "Resolucion"))
  local resolution = new_ButtonArray()  
  resolution:add(new_SelectedButton(500, 300, image, "1920x1080", cambiarResolucion, true))
  resolution:add(new_SelectedButton(900, 300, image, "1280x720", cambiarResolucion, false))
  resolution:add(new_SelectedButton(1300, 300, image, "800x600", cambiarResolucion, false))
  
  scenes[1]:add(resolution)
  scenes[1]:add(new_Button(1150, 800, image, "Aceptar", cambiarEscena))
  
  scenes[2] = new_SceneGame("game")
  scenes[2]:setBackground(new_Background(love.graphics.newImage("assets/Images/JustRight.png")))
  scenes[2]:addCharacter(b3)
  scenes[2]:setGUI(new_Button(1150, 800, image, "Salir al menú", cambiarEscena))  
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

function cambiarResolucion(button)
  local i = 0
  local d = {}
  for n in string.gmatch(button:getText(), "%d+") do
    d[i] = n
    i = i + 1
  end
  love.window.setMode(d[0], d[1], {})
  love.resize()
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