return {
  {
    "tpope/vim-projectionist",
    event = "VeryLazy",
  },
  {
    "tpope/vim-rails",
    event = "VeryLazy",
    config = function()
      vim.api.nvim_create_autocmd("FileType", { pattern = "eruby.yaml", command = "set filetype=yaml" })
      vim.opt.smartindent = true
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
