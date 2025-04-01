vim.lsp.config.bash = {
  cmd = { "bash-language-server", "start" },
  filetypes = { "sh", "bash", "zsh" },
}

vim.lsp.enable("bash")
