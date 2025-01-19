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

local border = {
  { "🭽", "FloatBorder" },
  { "▔", "FloatBorder" },
  { "🭾", "FloatBorder" },
  { "▕", "FloatBorder" },
  { "🭿", "FloatBorder" },
  { "▁", "FloatBorder" },
  { "🭼", "FloatBorder" },
  { "▏", "FloatBorder" },
}


-- LSP settings (for overriding per client)
local handlers = {
  ["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = border }),
  ["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = border }),
}

return {
  {
    'neovim/nvim-lspconfig',
    event = "VeryLazy",
    dependencies = {
      {
        'saghen/blink.cmp',
        event = "VeryLazy",
        enabled = true,
        build = 'cargo +nightly build --release',
        version = '*',
        opts_extend = { "sources.default" },
        config = function()
          require("blink.cmp").setup({
            completion = {
              ghost_text = {
                enabled = false
              },
              documentation = {
                auto_show = true,
                auto_show_delay_ms = 500,
              },
              menu = {
                auto_show = true,
                draw = {
                  columns = {
                    { "kind_icon" },
                    { "label",    "label_description", gap = 1 },
                  },
                }
              },
              accept = { auto_brackets = { enabled = false }, },
              list = { selection = { preselect = true, auto_insert = true } },
            },
            keymap = { preset = 'super-tab' }, -- default super-tab enter
            appearance = {
              use_nvim_cmp_as_default = false,
              nerd_font_variant = 'mono'
            },
            sources = {
              transform_items = function(_, items)
                return vim.tbl_filter(function(item)
                  return item.kind ~= require('blink.cmp.types').CompletionItemKind.Snippet
                end, items)
              end,
              default = {
                'lsp',
                'path',
                -- 'snippets',
                'buffer'
              },
              providers = {
                path = {
                  max_items = 3
                },
                lsp = {
                  -- max_items = 5
                },
                buffer = {
                  max_items = 3,
                },
              }
            },
          })
        end
      },
    },
    config = function()
      local lspconfig = require('lspconfig')
      local servers = {
        ruby_lsp    = {},
        gopls       = {
          cmd = { "gopls" },
          filetypes = { "go", "gomod", "gowork", "gotmpl" },
          root_dir = lspconfig.util.root_pattern("go.work", "go.mod", ".git"),
          settings = {
            gopls = {
              completeUnimported = true,
              usePlaceholders = true,
              analyses = {
                unusedparams = true,
              },
            },
          },
        },
        stimulus_ls = {},
        elixirls    = {
          cmd       = { "/Users/songwang/Downloads/elixir-ls-v0.26.2/language_server.sh" },
          filetypes = { "elixir", "eelixir", "heex", "surface" },
          settings  = {
            elixirLS = {
              dialyzerEnabled = false,
              fetchDeps = false,
              autoBuild = false,
            },
          }
        },
        bashls      = {
          filetypes = { "bash", "sh", "zsh" }
        },
        pyright     = {},
        lua_ls      = {
          root_dir = lspconfig.util.root_pattern(".luarc.json", ".luarc.jsonc", ".luacheckrc", ".stylua.toml",
            "stylua.toml", "selene.toml", "selene.yml", ".git"),
          settings = {
            Lua = {
              runtime = {
                version = 'LuaJIT',
              },
              completion = {
                callSnippet = 'Disable',
                keywordSnippet = 'Disable',
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
      }
      for server, config in pairs(servers) do
        local capabilities = require('blink.cmp').get_lsp_capabilities(config.capabilities)
        -- disable lsp snippets as it distracts coding
        capabilities.textDocument.completion.completionItem.snippetSupport = false
        config.on_attach = function(_, bufnr)
          lsp_keymap(bufnr)
        end
        config.capabilities = capabilities
        lspconfig[server].setup(config)
      end
      vim.diagnostic.config({
        virtual_text = false,
        jump = { float = true },
        float = {
          border = "rounded"
        },
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
        handlers = handlers,
        on_attach = function(client, bufnr)
          lsp_keymap(bufnr)
        end
      }
    end
  }

}
