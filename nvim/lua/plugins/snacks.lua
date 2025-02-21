return {
  "folke/snacks.nvim",
  enabled = true,
  event = "VeryLazy",
  keys = {
    { "<leader>z",  function() Snacks.zen() end,                     desc = "Toggle Zen Mode" },
    { "<leader>Z",  function() Snacks.zen.zoom() end,                desc = "Toggle Zoom" },
    { "<leader>.",  function() Snacks.scratch() end,                 desc = "Toggle Scratch Buffer" },
    { "<leader>S",  function() Snacks.scratch.select() end,          desc = "Select Scratch Buffer" },
    { "<leader>i",  function() Snacks.picker.lsp_symbols() end,      desc = "Select Scratch Buffer" },
    { "gd",         function() Snacks.picker.lsp_definitions() end,  desc = "Goto Definition" },
    { "gD",         function() Snacks.picker.lsp_declarations() end, desc = "Goto Declaration" },
    { "<leader>sk", function() Snacks.picker.keymaps() end,          desc = "Keymaps" },
    {
      "gr",
      function()
        Snacks.picker.lsp_references({
          win = {
            input = {
              keys = {
                ["<C-t>"] = { "tab", mode = { "n", "i" } },
              },
            }
          },
        })
      end,
      nowait = true,
      desc = "References"
    },
    { "<leader>sc", function() Snacks.picker.colorschemes() end,         desc = "Colorschemes" },
    { "]]",         function() Snacks.words.jump(vim.v.count1) end,      desc = "Next Reference",        mode = { "n", "t" } },
    { "[[",         function() Snacks.words.jump(-vim.v.count1) end,     desc = "Prev Reference",        mode = { "n", "t" } },
    { "gI",         function() Snacks.picker.lsp_implementations() end,  desc = "Goto Implementation" },
    { "<leader>sh", function() Snacks.picker.help() end,                 desc = "Help Pages" },
    { "gy",         function() Snacks.picker.lsp_type_definitions() end, desc = "Goto T[y]pe Definition" },
    { "<leader>sq", function() Snacks.picker.qflist() end,               desc = "Quickfix List" },
    {
      "<leader>o",
      function()
        Snacks.explorer({
          follow_file   = true,
          hidden        = true,
          tree          = true,
          watch         = true,
          git_status    = true,
          git_untracked = true,
          focus         = "list",
          layout        = { layout = { position = "right" } },
          win           = {
            input = {
              keys = {
                ["<C-t>"] = { "tab", mode = { "n", "i" } },
              },
            },
            list = {
              keys = {
                ["<C-t>"] = { "tab", mode = { "n", "i" } },
                ["<BS>"] = "explorer_up",
                ["l"] = "confirm",
                ["h"] = "explorer_close", -- close directory
                ["a"] = "explorer_add",
                ["d"] = "explorer_del",
                ["r"] = "explorer_rename",
                ["c"] = "explorer_copy",
                ["m"] = "explorer_move",
                ["o"] = "explorer_open", -- open with system application
                ["P"] = "toggle_preview",
                ["y"] = "explorer_yank",
                ["."] = "explorer_focus",
                ["I"] = "toggle_ignored",
                ["H"] = "toggle_hidden",
                ["Z"] = "explorer_close_all",
                ["]g"] = "explorer_git_next",
                ["[g"] = "explorer_git_prev",
                ["]d"] = "explorer_diagnostic_next",
                ["[d"] = "explorer_diagnostic_prev",
              },
            },
          },
        })
      end,
      desc = "Explorer"
    },
    { "<leader>cR", function() Snacks.rename.rename_file() end, desc = "Rename File" },
    { "<leader>gb", function() Snacks.git.blame_line() end,     desc = "Git Blame Line" },
    { "<leader>gg", function() Snacks.lazygit() end,            desc = "Lazygit" },
    { "<leader>un", function() Snacks.notifier.hide() end,      desc = "Dismiss All Notifications" },
    { "<c-]>j",     function() Snacks.terminal.toggle() end,    mode = { "n", "t", "i" },          desc = "Toggle Terminal" },
    { "<esc>",      [[<C-\><C-n>]],                             mode = "t",                        desc = "normal mode in terminal" },
    { "<c-[>",      [[<C-\><C-n>]],                             mode = "t",                        desc = "normal mode in terminal" },
    -- { "<left>",     [[<C-\><C-n><C-W>h]],                       mode = "t",                        desc = "Window Movement: Move Left" },
    -- { "<right>",    [[<C-\><C-n><C-W>j]],                       mode = "t",                        desc = "Window Movement: Move Down" },
    -- { "<up>",       [[<C-\><C-n><C-W>k]],                       mode = "t",                        desc = "Window Movement: Move Up" },
    -- { "<down>",     [[<C-\><C-n><C-W>l]],                       mode = "t",                        desc = "Window Movement: Move Right" },
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
  dependencies = {
    { 'echasnovski/mini.icons', version = false, event = "VeryLazy" },
  },
  ---@type snacks.Config
  opts = {
    image = {
      enabled = false
    },
    terminal = {
      win = {
        keys = {
          term_normal = {
            "<esc><esc>",
            function()
              return "<C-\\><C-n>"
            end,
            mode = "t",
            expr = true,
            desc = "Double escape to normal mode",
          },
          -- q = "hide",
          -- ["<esc>"] = "hide",
        },
      },
    },
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
    indent = {
      enabled      = false,
      only_scope   = true,
      only_current = true,
      indent       = {
        char = "│",
        hl = {
          'Whitespace',
          'Whitespace',
          'Whitespace',
          'Whitespace',
          'Whitespace',
          'Whitespace',
          'Whitespace',
          'Whitespace',
          'Whitespace',
          'Whitespace',
          'Whitespace',
          'Whitespace',
          'Whitespace',
          'Whitespace',
          'Whitespace',
          "Whitespace"
        },
      },
      scope        = {
        enabled = true, -- enable highlighting the current scope
        priority = 200,
        char = "│",
        underline = false,   -- underline the start of the scope
        only_current = true, -- only show scope in the current window
        hl = "Whitespace"
        -- can be a list of hl groups to cycle through
        -- hl = {
        --     "SnacksIndent1",
        --     "SnacksIndent2",
        --     "SnacksIndent3",
        --     "SnacksIndent4",
        --     "SnacksIndent5",
        --     "SnacksIndent6",
        --     "SnacksIndent7",
        --     "SnacksIndent8",
        -- },
      },
      animate      = {
        enabled = false,
      },
    },
    input = { enabled = false },
    notifier = { enabled = false },
    picker = {
      win = {
        input = {
          keys = {
            ["<C-t>"] = { "tab", mode = { "n", "i" } },
            ["<C-c>"] = { "close", mode = { "n", "i" } },
          },
        }
      },
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
    scroll = {
      enabled = false,
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
    words = { enabled = true },
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
}
