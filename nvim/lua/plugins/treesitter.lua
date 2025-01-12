return {
  {
    "windwp/nvim-ts-autotag",
    event = "VeryLazy",
    dependencies = {
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
              additional_vim_regex_highlighting = false,
              use_languagetree = false,
            },
            indent = {
              enable = false, -- very slow if enabled
            },
            ensure_installed = {
              "c",
              "html",
              "heex",
              "elixir",
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
          }
        end,
      }
    },
    config = function()
      require('nvim-ts-autotag').setup({
        aliases = {
          ["eruby"] = "html",
        }
      })
    end,
  },
}
