return {
  "monkoose/neocodeium",
  event = "VeryLazy",
  enabled = false,
  config = function()
    local neocodeium = require("neocodeium")
    neocodeium.setup({
      show_label = false
    })
    vim.keymap.set("i", "<tab>", neocodeium.accept)
  end,
}
