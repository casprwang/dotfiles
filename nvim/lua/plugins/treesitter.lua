return {
  {
    'nvim-treesitter/nvim-treesitter-context',
    event = "VeryLazy",
    config = function()
      vim.cmd [[
        hi! link TreesitterContextBottom Whitespace
        hi! link TreesitterContextLineNumberBottom Whitespace
        hi! TreesitterContextBottom gui=underdouble guisp=#51576d
        hi! TreesitterContextLineNumberBottom gui=underdouble guisp=#51576d
      ]]
    end
  },
  {
    "nvim-treesitter/nvim-treesitter",
    enabled = true,
    event = "VeryLazy",
    build = ":TSUpdate",
    config = function()
      local treesitter = require("nvim-treesitter.configs")
      treesitter.setup {
        auto_install = true,
        highlight = {
          enable = true,
          additional_vim_regex_highlighting = { "ruby", "elixir" },
          use_languagetree = false,
          disable = { "dockerfile" },
        },
        indent = {
          enable = true, -- very slow if enabled, use blink indent instead
          -- disable = { "ruby", "elixir" },
        },
        ensure_installed = {
          "c",
          "html",
          "lua",
          "yaml",
          "vim",
          "vimdoc",
          -- "markdown",
          -- "markdown_inline",
          "tsx",
          "lua",
          "css",
          "ruby",
          "json",
          "javascript",
          "typescript",
          "tsx",
          "go",
          "python",
        },
      }
    end,
  }
}
