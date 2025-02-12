-- following https://neovim.io/doc/user/lsp.html#lsp-defaults
local function lsp_keymap(bufnr)
  local bufopts = { noremap = true, silent = true, buffer = bufnr }
  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
  vim.keymap.set('n', '<C-s>', vim.lsp.buf.signature_help, bufopts)
  vim.keymap.set('n', 'gy', vim.lsp.buf.type_definition, bufopts)
  vim.keymap.set('n', 'grr', vim.lsp.buf.references, bufopts)
  vim.keymap.set('n', 'grn', vim.lsp.buf.rename, bufopts)
  vim.keymap.set('n', 'gra', vim.lsp.buf.code_action, bufopts)
  vim.keymap.set('n', 'gri', vim.lsp.buf.implementation, bufopts)
  vim.keymap.set('n', 'gO', vim.lsp.buf.document_symbol, bufopts)
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
  -- {
  --   'nvimdev/lspsaga.nvim',
  --   config = function()
  --     require('lspsaga').setup({})
  --   end,
  -- },
  {
    'neovim/nvim-lspconfig',
    event = "VeryLazy",
    dependencies = {
      { "epwalsh/obsidian.nvim" },
      {
        'saghen/blink.cmp',
        event = "VeryLazy",
        enabled = true,
        build = 'cargo +nightly build --release',
        version = '*',
        opts_extend = { "sources.default" },
        dependencies = {
          { "saghen/blink.compat",          lazy = true, verson = false },
          { "rafamadriz/friendly-snippets", lazy = true, verson = false },
        },
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
              accept = { auto_brackets = { enabled = true }, },
              list = { selection = { preselect = true, auto_insert = true } },
            },
            keymap = {
              preset = 'super-tab',
              ["<c-e>"] = {
              },
            }, -- default super-tab enter
            appearance = {
              use_nvim_cmp_as_default = false,
              nerd_font_variant = 'mono'
            },
            sources = {
              default = {
                'lsp',
                'path',
                'snippets',
                'buffer',
                'obsidian',
                'obsidian_new',
                'obsidian_tags',
              },
              providers = {
                obsidian = { name = "obsidian", module = "blink.compat.source" },
                obsidian_new = { name = "obsidian_new", module = "blink.compat.source" },
                obsidian_tags = { name = "obsidian_tags", module = "blink.compat.source" },
                path = {
                  max_items = 3,
                  -- min_keyword_length = 2,
                },
                lsp = {
                  -- max_items = 5
                  -- min_keyword_length = 2,
                },
                buffer = {
                  -- max_items = 3,
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
        ruby_lsp    = {
          mason = false,
          cmd = { "ruby-lsp" },
          filetypes = { "ruby" },
          root_dir = lspconfig.util.root_pattern("Gemfile", ".git"),
          init_options = {
            formatter = 'standard',
            linters = { 'standard' },
          },
        },
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
        -- stimulus_ls = {},
        --
        phpactor    = {},
        denols      = {
          cmd = { "deno", "lsp" },
          filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
          root_dir = lspconfig.util.root_pattern("deno.json", "deno.jsonc"),
        },
        tailwindcss = {},
        cssls       = {},
        elixirls    = {
          cmd       = { "elixir-ls" },
          filetypes = { "elixir", "eelixir", "heex", "surface" },
          -- settings  = {
          -- elixirLS = {
          --   dialyzerEnabled = false,
          --   fetchDeps = false,
          --   autoBuild = false,
          -- },
          -- }
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
        local capabilities                                                 = require('blink.cmp').get_lsp_capabilities(
          config.capabilities)
        -- disable lsp snippets as it distracts coding
        capabilities.textDocument.completion.completionItem.snippetSupport = true
        config.on_attach                                                   = function(_, bufnr)
          lsp_keymap(bufnr)
        end
        config.capabilities                                                = capabilities
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
    enabled = true,
    dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
    config = function()
      require("typescript-tools").setup {
        handlers = handlers,
        single_file_support = false,
        on_attach = function(client, bufnr)
          lsp_keymap(bufnr)
        end,
        settings = {
          root_dir = require('lspconfig').util.root_pattern("package.json"),
          jsx_close_tag = {
            enable = false,
            filetypes = { "javascriptreact", "typescriptreact" },
          }
        }
      }
    end
  }
}
