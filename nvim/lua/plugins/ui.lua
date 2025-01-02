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
        -- providers: provider used to get references in the buffer, ordered by priority
        providers = {
          'lsp',
        },
        -- delay: delay in milliseconds
        delay = 10,
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
        -- large_file_config: config to use for large files (based on large_file_cutoff).
        -- Supports the same keys passed to .configure
        -- If nil, vim-illuminate will be disabled for large files.
        large_file_overrides = nil,
        -- min_count_to_highlight: minimum number of matches required to perform highlighting
        min_count_to_highlight = 1,
        -- should_enable: a callback that overrides all other settings to
        -- enable/disable illumination. This will be called a lot so don't do
        -- anything expensive in it.
        should_enable = function(bufnr) return true end,
        -- case_insensitive_regex: sets regex case sensitivity
        case_insensitive_regex = false,
      })
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
