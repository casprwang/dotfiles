return {
  "ibhagwan/fzf-lua",
  config = function()
    require("fzf-lua").setup {
      commands   = { sort_lastused = true },
      winopts_fn = function()
        -- Make it full-width on smaller windows.
        return {
          width  = vim.o.columns > 100 and 0.80 or 1,
          height = vim.o.lines > 42 and 0.90 or 1,
          row    = 0.55, -- window row position (0=top, 1=bottom)
        }
      end,
      winopts    = {
        border     = { '╭', '─', '╮', '│', '╯', '─', '╰', '│' },
        fullscreen = false,       -- start fullscreen?
        preview    = {
          layout    = 'vertical', -- horizontal|vertical|flex
          title     = true,       -- preview border title (file/buf)?
          vertical  = 'down:40%', -- up|down:size
          title_pos = "center",   -- left|center|right, title alignment
          delay     = 200,        -- delay(ms) displaying the preview
        },
        on_create  = function()
        end,
      },
      fzf_colors = {
      },
      keymap     = {
        builtin = {
          -- neovim `:tmap` mappings for the fzf win
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
      files      = {
        prompt       = 'Files❯ ',
        multiprocess = true, -- run command in a separate process
        find_opts    = [[-type f -not -path '*/\.git/*' -printf '%P\n']],
        rg_opts      = [[--color=never --files --hidden --follow -g "!.git"]],
        fd_opts      = [[--color=never --type f --hidden --follow --exclude .git]],
        file_icons   = false,
        no_header    = true, -- hide grep|cwd header?
      },
      grep       = {
        prompt         = 'Rg❯ ',
        file_icons     = false,
        input_prompt   = 'Grep For❯ ',
        multiprocess   = true, -- run command in a separate process
        grep_opts      = "--binary-files=without-match --line-number --recursive --color=auto --perl-regexp -e",
        rg_opts        = "--column --line-number --no-heading --color=always --smart-case --max-columns=4096 -e",
        rg_glob        = false,     -- default to glob parsing?
        glob_flag      = "--iglob", -- for case sensitive globs use '--glob'
        glob_separator = "%s%-%-",  -- query separator pattern (lua): ' --'
        actions        = {
        },
        no_header      = true, -- hide grep|cwd header?
        no_header_i    = true, -- hide interactive header?
      },
    }
    local keyset = vim.keymap.set
    local opts = { silent = true, nowait = true, noremap = true }

    keyset("n", "<leader>r", function()
      require('fzf-lua').oldfiles({
        file_icons = false,

      })
    end, opts)

    keyset("n", "<leader>f", function()
      require("fzf-lua").files({

        file_icons = false,
      })
    end, opts)

    keyset('n', '<leader>e', function()
      require 'fzf-lua'.fzf_exec(
        "rg -g '!*git*' -g '!yarn.lock' -g '!*ci/*' -g '!*docker/*' --trim -F --max-columns=120 --line-number --no-heading  --color=always --smart-case ''",
        {
          actions = {
            ['default'] = require 'fzf-lua'.actions.file_edit
          },
          previewer = "builtin",
          fn_transform = function(x)
            return require 'fzf-lua'.make_entry.file(x, { file_icons = false })
          end
        }
      )
    end, opts)

    keyset('n', '<leader>w', function()
      require 'fzf-lua'.fzf_exec(
        "rg -g '!*git*' -g '!yarn.lock' -g '!*ci/*' -g '!*docker/*' --trim -F --max-columns=119 --line-number --no-heading  --color=always --smart-case '" ..
        vim.fn.expand('<cword>') .. "'",
        {
          actions = {
            ['default'] = require 'fzf-lua'.actions.file_edit,
          },
          previewer = "builtin",
          fn_transform = function(x)
            return require 'fzf-lua'.make_entry.file(x, { file_icons = false })
          end
        }
      )
    end, opts)
  end
}
