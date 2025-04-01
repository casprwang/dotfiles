vim.lsp.config.json = {
  cmd = { "vscode-json-language-server", "--stdio" },
  filetypes = { "json", "jsonc" },
  root_markers = { '.git', 'package.json', 'tsconfig.json' },
  init_options = {
    provideFormatter = true,
  },

  -- Add custom command to format entire document
  commands = {
  }
}

vim.lsp.enable("json")
