function love.load()
  fondo = love.graphics.newImage("kappa.png")
  button_list = {}
  
end
function button_spawn(x, y, text, imagen)
  table.insert(button_list, {x = x, y = y, text = text, imagen = imagen})
  
end
function love.update(dt)
  
end
function love.draw()
  love.graphics.draw(fondo)
end
