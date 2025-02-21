-- rewrite of :h restore-cursor
-- https://github.com/neovim/neovim/issues/16339#issuecomment-1457394370
vim.api.nvim_create_autocmd('BufRead', {
    callback = function(opts)
        vim.api.nvim_create_autocmd('BufWinEnter', {
            once = true,
            buffer = opts.buf,
            callback = function()
                local ft = vim.bo[opts.buf].filetype
                local last_known_line = vim.api.nvim_buf_get_mark(opts.buf, '"')[1]
                if
                    not (ft:match('commit') and ft:match('rebase'))
                    and last_known_line > 1
                    and last_known_line <= vim.api.nvim_buf_line_count(opts.buf)
                then
                    vim.api.nvim_feedkeys([[g`"]], 'nx', false)
                end
            end,
        })
    end,
})

vim.cmd [[
augroup custom_indentation
  autocmd!
  autocmd Filetype go setlocal ts=8 sw=8 sts=8 expandtab
  autocmd Filetype odin setlocal ts=8 sw=8 sts=8 expandtab
  autocmd Filetype c setlocal ts=4 sw=4 sts=4 expandtab
  " autocmd Filetype go setlocal ts=4 sw=4 sts=0 expandtab
  autocmd Filetype markdown set nonumber
  autocmd Filetype markdown set nonumber
augroup END
]]
