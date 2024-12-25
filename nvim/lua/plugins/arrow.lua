return {
  {
    'otavioschwanck/arrow.nvim',
    enabled = true,
    opts = {
      show_icons = true,
      leader_key = 'm',        -- Recommended to be a single key
      buffer_leader_key = '=', -- Per Buffer Mappings
      mappings = {
        edit = "e",
        delete_mode = "d",
        clear_all_items = "C",
        toggle = "a", -- used as save if separate_save_and_remove is true
        open_vertical = "v",
        open_horizontal = "-",
        quit = "q",
        remove = "x", -- only used if separate_save_and_remove is true
        next_item = "]",
        prev_item = "["
      },
    }
  }
}
