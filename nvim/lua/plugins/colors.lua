local function fixGruvbox()
  vim.cmd([[ hi! SignColumn guibg=NONE ]])
  vim.cmd([[
    hi! CocErrorSign guibg=NONE
    hi! CocInfoSign guibg=NONE
    hi! CocWarningSign guifg=NONE
  ]])
  vim.cmd([[ hi! WinBar guibg=NONE ]])
  vim.cmd([[ hi! WinBarNC guibg=NONE ]])
  vim.cmd([[ hi! DiagnosticSignOk guifg=#b8bb26 guibg=#282828 ]])
  vim.cmd([[ hi! DiagnosticSignInfo guifg=#83a598 guibg=#282828 ]])
  vim.cmd([[ hi! DiagnosticSignWarn guifg=#fabd2f guibg=#282828 ]])
  vim.cmd([[ hi! DiagnosticSignError guifg=#fb4934 guibg=#282828 ]])
  vim.cmd([[ hi! SagaNormal guibg=#282828 ]])
  vim.api.nvim_set_hl(0, "StatusLine", { reverse = false })
  vim.api.nvim_set_hl(0, "StatusLineNC", { reverse = false })
end


return {
  {

    "ellisonleao/gruvbox.nvim",
    priority = 1000,
    lazy = false,
    config = function()
      fixGruvbox()
      vim.o.background = 'dark'
      vim.cmd([[ hi! SignColumn guibg=NONE ]])
      vim.cmd([[
        colorscheme gruvbox
      ]])
    end
  },
  {
    "f-person/auto-dark-mode.nvim",
    opts = {
      update_interval = 1000,
      set_dark_mode = function()
        vim.api.nvim_set_option_value("background", "dark", {})
        fixGruvbox()
        vim.env.FZF_DEFAULT_OPTS =
        "--color=bg+:#ebdbb2,bg:#fbf1c7,spinner:#427b58,hl:#076678 --color=fg:#665c54,header:#076678,info:#b57614,pointer:#427b58 --color=marker:#427b58,fg+:#3c3836,prompt:#b57614,hl+:#076678 --color=bg+:#3c3836,bg:#282828,spinner:#8ec07c,hl:#83a598 --color=fg:#bdae93,header:#83a598,info:#fabd2f,pointer:#8ec07c --color=marker:#8ec07c,fg+:#ebdbb2,prompt:#fabd2f,hl+:#83a598"
      end,
      set_light_mode = function()
        vim.api.nvim_set_option_value("background", "light", {})
        fixGruvbox()
        vim.env.FZF_DEFAULT_OPTS =
        "--color=bg+:#ebdbb2,bg:#fbf1c7,spinner:#427b58,hl:#076678 --color=fg:#665c54,header:#076678,info:#b57614,pointer:#427b58 --color=marker:#427b58,fg+:#3c3836,prompt:#b57614,hl+:#076678 --color=bg+:#ebdbb2,bg:#fbf1c7,spinner:#427b58,hl:#076678 --color=fg:#665c54,header:#076678,info:#b57614,pointer:#427b58 --color=marker:#427b58,fg+:#3c3836,prompt:#b57614,hl+:#076678"
      end,
    },
  }
}
