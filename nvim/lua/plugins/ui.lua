return {
  {
    'norcalli/nvim-colorizer.lua',
    event  = "VeryLazy",
    config = function()
      require 'colorizer'.setup()
    end
  },
  {
    "kevinhwang91/nvim-hlslens",
    event = "VeryLazy",
    dependencies = { "petertriho/nvim-scrollbar" },
    enabled = true,
    config = function()
      require('hlslens').setup({
        calm_down = true,
        nearest_only = false,
        nearest_float_when = 'always',
        float_shadow_blend = 0
      })
      local kopts = { noremap = true, silent = true }
      vim.api.nvim_set_keymap('n', 'n',
        [[<Cmd>execute('normal! ' . v:count1 . 'n')<CR><Cmd>lua require('hlslens').start()<CR>]],
        kopts)
      vim.api.nvim_set_keymap('n', 'N',
        [[<Cmd>execute('normal! ' . v:count1 . 'N')<CR><Cmd>lua require('hlslens').start()<CR>]],
        kopts)
      vim.api.nvim_set_keymap('n', '*', [[*<Cmd>lua require('hlslens').start()<CR>]], kopts)
      vim.api.nvim_set_keymap('n', '#', [[#<Cmd>lua require('hlslens').start()<CR>]], kopts)
      vim.api.nvim_set_keymap('n', 'g*', [[g*<Cmd>lua require('hlslens').start()<CR>]], kopts)
      vim.api.nvim_set_keymap('n', 'g#', [[g#<Cmd>lua require('hlslens').start()<CR>]], kopts)
    end,
  },
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
          -- lualine_a = { { 'mode', separator = { left = '' }, right_padding = 0 } },
          lualine_b = { {
            'filename',
            path = 4
          }
          },
          lualine_c = {
            '%=',
          },
          lualine_x = {},
          lualine_y = { 'progress' },
          lualine_z = {
            -- { 'location', separator = { right = '' }, left_padding = 0 },
          },
        },
        inactive_sections = {
          lualine_a = {
            {
              'filename',
              path = 4
            }
          },
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
