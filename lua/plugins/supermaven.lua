return {
  "supermaven-inc/supermaven-nvim",
  dependencies = {
    "onsails/lspkind.nvim",
  },
  config = function()
    -- Configuración de lspkind
    require("lspkind").init()

    -- Configuración de supermaven-nvim
    require("supermaven-nvim").setup({
      keymaps = {},
      ignore_filetypes = { cpp = true },
      color = {
        suggestion_color = "#EDE3E4",
        cterm = 244,
      },
      log_level = "info",
      disable_inline_completion = false,
      disable_keymaps = false,
      formatting = {
        format = require("lspkind").cmp_format({
          mode = "symbol",
          max_width = 50,
          symbol_map = { Supermaven = "" },
        }),
      },
      condition = function()
        return false
      end,
    })

    -- Verificación de funciones antes de asignar keymaps
    local supermaven = require("supermaven-nvim")
    local completion_preview = require("supermaven-nvim.completion_preview")

    if supermaven and completion_preview.on_accept_suggestion then
      vim.keymap.set("i", "<c-y>", completion_preview.on_accept_suggestion, { noremap = true, silent = true })
    else
      vim.notify("supermaven-nvim: on_accept_suggestion no está definido", vim.log.levels.WARN)
    end

    if completion_preview and completion_preview.on_accept_suggestion_word then
      vim.keymap.set("i", "<c-j>", completion_preview.on_accept_suggestion_word, { noremap = true, silent = true })
    else
      vim.notify("supermaven-nvim: on_accept_suggestion_word no está definido", vim.log.levels.WARN)
    end
  end,
}
