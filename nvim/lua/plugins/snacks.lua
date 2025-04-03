local keymap_opts = {
  noremap = true,
  silent = true,
}

local term_opts = {
  auto_close = false,
  win = {
    styles = 'terminal',
    -- position = "float",
    -- minimal = false,
    -- width = 0.8,
    -- height = 0.8,
    -- statuscolumn = ' ',
    -- conceallevel = 3,
    -- wo = {
    --   statusline = " ",
    -- }
  },
}


local function close_other_terminals(win)
  local snacks = require("snacks")
  local terminals = Snacks.terminal.list()
  for _, term in pairs(terminals) do
    if term.buf ~= win.buf then
      term:hide()
    end
  end
end

return {
  "folke/snacks.nvim",
  enabled = true,
  event = "VeryLazy",
  keys = {
    -- { "<c-enter>",  function() Snacks.zen() end,                     desc = "Toggle Zen Mode" },
    { "<c-enter>",  function() Snacks.zen.zoom() end,                desc = "Toggle Zoom" },
    { "<leader>.",  function() Snacks.scratch() end,                 desc = "Toggle Scratch Buffer" },
    { "<leader>S",  function() Snacks.scratch.select() end,          desc = "Select Scratch Buffer" },
    { "<leader>i",  function() Snacks.picker.lsp_symbols() end,      desc = "Select Scratch Buffer" },
    { "gd",         function() Snacks.picker.lsp_definitions() end,  desc = "Goto Definition" },
    { "gD",         function() Snacks.picker.lsp_declarations() end, desc = "Goto Declaration" },
    { "<leader>sk", function() Snacks.picker.keymaps() end,          desc = "Keymaps" },
    {
      "grr",
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
    { "<leader>h",  function() Snacks.picker.help() end,                 desc = "Help Pages" },
    { "gy",         function() Snacks.picker.lsp_type_definitions() end, desc = "Goto T[y]pe Definition" },
    { "<leader>sq", function() Snacks.picker.qflist() end,               desc = "Quickfix List" },
    {
      "gl",
      function()
        vim.diagnostic.open_float()
      end,
      desc = "open float"
    },
    {
      "go",
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
    { "<esc>",      [[<C-\><C-n>]],                             mode = "t",                        desc = "normal mode in terminal" },
    { "<c-[>",      [[<C-\><C-n>]],                             mode = "t",                        desc = "normal mode in terminal" },
    {
      "<c-p>",
      function()
        Snacks.picker.files({
          hidden = true
        })
      end,
      desc = "Find Files"
    },
    -- test
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
            "<esc>",
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
      enabled      = true,
      only_scope   = true,
      only_current = true,
      indent       = {
        char = " ",
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
        --   "SnacksIndent1",
        --   "SnacksIndent2",
        --   "SnacksIndent3",
        --   "SnacksIndent4",
        --   "SnacksIndent5",
        --   "SnacksIndent6",
        --   "SnacksIndent7",
        --   "SnacksIndent8",
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
          Warn  = " ",
          -- Hint  = " ",
          Hint  = " ",
          Info  = " ",
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
      enabled = true,
      left = { "mark", "sign" }
    },
    statuscolumn = {
      enabled = true,
    },
    words = { enabled = true },
    zen = {
    }
  },

  init = function()
    vim.g.snacks_animate = false

    -- vim.api.nvim_create_autocmd("User", {
    --   pattern = "VeryLazy",
    --   callback = function()
    --     vim.print = _G.dd -- Override print to use snacks for `:=` command
    --     -- Create some toggle mappings
    --     Snacks.toggle.option("background", { off = "light", on = "dark", name = "Dark Background" }):map("<leader>ub")
    --   end,
    -- })
  end,
  config = function(_, opts)
    local snacks = require("snacks")
    local function close_other_terminals(win)
      local terminals = Snacks.terminal.list()
      for _, term in pairs(terminals) do
        if term.buf ~= win.buf then
          term:hide()
        end
      end
    end


    snacks.setup(opts)
    --     { "<c-]>j",     function() Snacks.terminal.toggle(nil, term_opts) end, mode = { "n", "t", "i" },          desc = "Toggle Terminal" },

    vim.keymap.set(
      { "n", "t", 'i' },
      "<c-]>j",
      function()
        local snacks = require("snacks")
        local win = snacks.terminal.toggle(nil, term_opts)
        close_other_terminals(win)
        vim.cmd("checktime")
      end,
      keymap_opts
    )


    vim.keymap.set(
      { "n", "t", 'i' },
      "<c-s>",
      function()
        local snacks = require("snacks")
        local win = snacks.terminal.toggle('ipython', term_opts)
        close_other_terminals(win)
        vim.cmd("checktime")
      end,
      keymap_opts
    )
  end
}
