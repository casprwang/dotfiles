return {
  {
    'stevearc/conform.nvim',
    event = "VeryLazy",
    enabled = true,
    config = function()
      require("conform").setup({
        formatters_by_ft = {
          -- sql = { 'sqlfluff' }
          ruby = { "rubocop" },
          sh = { "shfmt" },
          python = { "ruff_fix", "ruff_format" }
          -- eruby = { "erbformat", stop_after_first = true }
        },
        format_after_save = {
          -- These options will be passed to conform.format()
          async = true,
          timeout_ms = 500,
          lsp_format = "fallback",
          quiet = true
        },
        notify_on_error = false,
        formatters = {
          erbformat = {
            command = "htmlbeautifier",
            args = { "< 'app/views/tasks/index.html.erb'" },
            stdin = false,
          }
        }
      })
    end
  },
}
