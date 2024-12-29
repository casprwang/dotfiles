return {
  'stevearc/oil.nvim',
  dependencies = { { "echasnovski/mini.icons", opts = {} } },
  -- dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if prefer nvim-web-devicons
  config = function()
    require("oil").setup({
      ["<C-s>"] = { "actions.select", opts = { vertical = true } },
    })
    vim.keymap.set("n", "-", ":Oil --float<CR>", { desc = "Open parent directory" })
  end
}
