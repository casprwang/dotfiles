return {
  {
    "windwp/nvim-ts-autotag",
    dependencies = "nvim-treesitter/nvim-treesitter",
    config = function()
      require('nvim-ts-autotag').setup({
        aliases = {
          ["eruby"] = "html",
        }
      })
    end,
    lazy = true,
    event = "VeryLazy"
  },
  {

    "nvim-treesitter/nvim-treesitter",
    enabled = true,
    lazy = false,
    build = ":TSUpdate",
    config = function()
      local treesitter = require("nvim-treesitter.configs")
      treesitter.setup({
        highlight = {
          enable = true,
          additional_vim_regex_highlighting = false,
          use_languagetree = false,
        },
        indent = {
          enable = false,
        },
        ensure_installed = {
          "c",
          "html",
          "astro",
          "lua",
          "yaml",
          "graphql",
          "embedded_template",
          "vim",
          "templ",
          "vimdoc",
          "markdown",
          "markdown_inline",
          "query",
          "tsx",
          "lua",
          "css",
          "ruby",
          "json",
          "javascript",
          "rust",
          "typescript",
          "go",
          "vue",
          "python",
          "c_sharp",
          "zig",
        },
        autotag = { enable = true },
      })
    end,
  }
}
