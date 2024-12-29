return {
  "ibhagwan/fzf-lua",
  event = "VeryLazy",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    require("fzf-lua").setup({
      winopts  = {
        height     = 0.85,
        width      = 0.80,
        row        = 0.35,
        col        = 0.50,
        border     = { '╭', '─', '╮', '│', '╯', '─', '╰', '│' },
        fullscreen = false,
        preview    = {
          border       = 'border',
          wrap         = 'nowrap',
          hidden       = 'nohidden',
          vertical     = 'down:45%',
          horizontal   = 'right:60%',
          layout       = 'vertical',
          flip_columns = 120,
          title        = true,
          title_pos    = "center",
          scrollbar    = 'float',
          scrolloff    = '-2',
          scrollchars  = { '█', '' },
          delay        = 100,
          winopts      = {
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
        end,
      },
      keymap   = {
        builtin = {
          ["<c-d>"] = "preview-page-down",
          ["<c-u>"] = "preview-page-up",
        },
        fzf = {
          ["ctrl-f"] = "half-page-down",
          ["ctrl-b"] = "half-page-up",
          ["ctrl-a"] = "beginning-of-line",
          ["ctrl-e"] = "end-of-line",
        },
      },
      fzf_opts = {
        ["--ansi"]           = true,
        ["--info"]           = "inline-right",
        ["--height"]         = "100%",
        ["--layout"]         = "reverse",
        ["--border"]         = "none",
        ["--highlight-line"] = true,
      },
      files    = {
        prompt                 = 'Files❯ ',
        multiprocess           = true,
        git_icons              = true,
        file_icons             = true,
        color_icons            = true,
        find_opts              = [[-type f -not -path '*/\.git/*' -printf '%P\n']],
        rg_opts                = [[--color=never --files --hidden --follow -g "!.git"]],
        fd_opts                = [[--color=never --type f --hidden --follow --exclude .git]],
        keymap                 = { builtin = { ["<Esc>"] = "hide" } },
        cwd_prompt             = true,
        cwd_prompt_shorten_len = 32,
        cwd_prompt_shorten_val = 1,
        toggle_ignore_flag     = "--no-ignore",
        toggle_hidden_flag     = "--hidden",
      },
      grep     = {
        prompt         = 'Rg❯ ',
        input_prompt   = 'Grep For❯ ',
        multiprocess   = true,
        git_icons      = true,
        file_icons     = true,
        color_icons    = true,
        grep_opts      = "--binary-files=without-match --line-number --recursive --color=auto --perl-regexp -e",
        rg_opts        = "--column --line-number --no-heading --color=always --smart-case --max-columns=4096 -e",
        rg_glob        = false,
        glob_flag      = "--iglob",
        glob_separator = "%s%-%-",
        actions        = {},
        no_header      = true,
        no_header_i    = true,
      },
    })
    local keyset = vim.keymap.set
    local opts = { silent = true, nowait = true }

    keyset("n", "<leader>b", ":FzfLua buffers<cr>", opts)
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
