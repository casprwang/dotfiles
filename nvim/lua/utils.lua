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

function M.set_fzf_opts_light()
  local f = assert(io.popen("source ~/.config/zsh/fzf.sh && fzf_light"))
  local x = f:read("*all")
  vim.env.FZF_DEFAULT_OPTS = x
  f:close()
end

function M.set_fzf_opts_dark()
  local f = assert(io.popen("source ~/.config/zsh/fzf.sh && fzf_dark"))
  local x = f:read("*all")
  vim.env.FZF_DEFAULT_OPTS = nil
  vim.env.FZF_DEFAULT_OPTS = x
  f:close()
end

return M
