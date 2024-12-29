return {
  {
    "nvim-telescope/telescope.nvim",
    branch = "master",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "debugloop/telescope-undo.nvim",
      {
        "nvim-telescope/telescope-frecency.nvim",
        -- install the latest stable version
        version = "*",
        config = function()
          require("telescope").load_extension "frecency"
        end,
      },
      {
        'nvim-telescope/telescope-fzf-native.nvim',
        build = 'make',
        config = function()
          require('telescope').load_extension('fzf')
        end
      },
      { "mbbill/undotree", event = "VeryLazy" },
    },
    config = function()
      require("telescope").load_extension("undo")
      local builtin = require('telescope.builtin')
      local ext = require("telescope._extensions")
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
          self.state.frecency = require("frecency").frecency().picker:fetch_results()
        end
      end

      local frecency_sorter = function(_)
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
              ["<esc>"] = "close"
            }
          },
          sorting_strategy = "ascending",
        },
        extensions = {
          undo = {},
          frecency = {
            show_filter_column = false,
            default_workspace = 'CWD',
            matcher = "fuzzy"
          },
          fzf = {
            fuzzy = true,
            override_generic_sorter = true,
            override_file_sorter = true,
            case_mode = "smart_case",
          }
        },
      })
      local TSearchFile = function()
        require("telescope").extensions.frecency.frecency({
          sorter = require("telescope").extensions.fzf
              .native_fzf_sorter(),
          workspace = "CWD",
          path_display = { "smart" },
        })
      end
      local TSearchOldFile = function()
        builtin.oldfiles({
          sorter = require("telescope").extensions.fzf
              .native_fzf_sorter()
        })
      end
      local TGrepFiles = function()
        builtin.grep_string({
          path_display = { 'smart' },
          only_sort_text = true,
          word_match = "-w",
          search = 'function',
        })
      end

      local TGrepFilesWord = function()
        local word = vim.call('expand', '<cword>')
        builtin.grep_string({
          path_display = { 'smart' },
          only_sort_text = true,
          word_match = "-w",
          search = word,
        })
      end


      vim.api.nvim_create_user_command("TSearchFile", TSearchFile, {})
      vim.api.nvim_create_user_command("TSearchOldFile", TSearchOldFile, {})
      vim.keymap.set('n', '<leader>o', TSearchFile, { desc = 'find files' })
      vim.keymap.set('n', '<leader>i', TSearchOldFile, { desc = 'old files' })
      vim.keymap.set('n', '<leader>e', TGrepFiles, { desc = 'old files' })
      vim.keymap.set('n', '<leader>w', TGrepFilesWord, { desc = 'old files' })
    end,
  },
}
