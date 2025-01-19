return {
  {
    "tpope/vim-rails",
    event = "VeryLazy",
    config = function()
      vim.api.nvim_create_autocmd("FileType", { pattern = "eruby.yaml", command = "set filetype=yaml" })
      vim.opt.smartindent = true
    end
  },
  {
    'ms-jpq/chadtree',
    event = "VeryLazy",
    branch = 'chad',
    build = 'python3 -m chadtree deps',
    config = function()
      vim.cmd [[
        let g:chadtree_settings = {
          \ "view.open_direction": "right",
        \}

        nnoremap <leader>v <cmd>CHADopen<cr>
      ]]
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
