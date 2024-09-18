return {
  "akinsho/toggleterm.nvim",
  keys = {
    "<c-3>",
  },
  version = "*",
  config = function()
    require("toggleterm").setup({
      float_opts = {
        width = function()
          return math.floor(vim.o.columns * 0.9)
        end,
        height = function()
          return math.floor(vim.o.lines * 0.9)
        end,
      },
    })
    local Terminal = require("toggleterm.terminal").Terminal
    local term = Terminal:new({
      hidden = true,
      direction = "float",
    })

    local lazygit = Terminal:new({
      cmd = "lazygit",
      hidden = true,
      direction = "float",
      -- function to run on opening the terminal
      on_open = function(term)
        vim.cmd("startinsert!")
        vim.api.nvim_buf_set_keymap(term.bufnr, "n", "q", "q", { noremap = true })
        vim.api.nvim_buf_set_keymap(
          term.bufnr,
          "t",
          "<c-g>",
          "<cmd>lua _lazygit_toggle()<CR>",
          { noremap = true }
        )
      end,
      -- function to run on closing the terminal
      on_close = function(term)
        vim.cmd("startinsert!")
      end,
    })

    function _term_toggle()
      if lazygit:is_open() then
        lazygit:toggle()
      end
      term:toggle()
    end

    function _lazygit_toggle()
      if term:is_open() then
        term:toggle()
      end
      lazygit:toggle()
    end

    -- vim.api.nvim_set_keymap("n", "<c-g>", "<cmd>lua _lazygit_toggle()<CR>", { noremap = true, silent = true })
    -- vim.api.nvim_set_keymap("t", "<c-g>", "<cmd>lua _lazygit_toggle()<CR>", { noremap = true, silent = true })
    vim.api.nvim_set_keymap("n", "<c-3>", "<cmd>lua _term_toggle()<CR>", { noremap = true, silent = true })
    vim.api.nvim_set_keymap("t", "<c-3>", "<cmd>lua _term_toggle()<CR>", { noremap = true, silent = true })
  end,
}
