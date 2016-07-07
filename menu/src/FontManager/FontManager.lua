local font = {}

function setFont(name, size, r, g, b)
  if font[name] == nil then font[name] = love.filesystem.newFileData("/assets/fonts/" .. name .. ".ttf") end
  love.graphics.setFont(love.graphics.newFont(font[name], size))
  if r and g and b then love.graphics.setColor(r,g,b) end
end

function getFont(name, size)
  if font[name] == nil then font[name] = love.filesystem.newFileData("/assets/fonts/" .. name .. ".ttf") end
  return love.graphics.newFont(font[name], size)
end