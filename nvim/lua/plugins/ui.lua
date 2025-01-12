return {
  {
    'norcalli/nvim-colorizer.lua',
    event  = "VeryLazy",
    config = function()
      require 'colorizer'.setup()
    end
  },
  {
    "RRethy/vim-illuminate",
    event  = "VeryLazy",
    config = function()
      -- default configuration
      require('illuminate').configure({
        providers = {
          'lsp',
        },
        delay = 100,
        filetype_overrides = {},
        filetypes_denylist = {
          'dirbuf',
          'dirvish',
          'fugitive',
        },
        filetypes_allowlist = {},
        modes_denylist = {},
        modes_allowlist = {},
        providers_regex_syntax_denylist = {},
        providers_regex_syntax_allowlist = {},
        under_cursor = true,
        large_file_cutoff = nil,
        large_file_overrides = nil,
        min_count_to_highlight = 1,
        should_enable = function(bufnr) return true end,
        -- case_insensitive_regex: sets regex case sensitivity
        case_insensitive_regex = false,
      })
      vim.cmd [[
        hi link illuminatedWord CursorLine
        hi link IlluminatedWordText CursorLine
        hi link IlluminatedWordRead CursorLine
        hi link illuminatedCurWord CursorLine
        hi link IlluminatedWordWrite CursorLine
      ]]
    end
  }
}
