M = {}

local file = "/Users/songwang/.local/state/nvim/os_mode"

function M.write(text)
  local f = assert(io.open(file, "w"))
  f:write(text)
  f:close()
end

function M.read()
  local f = assert(io.open(file, "r"))
  local text = f:read()
  f:close()
  return text
end

return M
