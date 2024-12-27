return {
  { "mbbill/undotree",                          event = "VeryLazy" },
  { 'nvim-telescope/telescope-fzf-native.nvim', build = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release' },
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "debugloop/telescope-undo.nvim",
    },
    config = function()
      require("telescope").setup({
        -- the rest of your telescope config goes here
        extensions = {
          undo = {
            -- telescope-undo.nvim config, see below
          },
          -- other extensions:
          -- file_browser = { ... }
        },
      })
      require("telescope").load_extension("undo")
      -- optional: vim.keymap.set("n", "<leader>u", "<cmd>Telescope undo<cr>")
    end,
  },
  {
    'nvim-telescope/telescope.nvim',
    branch = "master",
    priority = 999,
    lazy = false,
    dependencies = { 'nvim-lua/plenary.nvim', "nvim-telescope/telescope-frecency.nvim" },
    config = function()
      local builtin = require('telescope.builtin')
      require('telescope').setup {
        defaults = {
          path_display = {
            filename_first = {
              reverse_directories = false
            }
          },
          layout_strategy = "horizontal",
          initial_mode = "insert",

          layout_config = {
            horizontal = {
              prompt_position = "top",
              width = { padding = 0.1 },
              height = { padding = 0.1 },
              preview_width = 0.5,
            },
          },
          mappings = {
            i = {
              -- map actions.which_key to <C-h> (default: <C-/>)
              -- actions.which_key shows the mappings for your picker,
              -- e.g. git_{create, delete, ...}_branch for the git_branches picker
              ["<esc>"] = "close"
            }
          },
          sorting_strategy = "ascending",
        },
        extensions = {
          frecency = {
            -- completely disable the dialog
            show_filter_column = false,
            default_workspace = 'CWD',
            matcher = "fuzzy"
          },
          fzf = {
            fuzzy = true,                   -- false will only do exact matching
            override_generic_sorter = true, -- override the generic sorter
            override_file_sorter = true,    -- override the file sorter
            case_mode = "smart_case",       -- or "ignore_case" or "respect_case"
            -- the default case_mode is "smart_case"
          }
        },
      }

      vim.api.nvim_set_option_value("background", "light", {})
      vim.keymap.set('n', '<leader>o', function()
        require("telescope").extensions.frecency.frecency({
          sorter = require("telescope").extensions.fzf
              .native_fzf_sorter()
        })
      end
      , { desc = 'find files' })
      vim.keymap.set('n', '<leader>i', function()
        builtin.oldfiles({
          sorter = require("telescope").extensions.fzf
              .native_fzf_sorter()
        })
      end, { desc = 'old files' })

      require('telescope').load_extension('fzf')
    end
  }
}
