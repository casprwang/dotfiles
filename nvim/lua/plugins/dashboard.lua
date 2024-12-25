return {
  "nvimdev/dashboard-nvim",
  enabled = false,
  lazy = false,
  config = function()
    require("dashboard").setup({
      theme = "hyper",
      disable_move = false,
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
            action = "Telescope frecency workspace=CWD",
            key = "o",
          },
          {
            desc = " quit",
            group = "DiagnosticHint",
            action = "q",
            key = "q",
          },
          {
            desc = " Old Files",
            group = "DiagnosticHint",
            action = function()
              require('telescope.builtin').oldfiles()
            end,
            key = "i",
          },
        },
      },
    })
  end,
  dependencies = { { "nvim-tree/nvim-web-devicons" } },
}
