return {
  'akinsho/bufferline.nvim',
  version = "*",
  enabled = true,
  dependencies = 'nvim-tree/nvim-web-devicons',
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
          style = 'underline'
        },
      }
    }
  end
}
