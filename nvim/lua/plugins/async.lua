return {
  'nvim-lua/plenary.nvim',
  event = "VeryLazy",
  config = function()
    local Job = require 'plenary.job'

    local function runFreAsync(file_path)
      Job:new({
        command = 'fre',
        args = { "--add", file_path, },
        on_exit = function(j, return_val)
          -- print(return_val)
          -- print(j:result())
        end,
      }):start()
    end

    vim.api.nvim_create_autocmd({ "BufWinEnter" }, {
      pattern = { "*" },
      callback = function()
        local file_path = vim.fn.expand('%:p')
        if file_path then
          runFreAsync(file_path)
          -- os.execute("fre --add " .. file_path .. " > /dev/null 2>&1 &")
        end
      end
    })
  end
}
