return {
  {
    "folke/tokyonight.nvim",
    lazy = true,
    opts = {
      style = "moon",
      on_highlights = function(hl, c)
        hl.WinSeparator = {
          fg = "#9d7cd8", -- color purple tokyonight
          bg = "None",
          bold = true,
        }
      end,
    },
  },
}
