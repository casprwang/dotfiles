return {
  { "mbbill/undotree",                          event = "VeryLazy" },
  { 'nvim-telescope/telescope-fzf-native.nvim', build = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release' },
  {
    "nvim-telescope/telescope.nvim",
    event = "VeryLazy",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "debugloop/telescope-undo.nvim",
    },
    config = function()
      require("telescope").load_extension("undo")
      local ext = require("telescope._extensions")
      local frecency_db = require("telescope._extensions.frecency.db_client")

      local fzf = ext.manager.fzf

      local function frecency_score(self, prompt, line, entry)
        if prompt == nil or prompt == "" then
          for _, file_entry in ipairs(self.state.frecency) do
            local filepath = entry.cwd .. "/" .. entry.value
            if file_entry.filename == filepath then
              return 9999 - file_entry.score
            end
          end

          return 9999
        end

        return self.default_scoring_function(self, prompt, line, entry)
      end

      local function frecency_start(self, prompt)
        self.default_start(self, prompt)

        if not self.state.frecency then
          self.state.frecency = frecency_db.get_file_scores()
        end
      end

      local frecency_sorter = function(opts)
        local fzf_sorter = fzf.native_fzf_sorter()

        fzf_sorter.default_scoring_function = fzf_sorter.scoring_function
        fzf_sorter.default_start = fzf_sorter.start

        fzf_sorter.scoring_function = frecency_score
        fzf_sorter.start = frecency_start

        return fzf_sorter
      end

      require("telescope").setup({
        defaults = {
          file_sorter = frecency_sorter,
        },
        -- the rest of your telescope config goes here
        extensions = {
          undo = {
          },
        },
      })

      -- optional: vim.keymap.set("n", "<leader>u", "<cmd>Telescope undo<cr>")
    end,
  },
  {
    'nvim-telescope/telescope.nvim',
    branch = "master",
    priority = 1099,
    lazy = false,
    dependencies = { 'nvim-lua/plenary.nvim', "nvim-telescope/telescope-frecency.nvim" },
    config = function()
      local builtin = require('telescope.builtin')
      require('telescope').setup {
        defaults = {
          path_display = {
            filename_first = {
              reverse_directories = false
            }
          },
          layout_strategy = "horizontal",
          initial_mode = "insert",
          layout_config = {
            horizontal = {
              prompt_position = "top",
              width = { padding = 0.1 },
              height = { padding = 0.1 },
              preview_width = 0.5,
            },
          },
          mappings = {
            i = {
              -- map actions.which_key to <C-h> (default: <C-/>)
              -- actions.which_key shows the mappings for your picker,
              -- e.g. git_{create, delete, ...}_branch for the git_branches picker
              ["<esc>"] = "close"
            }
          },
          sorting_strategy = "ascending",
        },
        extensions = {
          frecency = {
            -- completely disable the dialog
            show_filter_column = false,
            default_workspace = 'CWD',
            matcher = "fuzzy"
          },
          fzf = {
            fuzzy = true,                   -- false will only do exact matching
            override_generic_sorter = true, -- override the generic sorter
            override_file_sorter = true,    -- override the file sorter
            case_mode = "smart_case",       -- or "ignore_case" or "respect_case"
            -- the default case_mode is "smart_case"
          }
        },
      }
      vim.api.nvim_set_option_value("background", "light", {})
      vim.keymap.set('n', '<leader>o', function()
        require("telescope").extensions.frecency.frecency({
          sorter = require("telescope").extensions.fzf
              .native_fzf_sorter()
        })
      end
      , { desc = 'find files' })
      vim.keymap.set('n', '<leader>i', function()
        builtin.oldfiles({
          sorter = require("telescope").extensions.fzf
              .native_fzf_sorter()
        })
      end, { desc = 'old files' })
      require('telescope').load_extension('fzf')
    end
  }
}
