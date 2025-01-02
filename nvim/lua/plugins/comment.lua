return {
  "numToStr/Comment.nvim",
  event = "VeryLazy",
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "JoosepAlviste/nvim-ts-context-commentstring",
  },
  keys = {
    "<cmd>CommentToggle<cr>",
    "gc",
    "gcc",
  },
  config = function()
    local prehook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook()
    require("Comment").setup({
      pre_hook = prehook,
    })
  end,
}
