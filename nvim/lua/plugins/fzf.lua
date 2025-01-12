return {
  "ibhagwan/fzf-lua",
  config = function()
    local actions = require('fzf-lua').actions
    local default_actions = {
      ['default'] = actions.file_edit,
      ["enter"]   = actions.file_edit_or_qf,
      ['ctrl-s']  = actions.file_split,
      ['ctrl-v']  = actions.file_vsplit,
      ['ctrl-t']  = actions.file_tabedit,
    }
    require("fzf-lua").setup {
      commands = { sort_lastused = true },
      winopts  = function()
        -- Make it full-width on smaller windows.
        return {
          border     = { '╭', '─', '╮', '│', '╯', '─', '╰', '│' },
          fullscreen = false,       -- start fullscreen?
          preview    = {
            layout    = 'vertical', -- horizontal|vertical|flex
            title     = true,       -- preview border title (file/buf)?
            vertical  = 'down:40%', -- up|down:size
            title_pos = "center",   -- left|center|right, title alignment
            delay     = 200,        -- delay(ms) displaying the preview
          },
          width      = vim.o.columns > 100 and 0.80 or 1,
          height     = vim.o.lines > 42 and 0.90 or 1,
          row        = 0.55, -- window row position (0=top, 1=bottom)
        }
      end,
      keymap   = {
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
      files    = {
        prompt       = 'Files❯ ',
        multiprocess = true, -- run command in a separate process
        find_opts    = [[-type f -not -path '*/\.git/*' -printf '%P\n']],
        rg_opts      = [[--color=never --files --hidden --follow -g "!.git"]],
        fd_opts      = [[--color=never --type f --hidden --follow --exclude .git]],
        file_icons   = false,
        no_header    = true, -- hide grep|cwd header?
      },
      grep     = {
        prompt         = 'Rg❯ ',
        file_icons     = false,
        input_prompt   = 'Grep For❯ ',
        multiprocess   = true, -- run command in a separate process
        grep_opts      = "--binary-files=without-match --line-number --recursive --color=auto --perl-regexp -e",
        rg_opts        = "--column --line-number --no-heading --color=always --smart-case --max-columns=4096 -e",
        rg_glob        = false,     -- default to glob parsing?
        glob_flag      = "--iglob", -- for case sensitive globs use '--glob'
        glob_separator = "%s%-%-",  -- query separator pattern (lua): ' --'
        no_header      = true,      -- hide grep|cwd header?
        no_header_i    = true,      -- hide interactive header?
      },
    }
    local keyset = vim.keymap.set
    local opts = { silent = true, nowait = true, noremap = true }

    keyset('n', '<leader>e', function()
      require 'fzf-lua'.fzf_exec(
        "rg -g '!*git*' -g '!yarn.lock' -g '!*ci/*' -g '!*docker/*' --trim -F --max-columns=120 --line-number --no-heading  --color=always --smart-case ''",
        {
          previewer = "builtin",
          actions = default_actions,
          fzf_opts = {
            ['--nth'] = 1,
            ['--delimiter'] = require 'fzf-lua'.utils.nbsp
          },
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
          actions = default_actions,
          fzf_opts = {
            ['--nth'] = 1,
            ['--delimiter'] = require 'fzf-lua'.utils.nbsp
          },
          previewer = "builtin",
          fn_transform = function(x)
            return require 'fzf-lua'.make_entry.file(x, { file_icons = false })
          end
        }
      )
    end, opts)

    -- local files = function()
    --   local cwd = vim.fn.getcwd()
    --   require 'fzf-lua'.fzf_exec(
    --     "zsh /Users/songwang/.config/zsh/old_files.sh",
    --     {
    --       actions = default_actions,
    --       fn_transform = function(x)
    --         return require 'fzf-lua'.make_entry.file(x, {
    --           cwd = cwd,
    --           cwd_header = true,
    --           -- cwd_only = true,
    --           file_icons = false,
    --         })
    --       end
    --     }
    --   )
    -- end

    local files = function()
      -- require("../utils").set_fzf_opts()
      require("fzf-lua").files({
        actions = default_actions,
        file_icons = false,
      })
    end

    local recentfiles = function()
      require('fzf-lua').oldfiles({
        actions = default_actions,
        cwd_header = false,
        file_icons = false,
      })
    end

    -- vim.api.nvim_create_user_command("FFiles", files, {})
    -- keyset("n", "<leader>f", files, opts)

    vim.api.nvim_create_user_command("FRecnetFiles", recentfiles, {})
    keyset("n", "<leader>r", recentfiles, opts)

    local frefiles = function()
      local cwd = vim.fn.getcwd()
      require 'fzf-lua'.fzf_exec(
        "zsh /Users/songwang/.config/zsh/fre_fd.sh",
        {
          actions = default_actions,
          fn_transform = function(x)
            return require 'fzf-lua'.make_entry.file(x, {
              cwd = cwd,
              cwd_header = true,
              cwd_only = true,
              file_icons = false,
            })
          end
        }
      )
    end
    vim.api.nvim_create_user_command("FFiles", frefiles, {})
    vim.api.nvim_create_user_command("FzfFreFiles", frefiles, {})
    keyset('n', '<leader>f', frefiles, opts)
  end
}
