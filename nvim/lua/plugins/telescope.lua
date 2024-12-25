return {
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
            show_filter_column = false
          },
        },
      }

      vim.api.nvim_set_option_value("background", "light", {})
      vim.keymap.set('n', '<leader>o', ":Telescope frecency workspace=CWD<cr>", { desc = 'find files' })
      vim.keymap.set('n', '<leader>i', builtin.oldfiles, { desc = 'old files' })
    end
  }
}
