return {
  'stevearc/conform.nvim',
  enabled = false,
  opts = {
    formatters_by_ft = {
      sql = { 'sqlfluff' }
    },
    format_on_save = {
      -- These options will be passed to conform.format()
      timeout_ms = 500,
      lsp_format = "fallback",
    },
    formatters = {
      sqlfluff = {
        prepend_args = { 'fix', '--dialect', 'sqlite' }
      }
    }
  },
}
