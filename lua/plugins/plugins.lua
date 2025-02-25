return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    opts = {
      window = {
        position = "right",
      },
    },
  },
  { "kdheepak/lazygit.nvim", name = "lazygit", lazy = true, cmd = "LazyGit" },
  { "kylechui/nvim-surround", event = "VeryLazy", lazy = true, opts = {} },
  {
    "Wansmer/treesj",
    lazy = true,
    cmd = { "TSJToggle", "TSJSplit", "TSJJoin" },
    opts = { use_default_keymaps = false },
  },
}
