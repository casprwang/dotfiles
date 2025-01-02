return {
  {
    "windwp/nvim-ts-autotag",
    event = "VeryLazy",
    dependencies = {
      {
        "nvim-treesitter/nvim-treesitter-context",
        event = "VeryLazy",
        config = function()
          require 'treesitter-context'.setup {
            enable = vim.o.lines < 40 and true or false, -- Enable this plugin (Can be enabled/disabled later via commands)
            multiwindow = false,                         -- Enable multiwindow support.
            max_lines = vim.o.lines > 40 and 2 or 1,     -- How many lines the window should span. Values <= 0 mean no limit.
            min_window_height = 0,                       -- Minimum editor window height to enable context. Values <= 0 mean no limit.
            line_numbers = true,
            multiline_threshold = 20,                    -- Maximum number of lines to show for a single context
            trim_scope = 'outer',                        -- Which context lines to discard if `max_lines` is exceeded. Choices: 'inner', 'outer'
            mode = 'topline',                            -- Line used to calculate context. Choices: 'cursor', 'topline'
            separator = nil,
            zindex = 20,                                 -- The Z-index of the context window
            on_attach = nil,                             -- (fun(buf: integer): boolean) return false to disable attaching
          }
        end
      },
      {
        'nvim-treesitter/nvim-treesitter-textobjects',
        event = "VeryLazy",
        config = function()
          require 'nvim-treesitter.configs'.setup {
            textobjects = {
              select = {
                enable = true,
                lookahead = true,
                keymaps = {
                  ["af"] = "@function.outer",
                  ["if"] = "@function.inner",
                  ["ac"] = "@class.outer",
                  ["ic"] = { query = "@class.inner", desc = "Select inner part of a class region" },
                  ["as"] = { query = "@local.scope", query_group = "locals", desc = "Select language scope" },
                },
                selection_modes = {
                  ['@parameter.outer'] = 'v', -- charwise
                  ['@function.outer'] = 'V',  -- linewise
                  ['@class.outer'] = '<c-v>', -- blockwise
                },
                include_surrounding_whitespace = true,
              },
            },
          }
        end
      },
      {
        "nvim-treesitter/nvim-treesitter",
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
