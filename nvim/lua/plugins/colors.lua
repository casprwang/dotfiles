local function fixGruvbox()
  vim.cmd([[
    hi! SignColumn guibg=NONE
    hi! WinBar guibg=NONE
    hi! WinBarNC guibg=NONE
    hi! DiagnosticSignOk guifg=#b8bb26 guibg=#282828
    hi! DiagnosticSignInfo guifg=#83a598 guibg=#282828
    hi! DiagnosticSignWarn guifg=#fabd2f guibg=#282828
    hi! DiagnosticSignError guifg=#fb4934 guibg=#282828
    hi! SagaNormal guibg=#282828
    hi! FzfLuaBackdrop guibg=NONE
    hi! NormalFloat guibg=none
  ]])
  vim.api.nvim_set_hl(0, "StatusLine", { reverse = false })
  vim.api.nvim_set_hl(0, "StatusLineNC", { reverse = false })
  vim.api.nvim_set_hl(0, "SignColumn", { reverse = false })
end


return {
  {
    "ellisonleao/gruvbox.nvim",
    priority = 1000,
    lazy = false,
    config = function()
      vim.cmd([[
        colorscheme gruvbox
        hi! SignColumn guibg=NONE
      ]])
      fixGruvbox()
    end
  },
  {
    "f-person/auto-dark-mode.nvim",
    priority = 1000,
    lazy = false,
    opts = {
      update_interval = 6000,
      set_dark_mode = function()
        vim.api.nvim_set_option_value("background", "dark", {})
        require("../utils").write("dark")
        require("../utils").set_fzf_opts_dark()
        fixGruvbox()
      end,
      set_light_mode = function()
        vim.api.nvim_set_option_value("background", "light", {})
        require("../utils").write("light")
        require("../utils").set_fzf_opts_light()
        fixGruvbox()
      end,
    },
  }
}
