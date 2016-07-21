function ProcessText()
  io.input("src/TextManager/prueba.txt")
  local text = ""
  for line in io.lines() do text = text .. "\n" .. line end    
  return text
end