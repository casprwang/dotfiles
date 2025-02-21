local opts = { silent = true, nowait = true, noremap = true }
vim.api.nvim_set_keymap("n", "gq", ":q<cr>", opts)
vim.api.nvim_set_keymap("n", ",", ":q<cr>", opts)
vim.api.nvim_set_keymap("n", "<leader>", "<nop>", opts)
vim.api.nvim_set_keymap("v", "<leader>", "<nop>", opts)
vim.api.nvim_set_keymap("n", "<c-w><Space>", "<c-w>=", opts)
vim.api.nvim_set_keymap("n", "0", "^", opts)
vim.api.nvim_set_keymap("n", "<c-e>", "3<c-e>", opts)
vim.api.nvim_set_keymap("n", "<c-y>", "3<c-y>", opts)
vim.api.nvim_set_keymap("n", "<esc>", ":noh<cr>", opts)
-- vim.api.nvim_set_keymap("n", "<right>", "<c-w>l", opts)
-- vim.api.nvim_set_keymap("n", "<left>", "<c-w>h", opts)
-- vim.api.nvim_set_keymap("n", "<up>", "<c-w>k", opts)
-- vim.api.nvim_set_keymap("n", "<down>", "<c-w>j", opts)
vim.api.nvim_set_keymap("n", "Y", "y$", opts)


vim.api.nvim_set_keymap("n", "<c-g>", "<c-^>", opts)
vim.api.nvim_set_keymap("n", "]c", ":cn<cr>", opts)
vim.api.nvim_set_keymap("n", "[c", ":cp<cr>", opts)
vim.api.nvim_set_keymap("n", "co", ":cope<cr>", opts)
vim.api.nvim_set_keymap("n", "cq", ":ccl<cr>", opts)
vim.api.nvim_set_keymap("n", "<c-[>", ":q<cr>", opts)
vim.api.nvim_set_keymap("i", "<c-c>", "<esc>", opts)

-- emacs binding in insert mode
vim.api.nvim_set_keymap("i", "<c-e>", "<esc>A", opts)
vim.api.nvim_set_keymap("i", "<c-a>", "<esc>I", opts)

-- vim.keymap.set('t', '<c-[>', '<C-\\><C-n>', { noremap = true, silent = true })
-- vim.api.nvim_set_keymap("t", "<c-[>", "<C-\\><C-n>", { noremap = true, silent = true })
-- vim.api.nvim_set_keymap("t", "<esc>", "<C-\\><C-n>", { noremap = true, silent = true })
-- vim.keymap.set('t', '<esc>', '<C-\\><C-n>', { noremap = true, silent = true })


vim.api.nvim_set_keymap("n", "<leader>n", ":silent w<cr>", opts)
