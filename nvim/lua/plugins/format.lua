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
        format_on_save = {
          -- These options will be passed to conform.format()
          timeout_ms = 500,
          lsp_format = "fallback",
        },
        formatters = {
          erbformat = {
            command = "htmlbeautifier",
            args = { "< 'app/views/tasks/index.html.erb'" },
            stdin = false,
          }
        }
      })
      vim.api.nvim_create_autocmd("BufWritePre", {
        pattern = "*",
        callback = function(args)
          require("conform").format({ async = true, lsp_format = "fallback" })
        end,
      })
    end
  },
}
