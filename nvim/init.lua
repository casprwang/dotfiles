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
    hi! FzfLuaBackdrop guibg=NONE

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

local function virtual_text_document(params)
  local bufnr = params.buf
  -- Path somehow has a leading slash, which broke things
  local actual_path = params.match:sub(2)

  local method = "deno/virtualTextDocument"
  local req_params = { textDocument = { uri = actual_path } }
  local client = vim.lsp.get_clients({ name = "denols" })[1]
  local response = client.request_sync(method, req_params, 2000, 0)
  if not response or type(response.result) ~= "string" then
    return
  end

  local lines = vim.split(response.result, "\n")
  vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, lines)
  vim.api.nvim_set_option_value("readonly", true, { buf = bufnr })
  vim.api.nvim_set_option_value("modified", false, { buf = bufnr })
  vim.api.nvim_set_option_value("modifiable", false, { buf = bufnr })
  vim.api.nvim_buf_set_name(bufnr, actual_path)
  vim.lsp.buf_attach_client(bufnr, client.id)
  vim.api.nvim_set_option_value("filetype", "typescript", { buf = bufnr })
end

vim.api.nvim_create_autocmd({ "BufReadCmd" }, {
  pattern = { "/deno:*" },
  callback = virtual_text_document,
})
