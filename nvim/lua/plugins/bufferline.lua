return {
  {
    'akinsho/bufferline.nvim',
    version = "*",
    dependencies = { 'nvim-tree/nvim-web-devicons', event = "VeryLazy" },
    event = "VeryLazy",
    config = function()
      local bufferline = require("bufferline")
      bufferline.setup {
        options = {
          show_close_icon = false,
          show_buffer_icons = true,
          show_buffer_close_icons = false,
          mode = "tabs",
          diagnostics = "nvim_lsp", -- nvim_lsp
          style_preset = {
            bufferline.style_preset.minimal,
            bufferline.style_preset.no_italic,
          },
          indicator = {
            icon = "",
            style = "none"
          },
        }
      }
    end
  }
}
