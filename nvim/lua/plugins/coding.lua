return {
  {
    "wellle/targets.vim",
    event = "VeryLazy",
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
    event = "BufReadPre",
    opts = {
      -- add any custom options here
    }
  }
}
