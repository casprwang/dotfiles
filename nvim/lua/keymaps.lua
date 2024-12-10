local map = vim.cmd

-- vim.api.nvim_set_keymap("n", "gq", ":q<cr>", { noremap = true, silent = true })

vim.api.nvim_set_keymap("n", "gq", ":q<cr>", { noremap = true })
-- vim.api.nvim_set_keymap("n", "q", ":close<cr>", { noremap = true })
-- vim.api.nvim_set_keymap("n", "gq", ":qa<cr>", { noremap = true })

-- vim.api.nvim_set_keymap("n", "gq", ":qa<cr>", { noremap = true })

vim.api.nvim_set_keymap("n", "<leader>", "<nop>", { noremap = true })
vim.api.nvim_set_keymap("v", "<leader>", "<nop>", { noremap = true })
vim.api.nvim_set_keymap("n", "<c-w><Space>", "<c-w>=", { noremap = true })
vim.api.nvim_set_keymap("n", "0", "^", { noremap = true })


vim.api.nvim_set_keymap("n", "<c-t>", "<c-w>T", { noremap = true })

vim.api.nvim_set_keymap("n", "<c-e>", "3<c-e>", { noremap = true })
vim.api.nvim_set_keymap("n", "<c-y>", "3<c-y>", { noremap = true })
vim.api.nvim_set_keymap("n", "<esc>", ":noh<cr>",
  { noremap = true, silent = true })

vim.api.nvim_set_keymap("n", "<right>", "<c-w>l",
  { noremap = true, silent = true })
vim.api
    .nvim_set_keymap("n", "<left>", "<c-w>h", { noremap = true, silent = true })
vim.api
    .nvim_set_keymap("n", "<up>", "<c-w>k", { noremap = true, silent = true })
vim.api
    .nvim_set_keymap("n", "<down>", "<c-w>j", { noremap = true, silent = true })

vim.api.nvim_set_keymap("n", "[t", ":tabprevious<cr>",
  { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "]t", ":tabnext<cr>",
  { noremap = true, silent = true })

-- vim.api.nvim_set_keymap("n", "<up>", "<c-w>k", {noremap = true, silent = true})
-- vim.api.nvim_set_keymap("n", "<down>", "<c-w>j", {noremap = true, silent = true})
-- vim.api.nvim_set_keymap("n", "<c-p>", "<c-^>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "Y", "y$", { noremap = true })
vim.api.nvim_set_keymap("n", "gj", ":w<cr>", { noremap = true })

vim.api.nvim_set_keymap("n", "<leader>m", ":w<cr>",
  { noremap = true, silent = true })

vim.api.nvim_set_keymap("n", "<c-g>", "<c-^>", { noremap = true, silent = true })
