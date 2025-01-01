return {
  {
    "RRethy/vim-illuminate",
    event  = "VeryLazy",
    config = function()
      -- default configuration
      require('illuminate').configure({
        -- providers: provider used to get references in the buffer, ordered by priority
        providers = {
          'lsp',
        },
        -- delay: delay in milliseconds
        delay = 10,
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
      vim.cmd [[
        " augroup illuminate_augroup
        "     autocmd!
        "     autocmd VimEnter * hi link illuminatedWord CursorLine
        " augroup END
        "
        " augroup illuminate_augroup
        "     autocmd!
        "     autocmd VimEnter * hi illuminatedWord cterm=underline gui=underline
        " augroup END
        " augroup illuminate_augroup
        "     autocmd!
        "     autocmd VimEnter * hi illuminatedCurWord cterm=italic gui=italic
        " augroup END
      ]]
    end
  },
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
      preset = "modern",
      delay = 500
    },
    keys = {
      {
        "<leader>?",
        function()
          require("which-key").show({ global = false })
        end,
        desc = "Buffer Local Keymaps (which-key)",
      },
    },
  },
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    keys = {
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
    event = "VeryLazy",
    'stevearc/dressing.nvim',
  },
  {
    "folke/noice.nvim",
    enabled = true,
    dependencies = {
      "MunifTanjim/nui.nvim",
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
          {
            filter = {
              event = "lsp",
              kind = "progress",
              cond = function(message)
                local client = vim.tbl_get(message.opts, "progress", "client")
                return client == "lua_ls"
              end,
            },
            opts = { skip = true },
          },
          {
            filter = {
              event = 'msg_show',
              any = {
                { find = '%d+L, %d+B' },
                { find = '; after #%d+' },
                { find = '; before #%d+' },
                { find = '%d fewer lines' },
                { find = '%d more lines' },
                { find = "no lines in buffer" },
                -- Edit
                { find = "%d+ less lines" },
                { find = "%d+ fewer lines" },
                { find = "%d+ more lines" },
                { find = "%d+ change;" },
                { find = "%d+ line less;" },
                { find = "%d+ more lines?;" },
                { find = "%d+ fewer lines;?" },
                { find = '".+" %d+L, %d+B' },
                { find = "%d+ lines yanked" },
                { find = "^Hunk %d+ of %d+$" },
                { find = "%d+L, %d+B$" },
                -- { find = "^[/?].*" },                  -- Searching up/down
                { find = "E486: Pattern not found:" }, -- Searcingh not found
                { find = "%d+ changes?;" },            -- Undoing/redoing
                { find = "%d+ fewer lines" },          -- Deleting multiple lines
                { find = "%d+ more lines" },           -- Undoing deletion of multiple lines
                { find = "%d+ lines " },               -- Performing some other verb on multiple lines
                { find = "Already at newest change" }, -- Redoing
                { find = '"[^"]+" %d+L, %d+B' },       -- Saving

                -- Save
                { find = " bytes written" },

                -- Redo/Undo
                { find = " changes; before #" },
                { find = " changes; after #" },
                { find = "1 change; before #" },
                { find = "1 change; after #" },

                -- Yank
                { find = " lines yanked" },

                -- Move lines
                { find = " lines moved" },
                { find = " lines indented" },

                -- Bulk edit
                { find = " fewer lines" },
                { find = " more lines" },
                { find = "1 more line" },
                { find = "1 line less" },

                -- General messages
                { find = "Already at newest change" }, -- Redoing
                { find = "Already at oldest change" },
              },
            },
            opts = { skip = true },
          }
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
          bottom_search = false,        -- use a classic bottom cmdline for search
          command_palette = true,       -- position the cmdline and popupmenu together
          long_message_to_split = true, -- long messages will be sent to a split
          inc_rename = false,           -- enables an input dialog for inc-rename.nvim
          lsp_doc_border = false,       -- add a border to hover docs and signature help
        },
        views = {
        }
      })
    end,
  },
  {
    "rcarriga/nvim-notify",
    config = function()
      local stages_util = require("notify.stages.util")

      require("notify").setup({
        stages = {
          function(state)
            local next_height = state.message.height + 2
            local next_row = stages_util.available_slot(
              state.open_windows,
              next_height,
              stages_util.DIRECTION.BOTTOM_UP
            )
            if not next_row then
              return nil
            end
            return {
              relative = "editor",
              anchor = "NE",
              width = state.message.width,
              height = state.message.height,
              col = vim.opt.columns:get(),
              row = next_row,
              border = "rounded",
              style = "minimal",
              opacity = 0,
            }
          end,
          function()
            return {
              opacity = { 100 },
              col = { vim.opt.columns:get() },
            }
          end,
          function()
            return {
              col = { vim.opt.columns:get() },
              time = true,
            }
          end,
          function()
            return {
              width = {
                1,
                frequency = 2.5,
                damping = 0.9,
                complete = function(cur_width)
                  return cur_width < 3
                end,
              },
              opacity = {
                0,
                frequency = 2,
                complete = function(cur_opacity)
                  return cur_opacity <= 4
                end,
              },
              col = { vim.opt.columns:get() },
            }
          end,
        },
      })
    end
  }
}
