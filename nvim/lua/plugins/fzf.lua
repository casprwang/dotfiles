return {
  "ibhagwan/fzf-lua",
  event = "VeryLazy",
  -- optional for icon support
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    require("fzf-lua").setup({
      winopts  = {
        -- split         = "belowright new",-- open in a split instead?
        -- "belowright new"  : split below
        -- "aboveleft new"   : split above
        -- "belowright vnew" : split right
        -- "aboveleft vnew   : split left
        -- Only valid when using a float window
        -- (i.e. when 'split' is not defined, default)
        height     = 0.85, -- window height
        width      = 0.80, -- window width
        row        = 0.35, -- window row position (0=top, 1=bottom)
        col        = 0.50, -- window col position (0=left, 1=right)
        -- border argument passthrough to nvim_open_win(), also used
        -- to manually draw the border characters around the preview
        -- window, can be set to 'false' to remove all borders or to
        -- 'none', 'single', 'double', 'thicc' (+cc) or 'rounded' (default)
        border     = { '╭', '─', '╮', '│', '╯', '─', '╰', '│' },
        -- requires neovim > v0.9.0, passed as is to `nvim_open_win`
        -- can be sent individually to any provider to set the win title
        -- title         = "Title",
        -- title_pos     = "center",    -- 'left', 'center' or 'right'
        fullscreen = false, -- start fullscreen?
        preview    = {
          -- default     = 'bat',           -- override the default previewer?
          -- default uses the 'builtin' previewer
          border       = 'border',    -- border|noborder, applies only to
          -- native fzf previewers (bat/cat/git/etc)
          wrap         = 'nowrap',    -- wrap|nowrap
          hidden       = 'nohidden',  -- hidden|nohidden
          vertical     = 'down:45%',  -- up|down:size
          horizontal   = 'right:60%', -- right|left:size
          layout       = 'vertical',  -- horizontal|vertical|flex
          flip_columns = 120,         -- #cols to switch to horizontal on flex
          -- Only used with the builtin previewer:
          title        = true,        -- preview border title (file/buf)?
          title_pos    = "center",    -- left|center|right, title alignment
          scrollbar    = 'float',     -- `false` or string:'float|border'
          -- float:  in-window floating border
          -- border: in-border chars (see below)
          scrolloff    = '-2', -- float scrollbar offset from right
          -- applies only when scrollbar = 'float'
          scrollchars  = { '█', '' }, -- scrollbar chars ({ <full>, <empty> }
          -- applies only when scrollbar = 'border'
          delay        = 100, -- delay(ms) displaying the preview
          -- prevents lag on fast scrolling
          winopts      = {
            -- builtin previewer window options
            number         = true,
            relativenumber = false,
            cursorline     = true,
            cursorlineopt  = 'both',
            cursorcolumn   = false,
            signcolumn     = 'no',
            list           = false,
            foldenable     = false,
            foldmethod     = 'manual',
          },
        },
        on_create  = function()
          -- called once upon creation of the fzf main window
          -- can be used to add custom fzf-lua mappings, e.g:
          --   vim.keymap.set("t", "<C-j>", "<Down>", { silent = true, buffer = true })
        end,
        -- called once *after* the fzf interface is closed
        -- on_close = function() ... end
      },
      keymap   = {
        -- These override the default tables completely
        -- no need to set to `false` to disable a bind
        -- delete or modify is sufficient
        builtin = {
          -- neovim `:tmap` mappings for the fzf win
          ["<c-d>"] = "preview-page-down",
          ["<c-u>"] = "preview-page-up",
        },
        fzf = {
          -- fzf '--bind=' options
          ["ctrl-f"] = "half-page-down",
          ["ctrl-b"] = "half-page-up",
          ["ctrl-a"] = "beginning-of-line",
          ["ctrl-e"] = "end-of-line",
        },
      },
      fzf_opts = {
        -- options are sent as `<left>=<right>`
        -- set to `false` to remove a flag
        -- set to `true` for a no-value flag
        -- for raw args use `fzf_args` instead
        ["--ansi"]           = true,
        ["--info"]           = "inline-right", -- fzf < v0.42 = "inline"
        ["--height"]         = "100%",
        ["--layout"]         = "reverse",
        ["--border"]         = "none",
        ["--highlight-line"] = true, -- fzf >= v0.53
      },
      files    = {
        -- previewer      = "bat",          -- uncomment to override previewer
        -- (name from 'previewers' table)
        -- set to 'false' to disable
        prompt                 = 'Files❯ ',
        multiprocess           = true, -- run command in a separate process
        git_icons              = true, -- show git icons?
        file_icons             = true, -- show file icons?
        color_icons            = true, -- colorize file|git icons
        -- path_shorten   = 1,              -- 'true' or number, shorten path?
        -- Uncomment for custom vscode-like formatter where the filename is first:
        -- e.g. "fzf-lua/previewer/fzf.lua" => "fzf.lua previewer/fzf-lua"
        -- formatter      = "path.filename_first",
        -- executed command priority is 'cmd' (if exists)
        -- otherwise auto-detect prioritizes `fd`:`rg`:`find`
        -- default options are controlled by 'fd|rg|find|_opts'
        -- NOTE: 'find -printf' requires GNU find
        -- cmd            = "find . -type f -printf '%P\n'",
        find_opts              = [[-type f -not -path '*/\.git/*' -printf '%P\n']],
        rg_opts                = [[--color=never --files --hidden --follow -g "!.git"]],
        fd_opts                = [[--color=never --type f --hidden --follow --exclude .git]],
        keymap                 = { builtin = { ["<Esc>"] = "hide" } },
        -- by default, cwd appears in the header only if {opts} contain a cwd
        -- parameter to a different folder than the current working directory
        -- uncomment if you wish to force display of the cwd as part of the
        -- query prompt string (fzf.vim style), header line or both
        -- cwd_header = true,
        cwd_prompt             = true,
        cwd_prompt_shorten_len = 32,            -- shorten prompt beyond this length
        cwd_prompt_shorten_val = 1,             -- shortened path parts length
        toggle_ignore_flag     = "--no-ignore", -- flag toggled in `actions.toggle_ignore`
        toggle_hidden_flag     = "--hidden",    -- flag toggled in `actions.toggle_hidden`
      },
      grep     = {
        prompt         = 'Rg❯ ',
        input_prompt   = 'Grep For❯ ',
        multiprocess   = true, -- run command in a separate process
        git_icons      = true, -- show git icons?
        file_icons     = true, -- show file icons?
        color_icons    = true, -- colorize file|git icons
        -- executed command priority is 'cmd' (if exists)
        -- otherwise auto-detect prioritizes `rg` over `grep`
        -- default options are controlled by 'rg|grep_opts'
        -- cmd            = "rg --vimgrep",
        grep_opts      = "--binary-files=without-match --line-number --recursive --color=auto --perl-regexp -e",
        rg_opts        = "--column --line-number --no-heading --color=always --smart-case --max-columns=4096 -e",
        -- Uncomment to use the rg config file `$RIPGREP_CONFIG_PATH`
        -- RIPGREP_CONFIG_PATH = vim.env.RIPGREP_CONFIG_PATH
        --
        -- Set to 'true' to always parse globs in both 'grep' and 'live_grep'
        -- search strings will be split using the 'glob_separator' and translated
        -- to '--iglob=' arguments, requires 'rg'
        -- can still be used when 'false' by calling 'live_grep_glob' directly
        rg_glob        = false,     -- default to glob parsing?
        glob_flag      = "--iglob", -- for case sensitive globs use '--glob'
        glob_separator = "%s%-%-",  -- query separator pattern (lua): ' --'
        -- advanced usage: for custom argument parsing define
        -- 'rg_glob_fn' to return a pair:
        --   first returned argument is the new search query
        --   second returned argument are additional rg flags
        -- rg_glob_fn = function(query, opts)
        --   ...
        --   return new_query, flags
        -- end,
        --
        -- Enable with narrow term width, split results to multiple lines
        -- NOTE: multiline requires fzf >= v0.53 and is ignored otherwise
        -- multiline      = 1,      -- Display as: PATH:LINE:COL\nTEXT
        -- multiline      = 2,      -- Display as: PATH:LINE:COL\nTEXT\n
        actions        = {
          -- actions inherit from 'actions.files' and merge
          -- this action toggles between 'grep' and 'live_grep'
          -- ["ctrl-g"] = { actions.grep_lgrep }
          -- uncomment to enable '.gitignore' toggle for grep
          -- ["ctrl-r"]   = { actions.toggle_ignore }
        },
        no_header      = true, -- hide grep|cwd header?
        no_header_i    = true, -- hide interactive header?
      },
    })
    local keyset = vim.keymap.set
    local opts = { silent = true, nowait = true }
    -- keyset("n", "<leader>h", ":FzfLua oldfiles<cr>", opts)
    keyset("n", "<leader>b", ":FzfLua buffers<cr>", opts)
    keyset("n", "<leader>8", ":FzfLua files header=false<cr>", opts)


    keyset('n', '<leader>e', function()
      require 'fzf-lua'.fzf_exec(
        "rg -g '!*git*' -g '!yarn.lock' -g '!*ci/*' -g '!*docker/*' --trim -F --max-columns=120 --line-number --no-heading  --color=always --smart-case ''",
        {
          actions      = {
            ['default'] = require 'fzf-lua'.actions.file_edit
          },
          previewer    = "builtin",
          fn_transform = function(x)
            return require 'fzf-lua'.make_entry.file(x, { file_icons = true, color_icons = true })
          end
        }
      )
    end, opts)

    keyset('n', '<leader>w', function()
      require 'fzf-lua'.fzf_exec(
        "rg -g '!*git*' -g '!yarn.lock' -g '!*ci/*' -g '!*docker/*' --trim -F --max-columns=119 --line-number --no-heading  --color=always --smart-case '" ..
        vim.fn.expand('<cword>') .. "'",
        {
          actions      = {
            ['default'] = require 'fzf-lua'.actions.file_edit,
          },
          previewer    = "builtin",
          fn_transform = function(x)
            return require 'fzf-lua'.make_entry.file(x, { file_icons = true, color_icons = true })
          end
        }
      )
    end, opts)
  end
}
