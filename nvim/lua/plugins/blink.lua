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
      { "saghen/blink.compat", lazy = true, verson = false },
      -- { "rafamadriz/friendly-snippets", lazy = true, verson = false },
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
          accept = { auto_brackets = { enabled = true }, },
          list = { selection = { preselect = true, auto_insert = true } },
        },
        keymap = {
          preset = 'super-tab',
          -- preset = 'enter',
          ["<c-f>"] = {
          },
          ['<CR>'] = { 'accept', 'fallback' },
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
            -- 'snippets',
            'buffer',
          },
          providers = {
            path = {
              max_items = 3,
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
    'windwp/nvim-autopairs',
    event = "InsertEnter",
    config = true,
    enabled = true,
    -- use opts = {} for passing setup options
    -- this is equivalent to setup({}) function
  },
}
