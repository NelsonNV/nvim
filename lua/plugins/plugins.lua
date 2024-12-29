return {
  { "github/copilot.vim", name = "copilot", lazy = false, cmd = "Copilot" },
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
    keys = { {
      "<leader>m",
      "<CMD>TSJToggle<CR>",
      desc = "Toggle Tressitter join",
    } },
    cmd = { "TSJToggle", "TSJSplit", "TSJJoin" },
    opts = { use_default_keymaps = false },
  },
  {
    "mg979/vim-visual-multi",
    name = "vim-visual-multi",
    lazy = true,
    keys = {
      { "<C-d>", desc = "multiple cursor select" },
      { "<C-Up>", desc = "move cursor up (multi)" },
      { "<C-Down>", desc = "move cursor down (multi)" },
    },
  },
}
