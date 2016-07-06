local font = {}

function addFont(path, name)
  font[name] = love.filesystem.newFileData(path)
end

function getFont(name, size)
  return love.graphics.newFont(font[name], size)
end