return {
  {
    "davidmh/mdx.nvim",
    config = true,
    event = "VeryLazy",
    dependencies = { "nvim-treesitter/nvim-treesitter" }
  },
  {
    'nvim-treesitter/nvim-treesitter-context',
    event = "VeryLazy",
    config = function()
      vim.cmd [[
        hi TreesitterContextBottom gui=underline guisp=Black
        hi TreesitterContextLineNumberBottom gui=underline guisp=Black
      ]]
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
              -- ["at"] = "@attribute.outer",
              -- ["it"] = "@attribute.inner",
              ["am"] = "@parameter.outer",
              ["im"] = "@parameter.inner",
              ["aa"] = "@parameter.outer",
              ["ia"] = "@parameter.inner",
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
          move = {
            enable = true,
            set_jumps = true, -- whether to set jumps in the jumplist
            goto_next_start = {
              ["]f"] = "@function.outer",
              ["]]"] = "@class.outer",
            },
            goto_next_end = {
              ["]F"] = "@function.outer",
              ["]["] = "@class.outer",
            },
            goto_previous_start = {
              ["[f"] = "@function.outer",
              ["[["] = "@class.outer",
            },
            goto_previous_end = {
              ["[F"] = "@function.outer",
              ["[]"] = "@class.outer",
            },
          }
        },
      }
    end
  },
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
              disable = { "dockerfile" },
            },
            indent = {
              enable = true, -- very slow if enabled
              -- disable = { "ruby" },
            },
            ensure_installed = {
              "c",
              "html",
              "lua",
              "yaml",
              "graphql",
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
              "rust",
              "typescript",
              "tsx",
              "go",
              "vue",
              "python",
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
  {
    "nvim-treesitter/nvim-treesitter-refactor",
    event = "VeryLazy",
    config = function()
      require 'nvim-treesitter.configs'.setup {
        refactor = {
          highlight_definitions = {
            enable = true,
            -- Set to false if you have an `updatetime` of ~100.
            clear_on_cursor_move = false,
          },
          highlight_current_scope = { enable = false },
        },
      }
    end
  }
}
