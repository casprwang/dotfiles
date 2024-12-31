return {
  {
    'stevearc/conform.nvim',
    event = "VeryLazy",
    enabled = true,
    config = function()
      require("conform").setup({
        formatters_by_ft = {
          -- sql = { 'sqlfluff' }
          -- ruby = { "rubocop" },
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
          -- sqlfluff = {
          --   prepend_args = { 'fix', '--dialect', 'sqlite' }
          -- }
        }
      })

      vim.api.nvim_create_autocmd("BufWritePre", {
        pattern = "*",
        callback = function(args)
          require("conform").format({ bufnr = args.buf })
        end,
      })
    end
  },
}
