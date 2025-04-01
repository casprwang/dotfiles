require("settings")
require("keymaps")
require("autocmd")
require("statusline")

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

vim.cmd [[
    function! RetainZoomStatus()
        " Assume that if we haven't called ToggleZoom() before then all windows
        " are probably meant to be equal (set g:zoom_status to 0)
        let g:zoom_status = get(g:, 'zoom_status', 0)
        if g:zoom_status == 0
            wincmd =
        else
            wincmd _
            wincmd |
        endif
    endfunction

    augroup zoom
        autocmd!
        autocmd VimResized * call RetainZoomStatus()
    augroup END
]]

require("lsp")
