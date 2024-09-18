return {
  "nvim-treesitter/nvim-treesitter",
  enabled = true,
  build = ":TSUpdate",
  config = function()
    local treesitter = require("nvim-treesitter.configs")
    treesitter.setup({
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
        use_languagetree = false,
      },
      indent = {
        enable = true,
      },
      ensure_installed = {
        "c",
        "html",
        "astro",
        "lua",
        "graphql",
        "vim",
        "templ",
        "vimdoc",
        "markdown",
        "markdown_inline",
        "query",
        "tsx",
        "lua",
        "css",
        "json",
        "javascript",
        "rust",
        "typescript",
        "go",
        "vue",
        "python",
        "c_sharp",
        "zig",
      },
      autotag = { enable = true },
    })
  end,
}
