require("src/FontManager/FontManager")
require("src/Script/ScriptParser")

require("src/Scene/SceneMenu")
require("src/Scene/SceneGame")
require("src/Scene/SceneGUI")
require("src/Scene/SceneIntro")

require("src/Character/Character")
require("src/Character/Pose")

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
currentScene = -1

function love.load()
  love.window.setTitle("NV Project ULTRA++ pre-alpha 0.0.0.1.1.Keepo /")
  local w, h = love.window.getDesktopDimensions()
  windowManager_resize(w * 0.8, h * 0.8)
  
  scenes[-1] = new_SceneIntro()
  
  setFont("Meiryo", 20)
  
  local textbox = new_Textbox(80, 900, 1800, 120, "Meiryo", 40, "typewriter")
  
  local image = love.graphics.newImage("assets/images/botonesv2.0.png")
  local imbutton = love.graphics.newImage("assets/images/bottonsimple.png")
  windowManager_fullscreen(fullScreen)
  ---------------------------------------------------------------------------------------------------
  scenes[0] = new_SceneMenu("mainMenu")
  scenes[0]:add(new_Background(love.graphics.newImage("assets/images/FINALBACKGROUND.png")))
  scenes[0]:add(new_Button(1150, 800, image, "Cerrar", buton1press))
  scenes[0]:add(new_Button(750, 800, image, "Configuracion", cambiarEscena))
  scenes[0]:add(new_Button(350, 800, image, "Jugar", cambiarEscena))
  ---------------------------------------------------------------------------------------------------
  local configbackground = new_Background(love.graphics.newImage("assets/images/fondo.jpg"))
  local acceptbutton = new_Button(1150, 800, image, "Aceptar", cambiarEscena)
  scenes[1] = new_SceneMenu("config_video")
  scenes[1]:add(configbackground)
  scenes[1]:add(new_Button(500, 200, image, "Fullscreen", buton2press))
  
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
  resolution:add(new_MenuTab(800, 300, imbutton, "1280x720", cambiarResolucion))
  resolution:add(new_MenuTab(950, 300, imbutton, "800x600", cambiarResolucion))
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

  --[[
  local script = new_Script("prueba.txt")
    
  for i, n in ipairs(script:getInit()) do
    if n[1] == "background" then
      scenes[2]:setBackground(new_Background(love.graphics.newImage(n[2])))
    elseif n[1] == "add" then
      if n[2] == "Isaac" then
        isaac = new_Character(1, "Isaac")
        local imgisaac = love.graphics.newImage("assets/images/isaac.png")
        local pose1 = new_Pose(imgisaac)
        
        pose1:addQuad("body", love.graphics.newQuad(0,0,461,607,imgisaac:getWidth(),imgisaac:getHeight()))
        pose1:addQuad("eyes", love.graphics.newQuad(520,43,149,37,imgisaac:getWidth(),imgisaac:getHeight()), 154, 207)
        pose1:addQuad("eyes", love.graphics.newQuad(520,82,149,37,imgisaac:getWidth(),imgisaac:getHeight()))
        
        isaac:addPose("normal", pose1)
        isaac:setPose(n[5])
        isaac:setPosition(n[3], n[4])
        scenes[2]:addCharacter(isaac)
      end
    end
  end  
  ]]--
  
  scenes[2]:setBackground(new_Background(love.graphics.newImage("assets/images/background.jpg")))
  local isaac = new_Character(1, "Isaac")
  local imgisaac = love.graphics.newImage("assets/images/isaac.png")
  local pose1 = new_Pose(imgisaac)
  
  pose1:addQuad("body", love.graphics.newQuad(0,0,461,607,imgisaac:getWidth(),imgisaac:getHeight()))
  pose1:addQuad("eyes", love.graphics.newQuad(520,43,149,37,imgisaac:getWidth(),imgisaac:getHeight()), 154, 207)
  pose1:addQuad("eyes", love.graphics.newQuad(520,82,149,37,imgisaac:getWidth(),imgisaac:getHeight()))
  
  isaac:addPose("normal", pose1)
  isaac:setPose("normal")
  isaac:setPosition(720, 272)
  scenes[2]:addCharacter(isaac)
        
  local formatedText = textbox:format("Hola :D")
  textbox:setLines(formatedText)
  
  ---------------------------------------------------------------------------------------------------  
  
  local GUI = new_SceneGUI("GUI")
  GUI:add(new_Button(350, 800, image, "Salir al menú", cambiarEscena))
  GUI:add(new_MenuButton(80, 820, imbutton, "Isaac", function() end))
  GUI:add(textbox)
  
  scenes[2]:setGUI(GUI)
  ---------------------------------------------------------------------------------------------------  
  
end

function love.update(dt)
  scenes[currentScene]:update(dt)
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
  love.event.quit(0)
end

function buton2press(button)
  windowManager_fullscreen(not love.window.getFullscreen())
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
  windowManager_resize(d[0], d[1])
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