require("src/FontManager/FontManager")

require("src/Scene/SceneMenu")
require("src/Scene/SceneGame")

require("src/GUI/Background")

require("src/GUI/Button")
require("src/GUI/HoldingButton")
require("src/GUI/SelectedButton")

require("src/GUI/MenuTab")
require("src/GUI/ButtonArray")
require("src/GUI/MenuButton")
require("src/GUI/MenuArray")

require("src/GUI/Textbox")


local fullScreen = false
local scenes = {}
local currentScene = 0

function love.load()
  love.window.setTitle("NV Project ULTRA++ pre-alpha 0.0.0.1.1.Keepo /")
  love.window.setMode(WINDOW_WIDTH, WINDOW_HEIGHT, {})
  
  setFont("Meiryo", 20)
  
  local textbox = new_Textbox(80, 900, 1800, 120, "Meiryo", 40, "typewriter")
  local formatedText = textbox:format("En un lugar de la Mancha, de cuyo nombre no quiero acordarme, no ha mucho tiempo que vivía un hidalgo de los de lanza en astillero, adarga antigua, rocín flaco y galgo corredor. Una olla de algo más vaca que carnero, salpicón las más noches, duelos y quebrantos los sábados, lentejas los viernes, algún palomino de añadidura los domingos, consumían las tres partes de su hacienda. El resto della concluían sayo de velarte, calzas de velludo para las fiestas con sus pantuflos de lo mismo, los días de entre semana se honraba con su vellori de lo más fino. Tenía en su casa una ama que pasaba de los cuarenta, y una sobrina que no llegaba a los veinte, y un mozo de campo y plaza, que así ensillaba el rocín como tomaba la podadera. Frisaba la edad de nuestro hidalgo con los cincuenta años, era de complexión recia, seco de carnes, enjuto de rostro; gran madrugador y amigo de la caza.")  for i, e in ipairs(formatedText) do
    print(e)
  end
  textbox:setLines(formatedText)
  
  local image = love.graphics.newImage("assets/Images/botonesv2.0.png")
  local imbutton = love.graphics.newImage("assets/Images/bottonsimple.png")
  love.window.setFullscreen(fullScreen)
  
  ---------------------------------------------------------------------------------------------------
  scenes[0] = new_SceneMenu("mainMenu")
  scenes[0]:add(new_Background(love.graphics.newImage("assets/Images/FINALBACKGROUND.png")))
  scenes[0]:add(new_Button(1150, 800, image, "Cerrar", buton1press))
  scenes[0]:add(new_Button(750, 800, image, "Configuracion", cambiarEscena))
  scenes[0]:add(new_Button(350, 800, image, "Jugar", cambiarEscena))
  ---------------------------------------------------------------------------------------------------
  local configbackground = new_Background(love.graphics.newImage("assets/Images/fondo.jpg"))
  local acceptbutton = new_Button(1150, 800, image, "Aceptar", cambiarEscena)
  scenes[1] = new_SceneMenu("config_video")
  scenes[1]:add(configbackground)
  scenes[1]:add(new_Button(500, 200, image, "Pantalla Completa", buton2press))
  
  local tabs = new_ButtonArray()
  tabs:add(new_MenuTab(100, 100, imbutton, "Video", cambiarTab))
  tabs:add(new_MenuTab(250, 100, imbutton, "Sound", cambiarTab))
  tabs:add(new_MenuTab(400, 100, imbutton, "Controls", cambiarTab))
  scenes[1]:add(tabs)
  
  local options = new_MenuArray()
  options:add(new_MenuButton(100, 200, imbutton, "Pantalla Completa", function() end))
  options:add(new_MenuButton(100, 260, imbutton, "Resolucion", function() end))
  scenes[1]:add(options)
  
  local resolution = new_ButtonArray()
  resolution:add(new_MenuTab(500, 300, imbutton, "1920x1080", cambiarResolucion))
  resolution:add(new_MenuTab(650, 300, imbutton, "1600x900", cambiarResolucion))
  resolution:add(new_MenuTab(800, 300, imbutton, "800x600", cambiarResolucion))
  scenes[1]:add(resolution)
  
  scenes[1]:add(acceptbutton)
  
  ---------------------------------------------------------------------------------------------------
  scenes[3] = new_SceneMenu("config_audio")
  scenes[3]:add(configbackground)
  scenes[3]:add(tabs)
  
  options = new_MenuArray()
  options:add(new_MenuButton(100, 200, imbutton, "Master sound", function() end))
  options:add(new_MenuButton(100, 260, imbutton, "Music sound", function() end))
  options:add(new_MenuButton(100, 320, imbutton, "SFX sound", function() end))
  options:add(new_MenuButton(100, 380, imbutton, "Voice sound", function() end))
  scenes[3]:add(options)  
  
  scenes[3]:add(acceptbutton)
  ---------------------------------------------------------------------------------------------------  
  scenes[2] = new_SceneGame("game")
  scenes[2]:setBackground(new_Background(love.graphics.newImage("assets/Images/JustRight.png")))
  scenes[2]:addCharacter(new_MenuButton(80, 820, imbutton, "Pacha", function() end))
  scenes[2]:setGUI(textbox)
  ---------------------------------------------------------------------------------------------------  
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

function love.keypressed(key, scancode, isrepeat)
  scenes[currentScene]:keypressed(key, scancode, isrepeat)
end
  
function love.keyreleased(key, scancode, isrepeat)
  scenes[currentScene]:keyreleased(key, scancode, isrepeat)
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

function cambiarTab(button)
  local text = button:getText()
  if text == "Video" then
    currentScene = 1
  elseif text == "Sound" then
    currentScene = 3
  end
end