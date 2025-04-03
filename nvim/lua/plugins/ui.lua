return {
  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    event = "VeryLazy",
    enabled = true,
    config = function()
      require('lualine').setup {
        options = {
          theme = 'catppuccin'
        },
        sections = {
          lualine_a = {},
          lualine_b = { { 'filename', path = 4 } },
          lualine_c = { '%=', }, lualine_x = {},
          lualine_y = { 'progress' },
          lualine_z = {
          },
        },
        inactive_sections = {
          lualine_a = { { 'filename', path = 4 } },
          lualine_b = {},
          lualine_c = {},
          lualine_x = {},
          lualine_y = {},
          lualine_z = { 'location' },
        },
        tabline = {},
        extensions = {},
      }
    end
  },
}
