return {
  'nvim-telescope/telescope.nvim',
  tag = '0.1.8',
  dependencies = { 'nvim-lua/plenary.nvim' },
  config = function()
    local builtin = require('telescope.builtin')
    -- vim.keymap.set('n', '<leader>8', builtin.find_files, { desc = 'Telescope find files' })
    require('telescope').setup {
      defaults = {
        layout_strategy = "horizontal",
        layout_config = {
          horizontal = {
            prompt_position = "top",
            width = { padding = 0.1 },
            height = { padding = 0.1 },
            preview_width = 0.5,
          },
        },
        sorting_strategy = "ascending",
      }
    }
  end
}
