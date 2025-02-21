local function reset()
  vim.cmd [[
    hi! SignColumn guibg=NONE
    hi! WinBar guibg=NONE
    hi! WinBarNC guibg=NONE
    hi! DiagnosticSignOk guifg=#b8bb26 guibg=#282828
    hi! DiagnosticSignInfo guifg=#83a598 guibg=#282828
    hi! DiagnosticSignWarn guifg=#fabd2f guibg=#282828
    hi! DiagnosticSignError guifg=#fb4934 guibg=#282828
    hi! SagaNormal guibg=#282828
    hi! TabLineFill guibg=NONE

    hi link IlluminatedWord CursorLine
    hi link IlluminatedWordText CursorLine
    hi link IlluminatedWordRead CursorLine
    hi link illuminatedCurWord CursorLine
    hi link IlluminatedWordWrite CursorLine
  ]]
end

return {
  {
    "xiyaowong/transparent.nvim",
    event = "VeryLazy",
    enabled = true,
    config = function()
      require("transparent").setup({
        extra_groups = {
          "NormalFloat",   -- plugins which have float panel such as Lazy, Mason, LspInfo
          "NvimTreeNormal" -- NvimTree
        },
        exclude_groups = { "CursorLine" },
      })
      vim.g.transparent_enabled = true
    end
  },
  {
    "zenbones-theme/zenbones.nvim",
    enabled = false,
    dependencies = "rktjmp/lush.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      vim.cmd([[
        set termguicolors
        set background=light " or dark
        colorscheme zenbones
      ]])
      reset()
    end
  },
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    enabled = false,
    config = function()
      vim.cmd([[
        set termguicolors
        set background=dark " or dark
        colorscheme tokyonight
      ]])
      reset()
    end
  },
  {
    "EdenEast/nightfox.nvim",
    lazy = false,
    priority = 1000,
    enabled = true,
    config = function()
      require("nightfox").setup({
        options = {
          transparent = true,     -- Disable setting background
          terminal_colors = true, -- Set terminal colors (vim.g.terminal_color_*) used in `:terminal`
          dim_inactive = false,   -- Non focused panes set to alternative background
          module_default = true,  -- Default enable value for modules
          styles = {              -- Style to be applied to different syntax groups
            comments = "NONE",    -- Value is any valid attr-list value `:help attr-list`
            conditionals = "bold",
            constants = "bold",
            functions = "bold,italic",
            keywords = "bold",
            numbers = "NONE",
            operators = "NONE",
            strings = "NONE",
            types = "bold",
            variables = "NONE",
          },
        },
        palettes = {},
        specs = {},
        groups = {},
      })
      vim.cmd("colorscheme nordfox")
      reset()
    end
  },
  {
    'shaunsingh/nord.nvim',
    priority = 1000,
    lazy = false,
    enabled = false,
    config = function()
      vim.cmd([[
        colorscheme nord
      ]])
      reset()
    end
  },
  {
    "ellisonleao/gruvbox.nvim",
    priority = 1000,
    enabled = false,
    lazy = false,
    config = function()
      require("gruvbox").setup({
        contrast = "",
      })
      vim.cmd([[
        colorscheme gruvbox
        hi! SignColumn guibg=NONE
      ]])
      reset()
    end
  },
}
