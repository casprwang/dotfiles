return {
  "nvimdev/dashboard-nvim",
  event = "VimEnter",
  config = function()
    require("dashboard").setup({
      theme = "hyper",
      config = {
        week_header = {
          enable = false,
        },
        shortcut = {
          { desc = "󰊳 Update", group = "@property", action = "Lazy update", key = "u" },
          {
            icon = " ",
            icon_hl = "@variable",
            desc = "Files",
            group = "Label",
            action = "FzfLua files header=false",
            key = "f",
          },
          {
            desc = " quit",
            group = "DiagnosticHint",
            action = "q",
            key = "q",
          },
          {
            desc = " session",
            group = "DiagnosticHint",
            action = "SessionRestore",
            key = "l",
          },
        },
      },
    })
  end,
  dependencies = { { "nvim-tree/nvim-web-devicons" } },
}
