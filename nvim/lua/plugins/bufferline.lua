return {
  'akinsho/bufferline.nvim',
  version = "*",
  dependencies = 'nvim-tree/nvim-web-devicons',
  config = function()
    require("bufferline").setup {
      options = {
        show_close_icon = false,
        show_buffer_close_icons = false,
        mode = "tabs",
        diagnostics = "coc",
        diagnostics_update_in_insert = true,
      }
    }
  end
}
