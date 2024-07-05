local cmd = vim.cmd

local function create_augroups(definitions)
  for group_name, definition in pairs(definitions) do
    cmd('augroup ' .. group_name)
    cmd('autocmd!')
    for _, def in ipairs(definition) do
      local command = table.concat(vim.tbl_flatten { 'autocmd', def }, ' ')
      cmd(command)
    end
    cmd('augroup END')
  end
end

-- au
create_augroups({
  setup = {
    -- {"BufWritePost", "plugins.lua", "PackerCompile"},
    { "BufWritePre",          "*.cs", "Neoformat" }, {
    "TextYankPost", "*",
    [[lua require('vim.highlight').on_yank({ higroup = 'Substitute', timeout = 200 })]]
  }, { "InsertLeave,WinEnter", "*", "set cursorline" },
    { "InsertEnter,WinLeave", "*",    "set nocursorline" }, {
    "FocusGained,BufEnter,CursorHold,CursorHoldI", "*",
    [[silent! if mode() != 'c' | checktime | endif]]
  }, {
    "FileChangedShellPost", "*",
    [[echohl WarningMsg | echo "File changed on disk. Buffer reloaded." | echohl None]]
  }, { "VimResized", "*", [[wincmd =]] }
    -- {
    --   "WinEnter",
    --   "*",
    --   [[:wincmd|]]
    -- }
  },
  simple_filetypes = {

    { "FileType",   "lua",           [[set ts=2 sts=2 sw=2]] },
    { "FileType",   "cs",            [[set ts=4 sts=4 sw=4]] },
    { "FileType",   "go",            [[set ts=4 sts=4 sw=4]] },
    { "FileType",   "vue",           [[set ts=2 sts=2 sw=2]] },
    { "FileType",   "ts",            [[set ts=2 sts=2 sw=2]] },
    { "FileType",   "tsx",           [[set ts=2 sts=2 sw=2]] },
    { "FileType",   "sql",           [[set ts=4 sts=4 sw=4]] },
    { "BufRead",    "tsconfig.json", [[set filetype=jsonc]] },
    { "BufNewFile", "tsconfig.json", [[set filetype=jsonc]] },
    { "FileType",   "markdown",      [[set ts=2 sts=2 sw=2]] }
  }
})
