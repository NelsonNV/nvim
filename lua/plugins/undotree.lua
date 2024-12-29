return {
  "jiaoshijie/undotree",
  dependencies = "nvim-lua/plenary.nvim",
  config = true,
  keys = {
    { "<leader>gu", "<cmd>lua require('undotree').toggle()<cr>", desc = "Undotree" },
  },
}
