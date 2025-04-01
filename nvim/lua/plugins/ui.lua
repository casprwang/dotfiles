return {
  {
    'norcalli/nvim-colorizer.lua',
    event  = "VeryLazy",
    config = function()
      require 'colorizer'.setup()
    end
  },
  {
    "OXY2DEV/markview.nvim",
    event = "VeryLazy",
  }
}
