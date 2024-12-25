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
    'stevearc/dressing.nvim',
    opts = {},
  },
  {
    'mvllow/modes.nvim',
    version = 'v0.2.1',
    config = function()
      require('modes').setup({
        colors = {
          bg = "", -- Optional bg param, defaults to Normal hl group
          copy = "#f5c359",
          delete = "#c75c6a",
          insert = "#78ccc5",
          visual = "#9745be",
        },

        -- Set opacity for cursorline and number background
        line_opacity = 0.15,

        -- Enable cursor highlights
        set_cursor = true,

        -- Enable cursorline initially, and disable cursorline for inactive windows
        -- or ignored filetypes
        set_cursorline = true,

        -- Enable line number highlights to match cursorline
        set_number = true,

        -- Disable modes highlights in specified filetypes
        -- Please PR commonly ignored filetypes
        ignore_filetypes = { 'NvimTree', 'TelescopePrompt' }
      })
    end
  },
  {
    "christoomey/vim-tmux-navigator",
    cmd = {
      "TmuxNavigateLeft",
      "TmuxNavigateDown",
      "TmuxNavigateUp",
      "TmuxNavigateRight",
      "TmuxNavigatePrevious",
    },
    keys = {
      { "<left>",  "<cmd><C-U>TmuxNavigateLeft<cr>" },
      { "<down>",  "<cmd><C-U>TmuxNavigateDown<cr>" },
      { "<Up>",    "<cmd><C-U>TmuxNavigateUp<cr>" },
      { "<right>", "<cmd><C-U>TmuxNavigateRight<cr>" },
    },
  },
  {
    "dstein64/vim-startuptime",
    cmd = "StartupTime",
    init = function()
      vim.g.startuptime_tries = 10
    end,
  },
  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    event = "VeryLazy",
    ft = { "markdown" },
    build = function()
      vim.fn["mkdp#util#install"]()
    end,
  },
  {
    "junegunn/fzf",
    event = "VeryLazy",
    build = "./install --bin",
  },
  {
    {
      "rmagatti/auto-session",
      enabled = false,
      dependencies = {
        "nvim-telescope/telescope.nvim", -- Only needed if you want to use sesssion lens
      },
      config = function()
        require("auto-session").setup({
          auto_session_suppress_dirs = { "~/", "~/Projects", "~/Downloads", "/" },
        })
      end,
    },
  },
  {
    "mrjones2014/smart-splits.nvim",
    lazy = false,
    config = function()
      require("smart-splits").setup({
        -- add any options here
      })
      vim.keymap.set("n", "<Right>", require("smart-splits").move_cursor_right)
      vim.keymap.set("n", "<Left>", require("smart-splits").move_cursor_left)
      vim.keymap.set("n", "<Up>", require("smart-splits").move_cursor_up)
      vim.keymap.set("n", "<Down>", require("smart-splits").move_cursor_down)
      vim.keymap.set("n", "<A-Left>", require("smart-splits").resize_left)
      vim.keymap.set("n", "<A-Down>", require("smart-splits").resize_down)
      vim.keymap.set("n", "<A-Up>", require("smart-splits").resize_up)
      vim.keymap.set("n", "<A-Right>", require("smart-splits").resize_right)
    end,
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
    "folke/flash.nvim",
    event = "VeryLazy",
    opts = {},
    -- stylua: ignore
    keys = {
      -- { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end,       desc = "Flash" },
      -- { "S", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
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
      -- disable indentation on the first level
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
