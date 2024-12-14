return {
  "nvim-lualine/lualine.nvim",
  enabled = true,
  event = "VeryLazy",
  config = function()
    require("lualine").setup({
      options = {
        theme = "gruvbox",
        section_separators = { "", "" },
        component_separators = { "", "" },
      },
      sections = {
        lualine_a = {},
        lualine_b = { "diff", "diagnostics" },
        lualine_c = { { "filename", path = 1 } },
        lualine_x = {},
        lualine_y = { 'location', 'progress' },
        lualine_z = {}
      },
      inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { 'filename' },
        lualine_x = { 'location' },
        lualine_y = {},
        lualine_z = {}
      },
      tabline = {},
      winbar = {},
      inactive_winbar = {},
      extensions = {}
    })
    vim.api.nvim_set_hl(0, "StatusLine", { reverse = false })
    vim.api.nvim_set_hl(0, "StatusLineNC", { reverse = false })
    vim.api.nvim_set_hl(0, "StatusLine", { reverse = false })
    vim.api.nvim_set_hl(0, "StatusLineNC", { reverse = false })
  end,
}
