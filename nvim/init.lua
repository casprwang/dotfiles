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
    "mikavilpas/yazi.nvim",
    event = "VeryLazy",
    keys = {
      -- 👇 in this section, choose your own keymappings!
      {
        "<leader>-",
        "<cmd>Yazi<cr>",
        desc = "Open yazi at the current file",
      },
      {
        -- Open in the current working directory
        "<leader>cw",
        "<cmd>Yazi cwd<cr>",
        desc = "Open the file manager in nvim's working directory",
      },
      {
        -- NOTE: this requires a version of yazi that includes
        -- https://github.com/sxyazi/yazi/pull/1305 from 2024-07-18
        '<c-up>',
        "<cmd>Yazi toggle<cr>",
        desc = "Resume the last yazi session",
      },
    },
    ---@type YaziConfig
    opts = {
      -- if you want to open yazi instead of netrw, see below for more info
      open_for_directories = false,
      keymaps = {
        show_help = '<f1>',
      },
    },
  },
  {
    "m-demare/attempt.nvim",
    config = function()
      require('attempt').setup()
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
    "otavioschwanck/arrow.nvim",
    opts = {
      show_icons = true,
      leader_key = ';',        -- Recommended to be a single key
      buffer_leader_key = 'm', -- Per Buffer Mappings
    }
  },
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    opts = {},
    config = function()
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
  },
  {
    {
      "rmagatti/auto-session",
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
    "numToStr/Comment.nvim",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "JoosepAlviste/nvim-ts-context-commentstring",
    },
    keys = {
      "<cmd>CommentToggle<cr>",
      "gc",
      "gcc",
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
    enabled = false,
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
    "ghillb/cybu.nvim",
    event = "VeryLazy",
    config = function()
      require("cybu").setup()
      vim.keymap.set("n", "[b", "<Plug>(CybuPrev)")
      vim.keymap.set("n", "]b", "<Plug>(CybuNext)")
      -- vim.keymap.set("n", "<s-tab>", "<plug>(CybuLastusedPrev)")
      -- vim.keymap.set("n", "<tab>", "<plug>(CybuLastusedNext)")
    end
  },
  {
    'b0o/incline.nvim',
    enabled = false,
    config = function()
      local helpers = require 'incline.helpers'
      local devicons = require 'nvim-web-devicons'
      require('incline').setup {
        hide = {
          focused_win = true,
        },
        window = {
          padding = 0,
          margin = { horizontal = 0 },
          placement = {
            horizontal = 'left',
            vertical = 'top',
          },
        },
        render = function(props)
          local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ':t')
          if filename == '' then
            filename = '[No Name]'
          end
          local ft_icon, ft_color = devicons.get_icon_color(filename)
          local modified = vim.bo[props.buf].modified
          return {
            ft_icon and { ' ', ft_icon, ' ', guibg = ft_color, guifg = helpers.contrast_color(ft_color) } or '',
            ' ',
            { filename, gui = modified and 'bold,italic' or 'bold' },
            ' ',
            guibg = '#44406e',
          }
        end,
      }
    end,
    -- Optional: Lazy load Incline
    event = 'VeryLazy',
  },
  -- { "catppuccin/nvim", name = "catppuccin", priority = 1000 },
  {
    "lukas-reineke/indent-blankline.nvim",
    enabled = false,
    main = "ibl",
    event = "VeryLazy",
    ---@module "ibl"
    ---@type ibl.config
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
  {
    "navarasu/onedark.nvim",
    priority = 1000, -- Ensure it loads first
    config = function()
      require('onedark').load()
    end
  },
  -- {
  --   "olimorris/onedarkpro.nvim",
  --   priority = 1000, -- Ensure it loads first
  -- },
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    enabled = false,
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
            filter = {
              event = "msg_showmode",
              any = {
                { find = "recording" },
              },
            },
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
    "RRethy/vim-illuminate",
    enabled = false,
    event = "VeryLazy",
    config = function()
      -- default configuration
      require('illuminate').configure({
        -- providers: provider used to get references in the buffer, ordered by priority
        providers = {
          'treesitter',
          'regex',
        },
        -- delay: delay in milliseconds
        delay = 10,
        -- filetype_overrides: filetype specific overrides.
        -- The keys are strings to represent the filetype while the values are tables that
        -- supports the same keys passed to .configure except for filetypes_denylist and filetypes_allowlist
        filetype_overrides = {},
        -- filetypes_denylist: filetypes to not illuminate, this overrides filetypes_allowlist
        filetypes_denylist = {
          'dirbuf',
          'dirvish',
          'fugitive',
        },
        -- filetypes_allowlist: filetypes to illuminate, this is overridden by filetypes_denylist
        -- You must set filetypes_denylist = {} to override the defaults to allow filetypes_allowlist to take effect
        filetypes_allowlist = {},
        -- modes_denylist: modes to not illuminate, this overrides modes_allowlist
        -- See `:help mode()` for possible values
        modes_denylist = {},
        -- modes_allowlist: modes to illuminate, this is overridden by modes_denylist
        -- See `:help mode()` for possible values
        modes_allowlist = {},
        -- providers_regex_syntax_denylist: syntax to not illuminate, this overrides providers_regex_syntax_allowlist
        -- Only applies to the 'regex' provider
        -- Use :echom synIDattr(synIDtrans(synID(line('.'), col('.'), 1)), 'name')
        providers_regex_syntax_denylist = {},
        -- providers_regex_syntax_allowlist: syntax to illuminate, this is overridden by providers_regex_syntax_denylist
        -- Only applies to the 'regex' provider
        -- Use :echom synIDattr(synIDtrans(synID(line('.'), col('.'), 1)), 'name')
        providers_regex_syntax_allowlist = {},
        -- under_cursor: whether or not to illuminate under the cursor
        under_cursor = true,
        -- large_file_cutoff: number of lines at which to use large_file_config
        -- The `under_cursor` option is disabled when this cutoff is hit
        large_file_cutoff = nil,
        -- large_file_config: config to use for large files (based on large_file_cutoff).
        -- Supports the same keys passed to .configure
        -- If nil, vim-illuminate will be disabled for large files.
        large_file_overrides = nil,
        -- min_count_to_highlight: minimum number of matches required to perform highlighting
        min_count_to_highlight = 1,
        -- should_enable: a callback that overrides all other settings to
        -- enable/disable illumination. This will be called a lot so don't do
        -- anything expensive in it.
        should_enable = function(bufnr) return true end,
        -- case_insensitive_regex: sets regex case sensitivity
        case_insensitive_regex = false,
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

vim.o.background = "light"
-- vim.cmd([[
--   colorscheme onelight
-- ]])
