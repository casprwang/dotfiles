return {
  {
    'stevearc/conform.nvim',
    event = "VeryLazy",
    enabled = true,
    config = function()
      require("conform").setup({
        formatters_by_ft = {
          sql             = { 'sqlfmt' },
          ruby            = { "rubyfmt" },
          sh              = { "shfmt" },
          go              = { "goimports", "gofmt" },
          python          = { "ruff_format" },
          typescriptreact = { "lsp" },
          json            = { "prettierd" },
          html            = { "prettierd" },
          css             = { "prettierd" },
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
        }
      })
      vim.api.nvim_create_user_command("Format", function(args)
        local range = nil
        if args.count ~= -1 then
          local end_line = vim.api.nvim_buf_get_lines(0, args.line2 - 1, args.line2, true)[1]
          range = {
            start = { args.line1, 0 },
            ["end"] = { args.line2, end_line:len() },
          }
        end
        require("conform").format({ async = true, lsp_format = "fallback", range = range })
      end, { range = true })

      -- vim.api.nvim_create_autocmd("BufWritePre", {
      --   pattern = "*",
      --   callback = function(args)
      --     require("conform").format({ bufnr = args.buf, async = true, quiet = true })
      --   end,
      -- })
    end
  },
}
