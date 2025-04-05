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
    'norcalli/nvim-colorizer.lua',
    event  = "VeryLazy",
    config = function()
      require 'colorizer'.setup()
    end
  },
  {
    "xiyaowong/transparent.nvim",
    event = "VeryLazy",
    enabled = false,
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
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    config = function()
      require("catppuccin").setup({
        flavour = "frappe", -- latte, frappe, macchiato, mocha
        background = {      -- :h background
          light = "latte",
          dark = "frappe",
        },
        transparent_background = true, -- disables setting the background color.
        show_end_of_buffer = false,    -- shows the '~' characters after the end of buffers
        term_colors = true,            -- sets terminal colors (e.g. `g:terminal_color_0`)
        dim_inactive = {
          enabled = false,             -- dims the background color of inactive window
          shade = "dark",
          percentage = 0.15,           -- percentage of the shade to apply to the inactive window
        },
        no_italic = false,             -- Force no italic
        no_bold = false,               -- Force no bold
        no_underline = false,          -- Force no underline
        styles = {                     -- Handles the styles of general hi groups (see `:h highlight-args`):
          comments = { "italic" },     -- Change the style of comments
          conditionals = {},
          loops = {},
          functions = { "bold", "italic" },
          keywords = {},
          strings = {},
          variables = {},
          numbers = {},
          booleans = {},
          properties = {},
          types = { "bold" },
          operators = {},
          -- miscs = {}, -- Uncomment to turn off hard-coded styles
        },
        color_overrides = {},
        custom_highlights = {},
        default_integrations = true,
        integrations = {
          cmp = true,
          gitsigns = true,
          nvimtree = true,
          treesitter = true,
          notify = true,
          native_lsp = {
            enabled = true,
            virtual_text = {
              errors = { "italic" },
              hints = { "italic" },
              warnings = { "italic" },
              information = { "italic" },
              ok = { "italic" },
            },
            underlines = {
              errors = { "underdashed" },
              hints = { "underdashed" },
              warnings = { "underdashed" },
              information = { "underdashed" },
              ok = { "underdashed" },
            },
            -- underlines = {
            --   errors = { "underdotted" },
            --   hints = { "underdotted" },
            --   warnings = { "underdotted" },
            --   information = { "underdotted" },
            --   ok = { "underdotted" },
            -- },
            inlay_hints = {
              background = true,
            },
          },
          snacks = {
            enabled = true,
            indent_scope_color = "lavender", -- catppuccin color (eg. `lavender`) Default: text
          },
          blink_cmp = true,
          mini = {
            enabled = true,
            indentscope_color = "",
          },

          -- For more plugins integrations please scroll down (https://github.com/catppuccin/nvim#integrations)
        },
      })

      vim.cmd.colorscheme "catppuccin"
    end
  },
  {
    "EdenEast/nightfox.nvim",
    lazy = false,
    priority = 1000,
    enabled = false,
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
