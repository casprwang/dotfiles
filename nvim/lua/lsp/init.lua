-- https://github.com/onosendi/dotfiles/blob/master/.config/nvim/lua/config/lsp/global.lua
-- Load all LSP's in "lua/config/lsp"
local lsp_path = vim.fn.stdpath("config") .. "/lua/lsp"

vim.diagnostic.config({
  -- virtual_text = true,
  underline = true,
  virtual_text = {
    current_line = true,
    severity = { min = vim.diagnostic.severity.WARN }
  },
  virtual_lines = false,
  update_in_insert = false,
  jump = {
    float = false,
    wrap = true,
  },
  float = {
    border = "rounded"
  },
  signs = {
    severity = {
      min = vim.diagnostic.severity.ERROR
    },
    text = {
      [vim.diagnostic.severity.ERROR] = '•',
      [vim.diagnostic.severity.WARN] = '',
      [vim.diagnostic.severity.INFO] = '',
      [vim.diagnostic.severity.HINT] = '',
    }
  }
})

-- Then load all other LSP configs
for _, file in ipairs(vim.fn.readdir(lsp_path)) do
  if file:match("%.lua$") and file ~= "init.lua" then
    local module_name = "lsp." .. file:gsub("%.lua$", "")
    require(module_name)
  end
end
