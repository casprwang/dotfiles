return {
  'akinsho/bufferline.nvim',
  version = "*",
  event = "VeryLazy",
  -- lazy = false,
  -- priority = 1000,
  dependencies = {
    {
      'nvim-tree/nvim-web-devicons',
      event = "VeryLazy",
      config = function()
        require("nvim-web-devicons").setup({
          default = true,
        })
      end,
    }
  },
  config = function()
    local bufferline = require("bufferline")
    bufferline.setup {
      options = {
        show_close_icon = false,
        show_buffer_close_icons = false,
        mode = "tabs",
        diagnostics = "nvim_lsp",
        style_preset = {
          bufferline.style_preset.minimal
        },
        indicator = {
          icon = "",
          style = "none"
        },
      }
    }
  end
}
