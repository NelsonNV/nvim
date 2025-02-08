return {
  "folke/tokyonight.nvim",
  lazy = true,
  priority = 1000,
  opts = {
    transparent = true,
    styles = {
      sidebars = "transparent",
      floats = "transparent",
    },
    on_highlights = function(hl, c)
      hl.WinSeparator = {
        fg = "#9d7cd8", -- color purple tokyonight
        bg = "None",
        bold = true,
      }
    end,
  },
}
