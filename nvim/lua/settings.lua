local opt = vim.opt

vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

vim.opt.cursorline = false

vim.o.splitright = true
vim.o.splitbelow = true


opt.number = false
opt.relativenumber = false -- for white spaces

opt.signcolumn = "yes"
opt.autoread = true
opt.wildmenu = true

-- Integration with the system clipboard
opt.clipboard = { "unnamed", "unnamedplus" }

-- Navigation
opt.scrolloff = 3     -- Lines to scroll when cursor leaves screen
opt.sidescrolloff = 3 -- Lines to scroll horizontally

-- Backups
opt.backup = true
opt.backupdir = { "~/.vim-tmp", "~/.tmp", "~/tmp", "/var/tmp", "/tmp" }
opt.backupskip = { "/tmp/*", "/private/tmp/*" }
opt.writebackup = true


-- Undo & History
opt.undofile = true
opt.undolevels = 1000
opt.undoreload = 10000
opt.undodir = vim.fn.expand("~") .. "/.local/share/nvim/undo"
opt.shada = { "!", "'1000", "<50", "s10", "h" } -- Increase the shadafile size so that history is longer


opt.hlsearch = true
opt.incsearch = true
opt.autoindent = true
opt.smartindent = true
opt.hidden = true


-- Indentation
opt.expandtab = true
opt.shiftwidth = 2
opt.tabstop = 2
opt.softtabstop = 2

opt.path = "**"

-- Ignore some folders and files with find
opt.wildignore = {
  "**/node_modules/**", "**/coverage/**", "**/.idea/**", "**/.git/**",
  "**/.nuxt/**"
}

opt.wrap = false

vim.api.nvim_set_option_value("updatetime", 100, {})
vim.api.nvim_set_option_value("synmaxcol", 200, {})
vim.opt.updatetime = 100

opt.ignorecase = true
opt.showmatch = true
opt.termguicolors = true


vim.cmd([[
  hi! SignColumn guibg=NONE
  set shortmess+=W
  set noswapfile
]])

vim.cmd [[
  augroup highlight_yank
      autocmd!
      au TextYankPost * silent! lua vim.highlight.on_yank { higroup='IncSearch', timeout=200 }
  augroup END

]]


vim.g.netrw_banner = 0    -- Disables the Netrw banner. Press 'I' to toggle.
vim.g.netrw_liststyle = 3 -- Sets the view to treeview.

vim.opt_local.conceallevel = 2
vim.o.conceallevel = 2

vim.opt.fillchars = { eob = ' ' } -- remove ~ at end of buffer

-- vim.opt.guicursor = "n-v-c-sm:block,i-ci-ve:ver25,r-cr-o:hor20"
-- vim.cmd [[
-- set guicursor=i:ver1
-- ]]

-- vim.opt.guicursor = {
--   'n-v-c:block-Cursor/lCursor-blinkwait1000-blinkon100-blinkoff100',
--   'i-ci:ver25-Cursor/lCursor-blinkwait1000-blinkon100-blinkoff100',
--   'r:hor50-Cursor/lCursor-blinkwait100-blinkon100-blinkoff100'
-- }

vim.opt.guicursor = "i-ci:ver30-iCursor-blinkwait300-blinkon200-blinkoff150"

vim.cmd [[
set shell=/bin/zsh
]]

vim.o.jumpoptions = "view"


vim.cmd [[
" Save current view settings on a per-window, per-buffer basis.
function! AutoSaveWinView()
    if !exists("w:SavedBufView")
        let w:SavedBufView = {}
    endif
    let w:SavedBufView[bufnr("%")] = winsaveview()
endfunction

" Restore current view settings.
function! AutoRestoreWinView()
    let buf = bufnr("%")
    if exists("w:SavedBufView") && has_key(w:SavedBufView, buf)
        let v = winsaveview()
        let atStartOfFile = v.lnum == 1 && v.col == 0
        if atStartOfFile && !&diff
            call winrestview(w:SavedBufView[buf])
        endif
        unlet w:SavedBufView[buf]
    endif
endfunction

" When switching buffers, preserve window view.
if v:version >= 700
    autocmd BufLeave * call AutoSaveWinView()
    autocmd BufEnter * call AutoRestoreWinView()
endif
]]

vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI", "BufEnter" }, {
  group = vim.api.nvim_create_augroup("ScrollOffEOF", {}),
  callback = function()
    local win_h = vim.api.nvim_win_get_height(0)
    local off = math.min(vim.o.scrolloff, math.floor(win_h / 2))
    local dist = vim.fn.line "$" - vim.fn.line "."
    local rem = vim.fn.line "w$" - vim.fn.line "w0" + 1
    if dist < off and win_h - rem + dist < off then
      local view = vim.fn.winsaveview()
      view.topline = view.topline + off - (win_h - rem + dist)
      vim.fn.winrestview(view)
    end
  end,
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
