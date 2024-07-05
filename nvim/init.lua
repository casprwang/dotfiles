require("settings")
require("keymaps")
require("autocmd")

-- Lazy.vim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)
-- End of lazy.vim

require("lazy").setup({
  {
    import = "plugins",
  },
  {
    'petertriho/nvim-scrollbar',
    event = "VeryLazy",
    config = function()
      require("scrollbar").setup()
    end,
  },
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    opts = {},
    config = function()
      vim.o.background = "dark"
      vim.cmd([[colorscheme tokyonight-storm]])
    end,
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
    build = "./install --bin"
  },
  {
    'nvimdev/dashboard-nvim',
    event = 'VimEnter',
    config = function()
      require('dashboard').setup {
        theme = 'hyper',
        config = {
          week_header = {
            enable = false,
          },
          shortcut = {
            { desc = '󰊳 Update', group = '@property', action = 'Lazy update', key = 'u' },
            {
              icon = ' ',
              icon_hl = '@variable',
              desc = 'Files',
              group = 'Label',
              action = 'FzfLua files header=false',
              key = 'f',
            },
            {
              desc = ' quit',
              group = 'DiagnosticHint',
              action = 'q',
              key = 'q',
            },
            {
              desc = ' session',
              group = 'DiagnosticHint',
              action = 'SessionLoad',
              key = 'l',
            },
          },
        },
      }
    end,
    dependencies = { { 'nvim-tree/nvim-web-devicons' } }
  },
  {
    "olimorris/persisted.nvim",
    lazy = false, -- make sure the plugin is always loaded at startup
    config = function()
      require("persisted").setup({
        save_dir = vim.fn.expand(vim.fn.stdpath("data") .. "/sessions/"), -- directory where session files are saved
        silent = false,                                                   -- silent nvim message when sourcing session file
        use_git_branch = false,                                           -- create session files based on the branch of a git enabled repository
        default_branch = "main",                                          -- the branch to load if a session file is not found for the current branch
        autosave = true,                                                  -- automatically save session files when exiting Neovim
        should_autosave = nil,                                            -- function to determine if a session should be autosaved
        autoload = false,                                                 -- automatically load the session for the cwd on Neovim startup
        on_autoload_no_session = nil,                                     -- function to run when `autoload = true` but there is no session to load
        follow_cwd = true,                                                -- change session file name to match current working directory if it changes
        allowed_dirs = nil,                                               -- table of dirs that the plugin will auto-save and auto-load from
        ignored_dirs = nil,                                               -- table of dirs that are ignored when auto-saving and auto-loading
        ignored_branches = nil,                                           -- table of branch patterns that are ignored for auto-saving and auto-loading
      })
    end
  },
  {
    'mrjones2014/smart-splits.nvim',
    lazy = false,
    config = function()
      require('smart-splits').setup({
        -- add any options here
      })
      vim.keymap.set('n', '<Right>', require('smart-splits').move_cursor_right)
      vim.keymap.set('n', '<Left>', require('smart-splits').move_cursor_left)
      vim.keymap.set('n', '<Up>', require('smart-splits').move_cursor_up)
      vim.keymap.set('n', '<Down>', require('smart-splits').move_cursor_down)
      vim.keymap.set('n', '<A-Left>', require('smart-splits').resize_left)
      vim.keymap.set('n', '<A-Down>', require('smart-splits').resize_down)
      vim.keymap.set('n', '<A-Up>', require('smart-splits').resize_up)
      vim.keymap.set('n', '<A-Right>', require('smart-splits').resize_right)
    end
  },
  {
    "nvim-tree/nvim-web-devicons",
    config = function()
      require("nvim-web-devicons").setup({
        default = true,
      })
    end,
    keys   = {
      { "<leader>,", "<cmd>Neotree toggle<cr>", desc = "NeoTree" },
    },
  },
  {
    "numToStr/Comment.nvim",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "JoosepAlviste/nvim-ts-context-commentstring",
    },
    keys = {
      "<cmd>CommentToggle<cr>",
      "gc",
      "gcc"
    },
    config = function()
      local prehook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook()
      require("Comment").setup({
        pre_hook = prehook,
      })
    end,
  },
  {
    "zbirenbaum/copilot.lua",
    event = "InsertEnter",
    config = function()
      require("copilot").setup({
        suggestion = {
          auto_trigger = true,
          keymap = {
            accept = false,
          },
        },
      })
      vim.keymap.set("i", "<Tab>", function()
        if require("copilot.suggestion").is_visible() then
          require("copilot.suggestion").accept()
        else
          vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Tab>", true, false, true), "n", false)
        end
      end, { desc = "Super Tab" })
    end,
  },
  {
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
          lualine_c = { "filename" },
          lualine_x = {},
          lualine_y = {},
          lualine_z = {},
        },
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
    "folke/noice.nvim",
    event = "VeryLazy",
    opts = {
      -- add any options here
    },
    dependencies = {
      -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
      "MunifTanjim/nui.nvim",
      -- OPTIONAL:
      --   `nvim-notify` is only needed, if you want to use the notification view.
      --   If not available, we use `mini` as the fallback
      "rcarriga/nvim-notify",
    },
    config = function()
      require("noice").setup({
        routes = {
          {
            view = "notify",
            filter = { event = "msg_showmode" },
          },
        },
        lsp = {
          -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
          override = {
            ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
            ["vim.lsp.util.stylize_markdown"] = true,
            ["cmp.entry.get_documentation"] = true, -- requires hrsh7th/nvim-cmp
          },
        },
        -- you can enable a preset for easier configuration
        presets = {
          bottom_search = true,         -- use a classic bottom cmdline for search
          command_palette = true,       -- position the cmdline and popupmenu together
          long_message_to_split = true, -- long messages will be sent to a split
          inc_rename = false,           -- enables an input dialog for inc-rename.nvim
          lsp_doc_border = false,       -- add a border to hover docs and signature help
        },
      })
    end,
  },
  {
    "lewis6991/gitsigns.nvim",
    event = "VeryLazy",
    enabled = false,
    config = function()
      require("gitsigns").setup({
        signs = {
          add = { text = "│" },
          change = { text = "│" },
          delete = { text = "│" },
          topdelete = { text = "│" },
          changedelete = { text = "│" },
          untracked = { text = "│" },
        },
      })
    end,
  },
})
