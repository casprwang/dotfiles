return {
  "folke/noice.nvim",
  event = "VeryLazy",
  enabled = true,
  dependencies = {
    "MunifTanjim/nui.nvim",
  },
  opts = {
    messages = {
      view_search = "virtualtext", -- view for search count messages. Set to `false` to disable
    },
    routes = {
      -- {
      --   view = "notify",
      --   filter = { event = "msg_showmode" },
      -- },
      {
        filter = { event = "msg_show", kind = "quickfix" },
        opts = { view = "mini" },
      },

      {
        filter = {
          event = "msg_show",
          kind = "rubyfmt",
          find = "rubyfmt",
        },
        opts = { skip = true },
      },
    },
    lsp = {
      -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
      progress = {
        enabled = false,
      },
      documentation = {
        opts = {
          max_height = 2,
          border = { style = 'rounded' },
          relative = 'cursor',
          position = {
          },
          win_options = {
            concealcursor = 'n',
            conceallevel = 1,
          },
        },
      },
      signature = {
      },
      override = {
        ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
        ["vim.lsp.util.stylize_markdown"] = true,
        ["cmp.entry.get_documentation"] = true,
      },
    },
    -- you can enable a preset for easier configuration
    presets = {
      bottom_search = true,         -- use a classic bottom cmdline for search
      command_palette = false,      -- position the cmdline and popupmenu together
      long_message_to_split = true, -- long messages will be sent to a split
      inc_rename = true,            -- enables an input dialog for inc-rename.nvim
      lsp_doc_border = true,        -- add a border to hover docs and signature help
    },
    cmdline = {
      view = "cmdline",
    },
    views = {
      -- https://github.com/folke/noice.nvim/blob/main/lua/noice/config/views.lua
      mini = {
        timeout = 4000, -- Duration between show() and hide(), in milliseconds
        win_options = {
          winblend = 0,
        },
        winhighlight = {},
        size = {
          width = "auto",
          height = "auto",
          max_height = 2,
        },
      },
    }
  },
  config = function(_, opts)
    require("noice").setup(opts)
    local search = vim.api.nvim_get_hl_by_name("Search", true)
    vim.api.nvim_set_hl(0, 'TransparentSearch', { fg = search.foreground })

    local help = vim.api.nvim_get_hl_by_name("IncSearch", true)
    vim.api.nvim_set_hl(0, 'TransparentHelp', { fg = help.foreground })

    local cmdGroup = 'DevIconLua'
    local noice_cmd_types = {
      CmdLine    = cmdGroup,
      Input      = cmdGroup,
      Lua        = cmdGroup,
      Filter     = cmdGroup,
      Rename     = cmdGroup,
      Substitute = "Define",
      Help       = "TransparentHelp",
      Search     = "TransparentSearch"
    }

    for type, hl in pairs(noice_cmd_types) do
      vim.api.nvim_set_hl(0, "NoiceCmdlinePopupBorder" .. type, { link = hl })
      vim.api.nvim_set_hl(0, "NoiceCmdlineIcon" .. type, { link = hl })
    end
    vim.api.nvim_set_hl(0, "NoiceConfirmBorder", { link = cmdGroup })
  end
}
