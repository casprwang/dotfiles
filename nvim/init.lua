require("settings")
require("keymaps")
require("autocmd")

-- Lazy.vim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)
-- End of lazy.vim

require("lazy").setup("plugins", {
  change_detection = {
    -- automatically check for config file changes and reload the ui
    enabled = false,
    notify = false, -- get a notification when changes are found
  },
})

vim.cmd([[
hi! SignColumn guibg=NONE
set shortmess+=W

hi! CocErrorSign guibg=NONE
hi! CocInfoSign guibg=NONE
hi! CocWarningSign guifg=NONE
]])
