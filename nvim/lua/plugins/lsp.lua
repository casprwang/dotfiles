local function lsp_keymap(bufnr)
  local bufopts = { noremap = true, silent = true, buffer = bufnr }
  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
  vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
  vim.keymap.set('n', 'gy', vim.lsp.buf.type_definition, bufopts)
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
  vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
  vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
end

return {
  {
    'neovim/nvim-lspconfig',
    event = "VeryLazy",
    dependencies = {
      {
        'saghen/blink.cmp',
        event = "VeryLazy",
        enabled = true,
        build = 'cargo build --release',
        dependencies = 'rafamadriz/friendly-snippets',
        version = '*',
        opts_extend = { "sources.default" },
        config = function()
          vim.diagnostic.config({ jump = { float = true } })
          require("blink.cmp").setup({
            completion = {
              ghost_text = {
                enabled = true
              },
              menu = {
                auto_show = true,
              },
              -- accept = { auto_brackets = { enabled = false }, },
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
    },
    config = function()
      local lspconfig = require('lspconfig')
      local servers = {
        ruby_lsp     = {},
        stimulus_ls  = {},
        bashls       = {
          filetypes = { "bash", "sh", "zsh" }
        },
        lua_ls       = {
          root_dir = lspconfig.util.root_pattern(".luarc.json", ".luarc.jsonc", ".luacheckrc", ".stylua.toml",
            "stylua.toml", "selene.toml", "selene.yml", ".git"),
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
      for server, config in pairs(servers) do
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
        on_attach = function(client, bufnr)
          lsp_keymap(bufnr)
        end
      }
    end
  }

}
