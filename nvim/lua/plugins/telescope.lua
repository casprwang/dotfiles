return {
  'nvim-telescope/telescope.nvim',
  tag = '0.1.8',
  priority = 999,
  lazy = false,
  dependencies = { 'nvim-lua/plenary.nvim' },
  config = function()
    local builtin = require('telescope.builtin')
    vim.keymap.set('n', '<leader>8', builtin.find_files, { desc = 'Telescope find files' })
    vim.keymap.set('n', '<leader>i', builtin.oldfiles, { desc = 'Telescope find files' })
    require('telescope').setup {
      defaults = {
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
    }

    vim.api.nvim_set_option_value("background", "light", {})
    vim.cmd("colorscheme gruvbox")
  end
}
