-- following https://neovim.io/doc/user/lsp.html#lsp-defaults
local function lsp_keymap(bufnr)
  local bufopts = { noremap = true, silent = true, buffer = bufnr }
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
  vim.keymap.set('n', '<C-s>', vim.lsp.buf.signature_help, bufopts)
  vim.keymap.set('n', 'gO', vim.lsp.buf.document_symbol, bufopts)
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
    "williamboman/mason-lspconfig.nvim",
    lazy = true,
    cmd = "Mason",
    event = 'VeryLazy',
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
    'neovim/nvim-lspconfig',
    event = "VeryLazy",
    dependencies = {
      -- { "epwalsh/obsidian.nvim" },
      require("plugins.blink")
    },
    config = function()
      local lspconfig = require('lspconfig')
      local servers = {
        ols           = {},
        ruby_lsp      = {
          cmd = { "ruby-lsp" },
          filetypes = { "ruby" },
          root_dir = lspconfig.util.root_pattern("Gemfile", ".git"),
          init_options = {
            formatter = 'standard',
            linters = { 'standard' },
          },
        },
        gopls         = {
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
        phpactor      = {},
        denols        = {
          cmd = { "deno", "lsp" },
          filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
          root_dir = lspconfig.util.root_pattern("deno.json", "deno.jsonc"),
        },
        tailwindcss   = {},
        cssls         = {},
        clangd        = {},
        gleam         = {},
        zls           = {},
        rust_analyzer = {},
        elixirls      = {
          cmd       = { "elixir-ls" },
          filetypes = { "elixir", "eelixir", "heex", "surface" },
        },
        bashls        = {
          filetypes = { "bash", "sh", "zsh" }
        },
        vtsls         = {},
        pyright       = {},
        lua_ls        = {
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
                  'require',
                  "Snacks"
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
  -- {
  --   "pmizio/typescript-tools.nvim",
  --   event = "VeryLazy",
  --   enabled = true,
  --   dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
  --   config = function()
  --     require("typescript-tools").setup {
  --       handlers = handlers,
  --       single_file_support = false,
  --       on_attach = function(client, bufnr)
  --         lsp_keymap(bufnr)
  --       end,
  --       settings = {
  --         root_dir = require('lspconfig').util.root_pattern("package.json"),
  --         jsx_close_tag = {
  --           enable = true,
  --           filetypes = { "javascriptreact", "typescriptreact" },
  --         },
  --         tsserver_file_preferences = {
  --           includeInlayParameterNameHints = "all",
  --           includeInlayParameterNameHintsWhenArgumentMatchesName = false,
  --           includeInlayFunctionParameterTypeHints = false,
  --           includeInlayVariableTypeHints = false,
  --           includeInlayVariableTypeHintsWhenTypeMatchesName = false,
  --           includeInlayPropertyDeclarationTypeHints = true,
  --           includeInlayFunctionLikeReturnTypeHints = true,
  --           includeInlayEnumMemberValueHints = true,
  --           includeCompletionsForModuleExports = true,
  --           quotePreference = "single",
  --         },
  --         tsserver_format_options = {
  --           allowIncompleteCompletions = false,
  --           allowRenameOfImportPath = false,
  --           semicolons = "remove",
  --         },
  --       }
  --     }
  --   end
  -- }
}
