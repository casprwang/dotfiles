return {
  {

    'stevearc/conform.nvim',
    event = "VeryLazy",
    enabled = true,
    opts = {
      formatters_by_ft = {
        -- sql = { 'sqlfluff' }
        ruby = { "rubocop" },
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
    },
  },
  {
    "sbdchd/neoformat",
    event = "VeryLazy",
    config = function()
      vim.cmd [[
        augroup fmt
          autocmd!
          autocmd BufWritePre *.erb undojoin | Neoformat
        augroup END
      ]]
    end
  }
}
