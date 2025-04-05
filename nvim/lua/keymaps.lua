local opts = { silent = true, nowait = true, noremap = true }

vim.api.nvim_set_keymap("n", "gq", ":q<cr>", opts)
vim.api.nvim_set_keymap("n", ",", ":q<cr>", opts)
vim.api.nvim_set_keymap("n", "<leader>", "<nop>", opts)
vim.api.nvim_set_keymap("v", "<leader>", "<nop>", opts)
vim.api.nvim_set_keymap("n", "0", "^", opts)
vim.api.nvim_set_keymap("n", "<c-e>", "3<c-e>", opts)
vim.api.nvim_set_keymap("n", "<c-y>", "3<c-y>", opts)
vim.api.nvim_set_keymap("n", "<esc>", ":noh<cr>", opts)
vim.api.nvim_set_keymap("n", "Y", "y$", opts)
vim.api.nvim_set_keymap("n", "[w", "[b", opts)
vim.api.nvim_set_keymap("n", "]w", "]b", opts)
vim.api.nvim_set_keymap("n", "<c-g>", "<c-^>", opts)

-- emacs binding in insert mode
vim.api.nvim_set_keymap("i", "<c-e>", "<esc>A", opts)
vim.api.nvim_set_keymap("i", "<c-a>", "<esc>I", opts)
