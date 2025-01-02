return {
  {
    "tpope/vim-rails",
    event = "VeryLazy",
    config = function()
      vim.api.nvim_create_autocmd("FileType", { pattern = "eruby.yaml", command = "set filetype=yaml" })
    end
  },
  {
    "dstein64/vim-startuptime",
    event = "VeryLazy",
    cmd = "StartupTime",
    init = function()
      vim.g.startuptime_tries = 10
    end,
  },
}
