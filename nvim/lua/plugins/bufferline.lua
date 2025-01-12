-- function _G.qweqweqwe()
--   return "this is my line"
-- end
-- vim.opt.tabline = "%!v:lua.qweqweqwe()"
-- vim.opt.showtabline = 2

return {
  {
    'casprwang/bufferline.nvim',
    version = "*",
    event = "VeryLazy",
    config = function()
      local bufferline = require("bufferline")
      bufferline.setup {
        options = {
          show_close_icon = false,
          show_buffer_icons = false,
          show_buffer_close_icons = false,
          mode = "tabs",
          diagnostics = "", -- nvim_lsp
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
}
