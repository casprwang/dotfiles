local function lsp_keymap(bufnr)
  local bufopts = { noremap = true, silent = true, buffer = bufnr }
  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
  vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
  vim.keymap.set('n', 'gy', vim.lsp.buf.type_definition, bufopts)
  vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
  vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
  vim.keymap.set('n', '[d', function()
    vim.diagnostic.jump { count = -1, float = true }
  end, bufopts)
  vim.keymap.set('n', ']d', function()
    vim.diagnostic.jump { count = 1, float = true }
  end, bufopts)
end

return {
  {
    'neovim/nvim-lspconfig',
    event = "VeryLazy",
    dependencies = {
      {
        'saghen/blink.cmp',
        event = "VeryLazy",
        dependencies = 'rafamadriz/friendly-snippets',
        version = '*',
        opts_extend = { "sources.default" },
        config = function()
          require("blink.cmp").setup({
            completion = {
              ghost_text = {
                enabled = true
              },
              menu = {
                auto_show = true,
              },
              accept = { auto_brackets = { enabled = false }, },
              -- list = { selection = function(ctx) return ctx.mode == 'cmdline' and 'auto_insert' or 'preselect' end },
              list = { selection = "preselect" },
            },
            keymap = { preset = 'super-tab' }, -- default super-tab enter
            appearance = {
              use_nvim_cmp_as_default = true,
              nerd_font_variant = 'mono'
            },
            sources = {
              default = { 'lsp', 'path', 'snippets', 'buffer' },
            },
          })
        end
      },
      {
        "folke/lazydev.nvim",
        ft = "lua",
        opts = {
          library = {
            { path = "${3rd}/luv/library", words = { "vim%.uv" } },
          },
        },
      },
    },
    -- example using `opts` for defining servers
    opts = {
      servers = {
        ruby_lsp     = {},
        stimulus_ls  = {},
        lua_ls       = {
          settings = {
            Lua = {
              runtime = {
                version = 'LuaJIT',
              },
              diagnostics = {
                disable = { 'missing-fields' },
                globals = {
                  'vim',
                  'require'
                },
              },
              workspace = {
                library = vim.api.nvim_get_runtime_file("", true),
              },
              telemetry = {
                enable = false,
              },
            },
          },
        },
        basedpyright = {}
      }
    },
    config = function(_, opts)
      local lspconfig = require('lspconfig')
      for server, config in pairs(opts.servers) do
        config.capabilities = require('blink.cmp').get_lsp_capabilities(config.capabilities)
        config.on_attach = function(_, bufnr)
          lsp_keymap(bufnr)
        end
        lspconfig[server].setup(config)
      end
      vim.diagnostic.config({
        virtual_text = false,
        float = true,
        signs = {
          text = {
            [vim.diagnostic.severity.ERROR] = '',
            [vim.diagnostic.severity.WARN] = '',
            [vim.diagnostic.severity.INFO] = '',
            [vim.diagnostic.severity.HINT] = '',
          }
        }
      })
    end
  },
  {
    'windwp/nvim-autopairs',
    event = "InsertEnter",
    config = true
  },
  {
    "williamboman/mason-lspconfig.nvim",
    event = "VeryLazy",
    dependencies = {
      "williamboman/mason.nvim",
      "neovim/nvim-lspconfig",
    },
    config = function()
      require("mason").setup()
      require("mason-lspconfig").setup()
    end
  },
  {
    "pmizio/typescript-tools.nvim",
    event = "VeryLazy",
    dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
    config = function()
      require("typescript-tools").setup {
        on_attach = function(_, bufnr)
          lsp_keymap(bufnr)
        end
      }
    end
  }
}
