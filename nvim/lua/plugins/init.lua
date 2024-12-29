return {
  {
    "tpope/vim-rails",
    event = "VeryLazy",
    config = function()
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "eruby.yaml",
        command = "set filetype=yaml",
      })
    end
  },
  {
    event = "VeryLazy",
    'stevearc/dressing.nvim',
  },
  {
    "dstein64/vim-startuptime",
    cmd = "StartupTime",
    init = function()
      vim.g.startuptime_tries = 10
    end,
  },
  {
    "junegunn/fzf",
    event = "VeryLazy",
    build = "./install --bin",
  },
  {
    "nvim-tree/nvim-web-devicons",
    config = function()
      require("nvim-web-devicons").setup({
        default = true,
      })
    end,
  },
  {
    "chrisgrieser/nvim-various-textobjs",
    event = "VeryLazy",
    opts = {
      keymaps = {
        useDefaults = true
      }
    },
  },
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    keys = {
      { "r", mode = "o", function() require("flash").remote() end, desc = "Remote Flash" },
      {
        "R",
        mode = { "o", "x" },
        function() require("flash").treesitter_search() end,
        desc =
        "Treesitter Search"
      },
      {
        "<c-s>",
        mode = { "c" },
        function() require("flash").toggle() end,
        desc =
        "Toggle Flash Search"
      },
    },
  },
  {
    "lukas-reineke/indent-blankline.nvim",
    enabled = false,
    main = "ibl",
    event = "VeryLazy",
    opts = {},
    config = function()
      local hooks = require("ibl.hooks")
      vim.api.nvim_set_hl(0, 'CurrentScope', { fg = "#3b4261" })
      vim.api.nvim_set_hl(0, 'ContextScope', { fg = "#252937" })
      hooks.register(hooks.type.WHITESPACE, hooks.builtin.hide_first_space_indent_level)
      hooks.register(hooks.type.WHITESPACE, hooks.builtin.hide_first_tab_indent_level)
      require("ibl").setup({
        indent = {
          char = "¦", -- This is a slightly thinner char than the default one, check :help ibl.config.indent.char
          highlight = { "ContextScope" }
        },
        scope = {
          show_start = false,
          highlight = 'CurrentScope',
          show_end = false,
        },
      })
    end
  },
}
