return {
  {
    "folke/snacks.nvim",
    enabled = true,
    event = "VeryLazy",
    dependencies = {
      { 'echasnovski/mini.icons', version = false, event = "VeryLazy" },
    },
    ---@type snacks.Config
    opts = {
      bigfile = { enabled = false },
      dashboard = {
        enabled = true,
        preset = {
          keys = {
            { icon = " ", key = "p", desc = "Find File", action = ":lua Snacks.dashboard.pick('files')" },
            { icon = " ", key = "f", desc = "Find File", action = ":lua Snacks.dashboard.pick('files')" },
            { icon = " ", key = "n", desc = "New File", action = ":ene | startinsert" },
            { icon = " ", key = "g", desc = "Find Text", action = ":lua Snacks.dashboard.pick('live_grep')" },
            { icon = " ", key = "r", desc = "Recent Files", action = ":lua Snacks.dashboard.pick('oldfiles')" },
            { icon = " ", key = "c", desc = "Config", action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})" },
            { icon = " ", key = "s", desc = "Restore Session", section = "session" },
            { icon = "󰒲 ", key = "l", desc = "Lazy", action = ":Lazy", enabled = package.loaded.lazy ~= nil },
            { icon = " ", key = "q", desc = "Quit", action = ":qa" },
          },
        }
      },
      indent = { enabled = false },
      input = { enabled = false },
      notifier = { enabled = false },
      picker = {
        enabled = true,
        matcher = {
          fuzzy = true,          -- use fuzzy matching
          smartcase = true,      -- use smartcase
          ignorecase = true,     -- use ignorecase
          sort_empty = true,     -- sort results when the search string is empty
          filename_bonus = true, -- give bonus for matching file names (last part of the path)
          file_pos = true,       -- support patterns like `file:line:col` and `file:line`
          cwd_bonus = true,      -- give bonus for matching files in the cwd
          frecency = true,       -- frecency bonus
          history_bonus = true,  -- give more weight to chronological order
        },
        icons = {
          files = {
            enabled = true, -- show file icons
          },
          keymaps = {
            nowait = "󰓅 "
          },
          tree = {
            vertical = "│ ",
            middle   = "├╴",
            last     = "└╴",
          },
          undo = {
            saved = " ",
          },
          ui = {
            live       = "󰐰 ",
            hidden     = "h",
            ignored    = "i",
            follow     = "f",
            selected   = "● ",
            unselected = "○ ",
            -- selected = " ",
          },
          git = {
            enabled   = true, -- show git icons
            commit    = "󰜘 ", -- used by git log
            staged    = "●", -- staged changes. always overrides the type icons
            added     = "",
            deleted   = "",
            ignored   = " ",
            modified  = "○",
            renamed   = "",
            unmerged  = " ",
            untracked = "?",
          },
          diagnostics = {
            Error = " ",
            Warn  = " ",
            Hint  = " ",
            Info  = " ",
          },
          kinds = {
            Array         = " ",
            Boolean       = "󰨙 ",
            Class         = " ",
            Color         = " ",
            Control       = " ",
            Collapsed     = " ",
            Constant      = "󰏿 ",
            Constructor   = " ",
            Copilot       = " ",
            Enum          = " ",
            EnumMember    = " ",
            Event         = " ",
            Field         = " ",
            File          = " ",
            Folder        = " ",
            Function      = "󰊕 ",
            Interface     = " ",
            Key           = " ",
            Keyword       = " ",
            Method        = "󰊕 ",
            Module        = " ",
            Namespace     = "󰦮 ",
            Null          = " ",
            Number        = "󰎠 ",
            Object        = " ",
            Operator      = " ",
            Package       = " ",
            Property      = " ",
            Reference     = " ",
            Snippet       = "󱄽 ",
            String        = " ",
            Struct        = "󰆼 ",
            Text          = " ",
            TypeParameter = " ",
            Unit          = " ",
            Unknown       = " ",
            Value         = " ",
            Variable      = "󰀫 ",
          },
        },
      },
      quickfile = { enabled = false },
      -- explorer = {
      --   layout = { layout = { position = "right" } },
      -- },
      scroll = {
        enabled = true,
        animate = {
          duration = { step = 5, total = 30 },
          -- easing = "inOutCubic",
          easing = "outCubic",
        },
        animate_repeat = {
          delay = 1, -- delay in ms before using the repeat animation
          duration = { step = 5, total = 50 },
          easing = "inOutCubic",
        },
      },
      statuscolumn = { enabled = false },
      words = { enabled = false },
    },
    keys = {
      { "<leader>z", function() Snacks.zen() end,            desc = "Toggle Zen Mode" },
      { "<leader>Z", function() Snacks.zen.zoom() end,       desc = "Toggle Zoom" },
      { "<leader>.", function() Snacks.scratch() end,        desc = "Toggle Scratch Buffer" },
      { "<leader>S", function() Snacks.scratch.select() end, desc = "Select Scratch Buffer" },
      {
        "<leader>o",
        function()
          Snacks.explorer({
            hidden = true,
            layout = { layout = { position = "right" } },
          })
        end,
        desc = "Explorer"
      },
      { "<leader>cR", function() Snacks.rename.rename_file() end, desc = "Rename File" },
      { "<leader>gb", function() Snacks.git.blame_line() end,     desc = "Git Blame Line" },
      { "<leader>gg", function() Snacks.lazygit() end,            desc = "Lazygit" },
      { "<leader>un", function() Snacks.notifier.hide() end,      desc = "Dismiss All Notifications" },
      { "<c-/>",      function() Snacks.terminal() end,           desc = "Toggle Terminal" },
      {
        "<leader>f",
        function()
          Snacks.picker.files({
            hidden = true
          })
        end,
        desc = "Find Files"
      },
      {
        "<c-p>",
        function()
          Snacks.picker.files({
            hidden = true
          })
        end,
        desc = "Find Files"
      },
      { "<leader>e", function() Snacks.picker.grep() end,      desc = "Find Files" },
      { "<leader>w", function() Snacks.picker.grep_word() end, desc = "Find Files" },
      { "<leader>r", function() Snacks.picker.recent() end,    desc = "Find Files" },
    },
    init = function()
      -- vim.api.nvim_create_autocmd("User", {
      --   pattern = "VeryLazy",
      --   callback = function()
      --     vim.print = _G.dd -- Override print to use snacks for `:=` command
      --     -- Create some toggle mappings
      --     Snacks.toggle.option("background", { off = "light", on = "dark", name = "Dark Background" }):map("<leader>ub")
      --   end,
      -- })
    end,
  },
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    enabled = true,
    dependencies = {
      "MunifTanjim/nui.nvim",
    },
    opts = {
      messages = {
        view_search = "virtualtext", -- view for search count messages. Set to `false` to disable
      },
      lsp = {
        -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
        progress = {
          enabled = false,
        },
        override = {
          ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
          ["vim.lsp.util.stylize_markdown"] = true,
          ["cmp.entry.get_documentation"] = true,
        },
      },
      -- you can enable a preset for easier configuration
      presets = {
        bottom_search = true,         -- use a classic bottom cmdline for search
        command_palette = false,      -- position the cmdline and popupmenu together
        long_message_to_split = true, -- long messages will be sent to a split
        inc_rename = true,            -- enables an input dialog for inc-rename.nvim
        lsp_doc_border = true,        -- add a border to hover docs and signature help
      },
      cmdline = {
        view = "cmdline",
      },
      views = {
        -- https://github.com/folke/noice.nvim/blob/main/lua/noice/config/views.lua
        mini = {
          timeout = 4000, -- Duration between show() and hide(), in milliseconds
          win_options = {
            winblend = 0,
          },
          winhighlight = {},
          size = {
            width = "auto",
            height = "auto",
            max_height = 2,
          },
        },
      }
    },
    config = function(_, opts)
      require("noice").setup(opts)
      local search = vim.api.nvim_get_hl_by_name("Search", true)
      vim.api.nvim_set_hl(0, 'TransparentSearch', { fg = search.foreground })

      local help = vim.api.nvim_get_hl_by_name("IncSearch", true)
      vim.api.nvim_set_hl(0, 'TransparentHelp', { fg = help.foreground })

      local cmdGroup = 'DevIconLua'
      local noice_cmd_types = {
        CmdLine    = cmdGroup,
        Input      = cmdGroup,
        Lua        = cmdGroup,
        Filter     = cmdGroup,
        Rename     = cmdGroup,
        Substitute = "Define",
        Help       = "TransparentHelp",
        Search     = "TransparentSearch"
      }

      for type, hl in pairs(noice_cmd_types) do
        vim.api.nvim_set_hl(0, "NoiceCmdlinePopupBorder" .. type, { link = hl })
        vim.api.nvim_set_hl(0, "NoiceCmdlineIcon" .. type, { link = hl })
      end
      vim.api.nvim_set_hl(0, "NoiceConfirmBorder", { link = cmdGroup })
    end
  },
  {
    'norcalli/nvim-colorizer.lua',
    event  = "VeryLazy",
    config = function()
      require 'colorizer'.setup()
    end
  },
  {
    "RRethy/vim-illuminate",
    event   = "VeryLazy",
    enabled = false,
    config  = function()
      -- default configuration
      require('illuminate').configure({
        providers = {
          'lsp',
        },
        delay = 100,
        filetype_overrides = {},
        filetypes_denylist = {
          'dirbuf',
          'dirvish',
          'fugitive',
        },
        filetypes_allowlist = {},
        modes_denylist = {},
        modes_allowlist = {},
        providers_regex_syntax_denylist = {},
        providers_regex_syntax_allowlist = {},
        under_cursor = true,
        large_file_cutoff = nil,
        large_file_overrides = nil,
        min_count_to_highlight = 1,
        should_enable = function(bufnr) return true end,
        -- case_insensitive_regex: sets regex case sensitivity
        case_insensitive_regex = false,
      })
      vim.cmd [[
        hi link illuminatedWord CursorLine
        hi link IlluminatedWordText CursorLine
        hi link IlluminatedWordRead CursorLine
        hi link illuminatedCurWord CursorLine
        hi link IlluminatedWordWrite CursorLine
      ]]
    end
  }
}
