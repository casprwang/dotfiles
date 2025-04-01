return {
  {
    'saghen/blink.cmp',
    event = "VeryLazy",
    enabled = true,
    build = 'cargo +nightly build --release',
    version = '*',
    opts_extend = { "sources.default" },
    dependencies = {
      {
        'onsails/lspkind.nvim',
        event = "VeryLazy",
      },
      { "saghen/blink.compat",          lazy = true, verson = false },
      { "rafamadriz/friendly-snippets", lazy = true, verson = false },
      {
        "xzbdmw/colorful-menu.nvim",
        event = "VeryLazy",
      }
    },
    config = function()
      require("blink.cmp").setup({
        completion = {
          ghost_text = {
            enabled = false
          },
          documentation = {
            auto_show = false,
            auto_show_delay_ms = 500,
          },
          menu = {
            draw = {
              -- We don't need label_description now because label and label_description are already
              -- conbined together in label by colorful-menu.nvim.
              columns = { { "kind_icon" }, { "label", gap = 2 }, { "provider" } },
              components = {
                label = {
                  -- width = { fill = true, max = 110 },
                  text = function(ctx)
                    return require("colorful-menu").blink_components_text(ctx)
                  end,
                  highlight = function(ctx)
                    return require("colorful-menu").blink_components_highlight(ctx)
                  end,
                },
                provider = {
                  text = function(ctx)
                    return "[" .. ctx.item.source_name:sub(1, 3):upper() .. "]"
                  end,
                  highlight = "BlinkCmpKindLabel",
                },
              },
            }
          },
          accept = { auto_brackets = { enabled = true }, },
          list = { selection = { preselect = true, auto_insert = true } },
        },
        keymap = {
          preset = 'super-tab',
          -- ["<c-e>"] = {
          -- },
          ["<c-f>"] = {
          },
          ['<Tab>'] = {
            function(cmp)
              if cmp.snippet_active() then
                return cmp.accept()
              else
                return cmp.select_and_accept()
              end
            end,
            'snippet_forward',
            'fallback'
          },
        }, -- default super-tab enter
        appearance = {
          use_nvim_cmp_as_default = false,
          nerd_font_variant = 'mono',
          kind_icons = {
            Text = '󰉿',
            Method = '󰊕',
            Function = '󰊕',
            Constructor = '󰒓',

            Field = '󰜢',
            Variable = '󰆦',
            Property = '󰖷',

            Class = '󱡠',
            Interface = '󱡠',
            Struct = '󱡠',
            Module = '󰅩',

            Unit = '󰪚',
            Value = '󰦨',
            Enum = '󰦨',
            EnumMember = '󰦨',

            Keyword = '󰻾',
            Constant = '󰏿',

            Snippet = '󱄽',
            Color = '󰏘',
            File = '󰈔',
            Reference = '󰬲',
            Folder = '󰉋',
            Event = '󱐋',
            Operator = '󰪚',
            TypeParameter = '󰬛',
          },
        },
        sources = {
          default = {
            'lsp',
            'path',
            'snippets',
            'buffer',
          },
          providers = {
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
          },

        },
      })
      if vim.fn.has('nvim-0.11') == 1 then
        -- Ensure that forced and not configurable `<Tab>` and `<S-Tab>`
        -- buffer-local mappings don't override already present ones
        local expand_orig = vim.snippet.expand
        vim.snippet.expand = function(...)
          local tab_map = vim.fn.maparg('<Tab>', 'i', false, true)
          local stab_map = vim.fn.maparg('<S-Tab>', 'i', false, true)
          expand_orig(...)
          vim.schedule(function()
            tab_map.buffer, stab_map.buffer = 1, 1
            -- Override temporarily forced buffer-local mappings
            vim.fn.mapset('i', false, tab_map)
            vim.fn.mapset('i', false, stab_map)
          end)
        end
      end
      vim.cmd [[
        hi! BlinkCmpLabelMatch gui=bold guifg=NONE
      ]]
    end
  },
  {
    'saghen/blink.nvim',
    -- all modules handle lazy loading internally
    lazy = false,
    enabled = false,
    opts = {
      indent = {
        enabled = true,
        -- start with indent guides visible
        visible = true,
        blocked = {
          buftypes = {},
          filetypes = {},
        },
        static = {
          enabled = false,
          char = '▎',
          priority = 1,
          -- specify multiple highlights here for rainbow-style indent guides
          -- highlights = { 'BlinkIndentRed', 'BlinkIndentOrange', 'BlinkIndentYellow', 'BlinkIndentGreen', 'BlinkIndentViolet', 'BlinkIndentCyan' },
          highlights = { 'BlinkIndent' },
        },
        scope = {
          enabled = true,
          char = '▎',
          priority = 1024,
          -- set this to a single highlight, such as 'BlinkIndent' to disable rainbow-style indent guides
          -- highlights = { 'BlinkIndent' },
          highlights = {
            'BlinkIndentRed',
            'BlinkIndentYellow',
            'BlinkIndentBlue',
            'BlinkIndentOrange',
            'BlinkIndentGreen',
            'BlinkIndentViolet',
            'BlinkIndentCyan',
          },
          underline = {
            -- enable to show underlines on the line above the current scope
            enabled = false,
            highlights = {
              'BlinkIndentRedUnderline',
              'BlinkIndentYellowUnderline',
              'BlinkIndentBlueUnderline',
              'BlinkIndentOrangeUnderline',
              'BlinkIndentGreenUnderline',
              'BlinkIndentVioletUnderline',
              'BlinkIndentCyanUnderline',
            },
          },
        },
      },
    },
  },
  {
    'saghen/blink.pairs',
    version = '*', -- (recommended) only required with prebuilt binaries

    -- download prebuilt binaries from github releases
    dependencies = 'saghen/blink.download',
    -- OR build from source
    build = 'cargo build --release',

    --- @module 'blink.pairs'
    --- @type blink.pairs.Config
    opts = {
      mappings = {
        enabled = true,
        -- see the defaults: https://github.com/Saghen/blink.pairs/blob/main/lua/blink/pairs/config/mappings.lua#L10
        pairs = {},
      },
      highlights = {
        enabled = true,
        groups = {
          'BlinkPairsOrange',
          'BlinkPairsPurple',
          'BlinkPairsBlue',
        },
      },
      debug = false,
    }
  },
}
