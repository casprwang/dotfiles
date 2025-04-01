return {
  {
    "tpope/vim-fugitive",
    event = "VeryLazy",
    config = function()
    end
  },
  {
    "kevinhwang91/nvim-hlslens",
    event = "VeryLazy",
    dependencies = { "petertriho/nvim-scrollbar" },
    config = function()
      require("scrollbar.handlers.search").setup({
        calm_down = true
      })
      local kopts = { noremap = true, silent = true }

      vim.api.nvim_set_keymap('n', 'n',
        [[<Cmd>execute('normal! ' . v:count1 . 'n')<CR><Cmd>lua require('hlslens').start()<CR>]],
        kopts)
      vim.api.nvim_set_keymap('n', 'N',
        [[<Cmd>execute('normal! ' . v:count1 . 'N')<CR><Cmd>lua require('hlslens').start()<CR>]],
        kopts)
      vim.api.nvim_set_keymap('n', '*', [[*<Cmd>lua require('hlslens').start()<CR>]], kopts)
      vim.api.nvim_set_keymap('n', '#', [[#<Cmd>lua require('hlslens').start()<CR>]], kopts)
      vim.api.nvim_set_keymap('n', 'g*', [[g*<Cmd>lua require('hlslens').start()<CR>]], kopts)
      vim.api.nvim_set_keymap('n', 'g#', [[g#<Cmd>lua require('hlslens').start()<CR>]], kopts)

      vim.api.nvim_set_keymap('n', '<Leader>l', '<Cmd>noh<CR>', kopts)
      vim.cmd [[
      hi default link HlSearchNear CurSearch
      hi default link HlSearchLens WildMenu
      hi default link HlSearchLensNear CurSearch
      hi! ScrollbarSearch guifg=Orange
      hi! ScrollbarSearchHandle guifg=Orange
      ]]
    end,
  },
  {
    "lewis6991/gitsigns.nvim",
    event = "VeryLazy",
    enabled = true,
    dependencies = {
      "petertriho/nvim-scrollbar",
      event = "VeryLazy",
      config = function()
        require("scrollbar").setup({
          show = true,
          show_in_active_only = true,
          set_highlights = true,
          folds = 1000,               -- handle folds, set to number to disable folds if no. of lines in buffer exceeds this
          max_lines = false,          -- disables if no. of lines in buffer exceeds this
          hide_if_all_visible = true, -- Hides everything if all lines are visible
          throttle_ms = 100,
          handle = {
            text = " ",
            blend = 30,                 -- Integer between 0 and 100. 0 for fully opaque and 100 to full transparent. Defaults to 30.
            color = nil,
            color_nr = nil,             -- cterm
            highlight = "CursorColumn",
            hide_if_all_visible = true, -- Hides handle if all lines are visible
          },
          marks = {
            Cursor = {
              text = " ",
              priority = 0,
              gui = nil,
              color = nil,
              cterm = nil,
              color_nr = nil, -- cterm
              highlight = "Normal",
            },
            Search = {
              text = { "-", "=" },
              priority = 1,
              gui = nil,
              color = nil,
              cterm = nil,
              color_nr = nil, -- cterm
              highlight = "Search",
            },
            Error = {
              text = { "-", "=" },
              priority = 2,
              gui = nil,
              color = nil,
              cterm = nil,
              color_nr = nil, -- cterm
              highlight = "DiagnosticVirtualTextError",
            },
            Warn = {
              text = { "-", "=" },
              priority = 3,
              gui = nil,
              color = nil,
              cterm = nil,
              color_nr = nil, -- cterm
              highlight = "DiagnosticVirtualTextWarn",
            },
            Info = {
              text = { "-", "=" },
              priority = 4,
              gui = nil,
              color = nil,
              cterm = nil,
              color_nr = nil, -- cterm
              highlight = "DiagnosticVirtualTextInfo",
            },
            Hint = {
              text = { "-", "=" },
              priority = 5,
              gui = nil,
              color = nil,
              cterm = nil,
              color_nr = nil, -- cterm
              highlight = "DiagnosticVirtualTextHint",
            },
            Misc = {
              text = { "-", "=" },
              priority = 6,
              gui = nil,
              color = nil,
              cterm = nil,
              color_nr = nil, -- cterm
              highlight = "Normal",
            },
            GitAdd = {
              text = "┆",
              priority = 7,
              gui = nil,
              color = nil,
              cterm = nil,
              color_nr = nil, -- cterm
              highlight = "GitSignsAdd",
            },
            GitChange = {
              text = "┆",
              priority = 7,
              gui = nil,
              color = nil,
              cterm = nil,
              color_nr = nil, -- cterm
              highlight = "GitSignsChange",
            },
            GitDelete = {
              text = "▁",
              priority = 7,
              gui = nil,
              color = nil,
              cterm = nil,
              color_nr = nil, -- cterm
              highlight = "GitSignsDelete",
            },
          },
          excluded_buftypes = {
            "terminal",
          },
          excluded_filetypes = {
            "dropbar_menu",
            "dropbar_menu_fzf",
            "DressingInput",
            "cmp_docs",
            "cmp_menu",
            "noice",
            "prompt",
            "TelescopePrompt",
          },
          autocmd = {
            render = {
              "BufWinEnter",
              "TabEnter",
              "TermEnter",
              "WinEnter",
              "CmdwinLeave",
              "TextChanged",
              "VimResized",
              "WinScrolled",
            },
            clear = {
              "BufWinLeave",
              "TabLeave",
              "TermLeave",
              "WinLeave",
            },
          },
          handlers = {
            cursor = true,
            diagnostic = true,
            gitsigns = false, -- Requires gitsigns
            handle = true,
            search = false,   -- Requires hlslens
            ale = false,      -- Requires ALE
          },
        })
        -- require("scrollbar.handlers.search").setup({
        --   override_lens = function() end,
        -- })
      end
    },
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
        signcolumn = false, -- Toggle with `:Gitsigns toggle_signs`
        on_attach = function(bufnr)
          local gitsigns = require('gitsigns')
          local function map(mode, l, r, opts)
            opts = opts or {}
            opts.buffer = bufnr
            vim.keymap.set(mode, l, r, opts)
          end

          -- Navigation
          map('n', ']h', function()
            if vim.wo.diff then
              vim.cmd.normal({ ']h', bang = true })
            else
              gitsigns.nav_hunk('next')
            end
          end)

          map('n', '[h', function()
            if vim.wo.diff then
              vim.cmd.normal({ '[h', bang = true })
            else
              gitsigns.nav_hunk('prev')
            end
          end)

          -- Actions
          map('n', '<leader>hs', gitsigns.stage_hunk)
          map('n', '<leader>hr', gitsigns.reset_hunk)
          map('v', '<leader>hs', function() gitsigns.stage_hunk { vim.fn.line('.'), vim.fn.line('v') } end)
          map('v', '<leader>hr', function() gitsigns.reset_hunk { vim.fn.line('.'), vim.fn.line('v') } end)
          map('n', '<leader>hS', gitsigns.stage_buffer)
          map('n', '<leader>hu', gitsigns.undo_stage_hunk)
          map('n', '<leader>hR', gitsigns.reset_buffer)
          map('n', '<leader>hp', gitsigns.preview_hunk)
          map('n', '<leader>hb', function() gitsigns.blame_line { full = true } end)
          map('n', '<leader>tb', gitsigns.toggle_current_line_blame)
          map('n', '<leader>hd', gitsigns.diffthis)
          map('n', '<leader>hD', function() gitsigns.diffthis('~') end)
          map('n', '<leader>td', gitsigns.toggle_deleted)

          -- Text object
          map({ 'o', 'x' }, 'ih', ':<C-U>Gitsigns select_hunk<CR>')
        end
      })
      require("scrollbar.handlers.gitsigns").setup()
    end,
  },
}
