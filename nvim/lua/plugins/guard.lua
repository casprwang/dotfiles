return {
  "nvimdev/guard.nvim",
  enabled = false,
  -- Builtin configuration, optional
  event = "BufRead",
  dependencies = {
    "nvimdev/guard-collection",
  },
  config = function()
    local ft = require("guard.filetype")

    ft("sql"):fmt({
      cmd = 'sqlfluff',
      stdin = true,
      args = { 'fix', '--dialect', 'sqlite' },
    })

    -- Call setup() LAST!
    require("guard").setup({
      -- the only options for the setup function
      fmt_on_save = true,
      -- Use lsp if no formatter was defined for this filetype
      lsp_as_default_formatter = true,
    })
  end,
}
