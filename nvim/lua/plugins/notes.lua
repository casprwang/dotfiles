return {
  {
    "epwalsh/obsidian.nvim",
    version = "*", -- recommended, use latest release instead of latest commit
    enabled = false,
    ft = "markdown",
    event = "VeryLazy",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "folke/which-key.nvim"
    },
    config = function()
      local wk = require "which-key"
      wk.add {
        { "<leader>o",  group = "Obsidian" },
        { "<leader>of", "<cmd>ObsidianQuickSwitch<cr>",     desc = "Open note" },
        { "<leader>i",  "<cmd>ObsidianQuickSwitch<cr>",     desc = "Open note" },
        { "<leader>od", "<cmd>ObsidianDailies -10 0<cr>",   desc = "Daily notes" },
        { "<leader>op", "<cmd>ObsidianPasteImg<cr>",        desc = "Paste image" },
        { "<leader>oe", "<cmd>ObsidianSearch<cr>",          desc = "Search" },
        { "<leader>ot", "<cmd>ObsidianToday<cr>",           desc = "Today" },
        { "<leader>ol", "<cmd>ObsidianLinks<cr>",           desc = "Links" },
        { "<leader>ob", "<cmd>ObsidianBacklinks<cr>",       desc = "Backlinks" },
        { "<leader>on", "<cmd>ObsidianQuickSwitch nav<cr>", desc = "Nav" },
        { "<leader>or", "<cmd>ObsidianRename<cr>",          desc = "Rename" },
      }
      require("obsidian").setup {
        disable_frontmatter = true,
        completion = {
          nvim_cmp = true,
        },
        workspaces = {
          {
            name = "notes",
            path = "/Users/songwang/Library/Mobile Documents/iCloud~md~obsidian/Documents/notes",
          },
        },
      }
    end
  }
}
