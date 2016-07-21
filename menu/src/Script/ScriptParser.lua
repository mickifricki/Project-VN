local Script = {
  init = nil,
  script = nil,
  size = 0,
  it = 0
}

function new_Script(path)
  local function split(line, n)
    local function script_error(path, com, arg, line)
      error("\n    Error at file: ".. path .. "\n    Expected " .. arg .. " arguments at command '" .. com .. "' at line " .. line, 2)
    end
    
    local par = {}
    for element in string.gmatch(line, "[^|]+") do table.insert(par, element) end
    
    if not par[1] then return end
  
    if par[1] == "background" then
      if par[2] then return par end
      script_error(path, "background", 1, n) return
    elseif par[1] == "sfx" then
      if par[2] then return par end
      script_error(path, "sfx", 1, n) return
    elseif par[1] == "add" then
      if not par[5] then script_error(path, "add", 4, n) return end
      return par
    elseif par[1] == "move" then
      if not par[4] then script_error(path, "move", 3, n) return end
      return par
    elseif par[1] == "text" then
      if not par[2] then script_error(path, "text", 1, n) return end
      return par
    elseif par[1] == "select" then
      if not par[5] then script_error(path, "select", 4, n) return end
      return par
    else error("\n    Error at file: " .. path .. "\n    Unrecognized command at line " .. n, 2) return end
  end
  
  local o = {}
  setmetatable(o, Script)
  Script.__index = Script
  assert(io.input(path))
  o.init = {}
  o.script = {}
  local script = false
  local count = 0
  
  for line in io.lines() do
    count = count + 1
    if line == "--script" then script = true
    elseif line ~= "" and line ~= "--init" then
      if script then
        o.size = o.size + 1
        table.insert(o.script, split(line,count))
      else table.insert(o.init, split(line,count)) end
    end
  end
  
  return o
end

function Script:getInit()
  return self.init
end

function Script:next()
  if self.size <= self.it then return nil end
  self.it = self.it + 1
  return self.script[self.it]
end