local username = os.getenv("USER") or "user"

return {
  "CopilotC-Nvim/CopilotChat.nvim",
  dependencies = { { "nvim-lua/plenary.nvim", branch = "master" } },
  build = "make tiktoken",
  opts = {
    assistant_name = "luna",
    user_name = username,
    headers = {
      user = username,
      assistant = "🌙 Luna",
      tool = "🔧 Tool",
    },
    keys = {
      { "<leader>rc", "<cmd>CopilotChatToggce<CR>", desc = "Alternar chat de Copilot" },
      { "<leader>rp", "<cmd>CopilotChatPrompt<CR>", desc = "Enviar mensaje a Copilot" },
      { "<leader>ra", "<cmd>CopilotChatAccept<CR>", desc = "Aceptar respuesta de Copilot" },
    },
  },
}
