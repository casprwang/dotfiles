return {
  {
    event = "VeryLazy",
    "wellle/targets.vim",
    config = function()
      vim.cmd [[
      autocmd User targets#mappings#user call targets#mappings#extend({
          \ "'": {'quote': [{'d':"'"}, {'d':'"'}, {'d':'`'}]},
          \ })
    ]]
    end
  },
  {
    "folke/persistence.nvim",
    event = "VeryLazy",
    opts = {
      -- add any custom options here
    }
  },
  {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    event = "VeryLazy",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      local harpoon = require("harpoon")
      -- REQUIRED
      harpoon:setup()
      -- REQUIRED

      vim.keymap.set("n", "m", function() harpoon:list():add() end)
      vim.keymap.set("n", "'", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)

      vim.keymap.set("n", "<C-1>", function() harpoon:list():select(1) end)
      vim.keymap.set("n", "<C-2>", function() harpoon:list():select(2) end)
      vim.keymap.set("n", "<C-3>", function() harpoon:list():select(3) end)
      vim.keymap.set("n", "<C-4>", function() harpoon:list():select(4) end)
    end

  }
}
