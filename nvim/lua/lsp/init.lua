local lsp_path = vim.fn.stdpath("config") .. "/lua/lsp"


vim.diagnostic.config({
  underline = {
    severity = { min = vim.diagnostic.severity.ERROR }
  },
  virtual_text = {
    current_line = false,
    severity = { min = vim.diagnostic.severity.ERROR }
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
      [vim.diagnostic.severity.ERROR] = '➜', -- '•',
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
