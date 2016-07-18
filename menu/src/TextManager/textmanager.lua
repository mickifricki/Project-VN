function ProcessText()

local count = 1
io.input("src/TextManager/prueba.txt")
    while true do
      local line = io.read()
      if line == nil then break end
      io.write(string.format("%6d  ", count), line, "\n")
      count = count + 1
    end
    
     local lines = {}
    -- read the lines in table 'lines'
    for line in io.lines() do
      table.insert(lines, line)
    end
    -- sort
    table.sort(lines)
    -- write all the lines
    for i, l in ipairs(lines) do io.write(l, "\n") end
  return lines
  end
  
  