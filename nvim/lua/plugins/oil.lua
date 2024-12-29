return {
  'stevearc/oil.nvim',
  event = "VeryLazy",
  dependencies = { { "echasnovski/mini.icons", opts = {} } },
  config = function()
    require("oil").setup({
      ["<C-s>"] = { "actions.select", opts = { vertical = true } },
    })
    vim.keymap.set("n", "-", ":Oil --float<CR>", { desc = "Open parent directory" })
  end
}
