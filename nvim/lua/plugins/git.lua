return {
  {
    "tpope/vim-fugitive",
    event = "VeryLazy",
    config = function()
    end
  },
  {
    "lewis6991/gitsigns.nvim",
    event = "VeryLazy",
    enabled = false,
    config = function()
      require("gitsigns").setup({
        signs = {
          add = { text = "│" },
          change = { text = "│" },
          delete = { text = "│" },
          topdelete = { text = "│" },
          changedelete = { text = "│" },
          untracked = { text = "│" },
        },
      })
    end,
  },
}
