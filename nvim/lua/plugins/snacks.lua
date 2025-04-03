local keymap_opts = { noremap = true, silent = true, }

local get_term_opts = function(num)
  return {
    auto_close = false,
    win = {
      wo = {
        winbar = tostring(num),
      },
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
      },
    },
  }
end


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
    { "<leader>gg", function() Snacks.lazygit() end,            desc = "Lazygit" },
    { "<leader>un", function() Snacks.notifier.hide() end,      desc = "Dismiss All Notifications" },
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
      enabled = true
    },
    bigfile = { enabled = false },
    dashboard = {
      enabled = true,
      preset = {
        keys = {
          { icon = " ", key = "p", desc = "Find File", action = ":lua Snacks.dashboard.pick('files')" },
          { icon = " ", key = "e", desc = "Find Text", action = ":lua Snacks.dashboard.pick('live_grep')" },
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
        },
      },
      scope        = {
        enabled = true, -- enable highlighting the current scope
        priority = 200,
        char = "│",
        underline = false,   -- underline the start of the scope
        only_current = true, -- only show scope in the current window
        hl = "Whitespace"
      },
      animate      = { enabled = false, },
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
    scroll = { enabled = true, left = { "mark", "sign" } },
    statuscolumn = { enabled = true, },
    words = { enabled = true },
    zen = { enabled = true },
  },
  init = function()
    vim.g.snacks_animate = false
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

    local term_wins = {
      [1] = nil,
      [2] = nil,
      [3] = nil,
    }

    local last_term_win = nil

    local close_current_term = function()
      local in_terminal = vim.bo.buftype == "terminal"
      if in_terminal and last_term_win then
        last_term_win:hide()
      end
    end

    local toggle_last_term = function()
      local in_terminal = vim.bo.buftype == "terminal"
      if in_terminal and last_term_win then
        last_term_win:hide()
      elseif not in_terminal and last_term_win then
        last_term_win:show()
      elseif not in_terminal and not last_term_win then
        new_term_win = snacks.terminal.open(nil, get_term_opts(1))
        term_wins[1] = new_term_win
        last_term_win = new_term_win
      end
    end

    local toggle_term_by_num = function(num)
      local in_terminal = vim.bo.buftype == "terminal"
      local snacks = require("snacks")
      local curr_term = nil

      -- if a terminal is already open
      --   if the desired terminal is the opened one
      --     hide it
      --   if the desired terminal is not the opened one
      --     hide the opened one
      --     show the desired one, create if necessary
      -- if no terminal is open
      --   show the desired one, create if necessary

      if in_terminal then
        if last_term_win.id == num then
          last_term_win:hide()
        else
          last_term_win:hide()
          if term_wins[num] then
            term_wins[num]:show()
            last_term_win = term_wins[num]
          else
            new_term_win = snacks.terminal.open(nil, get_term_opts(num))
            term_wins[num] = new_term_win
            last_term_win = new_term_win
          end
        end
      else
        if term_wins[num] then
          term_wins[num]:show()
          last_term_win = term_wins[num]
        else
          new_term_win = snacks.terminal.open(nil, get_term_opts(num))
          term_wins[num] = new_term_win
          last_term_win = new_term_win
        end
      end
    end

    vim.keymap.set({ "n", "t", 'i' }, "<c-1>", function() toggle_term_by_num(1) end, keymap_opts)
    vim.keymap.set({ "n", "t", 'i' }, "<c-2>", function() toggle_term_by_num(2) end, keymap_opts)
    vim.keymap.set({ "n", "t", 'i' }, "<c-3>", function() toggle_term_by_num(3) end, keymap_opts)
    vim.keymap.set({ "n", "t", 'i' }, "<c-]>j", function() toggle_last_term() end, keymap_opts)
  end
}
