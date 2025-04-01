return {
  -- {
  --   'nvim-treesitter/nvim-treesitter-context',
  --   event = "VeryLazy",
  --   config = function()
  --     vim.cmd [[
  --       hi TreesitterContextBottom gui=underline guisp=Black
  --       hi TreesitterContextLineNumberBottom gui=underline guisp=Black
  --     ]]
  --   end
  -- },
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
            },
            goto_next_end = {
              ["]F"] = "@function.outer",
            },
            goto_previous_start = {
              ["[f"] = "@function.outer",
            },
            goto_previous_end = {
              ["[F"] = "@function.outer",
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
              additional_vim_regex_highlighting = { "ruby", "elixir" },
              use_languagetree = false,
              disable = { "dockerfile" },
            },
            indent = {
              enable = false, -- very slow if enabled, use blink indent instead
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
    },
    config = function()
      require('nvim-ts-autotag').setup({})
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter-refactor",
    event = "VeryLazy",
    enabled = true,
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
