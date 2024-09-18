return {
  "nvim-lualine/lualine.nvim",
  enabled = true,
  event = "VeryLazy",
  config = function()
    require("lualine").setup({
      options = {
        theme = "tokyonight",
        section_separators = { "", "" },
        component_separators = { "", "" },
      },
      sections = {
        lualine_a = {},
        lualine_b = { "branch", "diff", "diagnostics" },
        lualine_c = { { "filename", path = 1 } },
        lualine_x = {},
        lualine_y = { 'progress' },
        lualine_z = { 'location' }
      },
    })
  end,
}
