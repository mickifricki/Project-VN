local font = {}

function setFont(name, size)
  if font[name] == nil then font[name] = love.filesystem.newFileData("/assets/fonts/" .. name .. ".ttf") end
  love.graphics.setFont(love.graphics.newFont(font[name], size))
end