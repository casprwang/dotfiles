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
        " hi link illuminatedWord CursorLine
          " hi IlluminatedWordText gui=underdotted
        " hi IlluminatedWordRead gui=bold

        " hi illuminatedWord cterm=underline gui=underline
        " hi illuminatedCurWord cterm=italic gui=italic
      ]]
      vim.cmd [[
        " augroup illuminate_augroup
        "     autocmd!
        "     autocmd VimEnter * hi link illuminatedWord CursorLine
        " augroup END
        "
        " augroup illuminate_augroup
        "     autocmd!
        "     autocmd VimEnter * hi illuminatedWord cterm=underline gui=underline
        " augroup END
        " augroup illuminate_augroup
        "     autocmd!
        "     autocmd VimEnter * hi illuminatedCurWord cterm=italic gui=italic
        " augroup END
      ]]
    end
  },
}
