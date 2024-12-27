return {
  'akinsho/bufferline.nvim',
  version = "*",
  dependencies = 'nvim-tree/nvim-web-devicons',
  config = function()
    local bufferline = require("bufferline")
    bufferline.setup {
      options = {
        show_close_icon = false,
        show_buffer_close_icons = false,
        mode = "tabs",
        diagnostics = "",
        diagnostics_update_in_insert = true,
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
