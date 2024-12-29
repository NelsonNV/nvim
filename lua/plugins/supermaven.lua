return {
  "supermaven-inc/supermaven-nvim",
  lazy = true,
  config = function()
    require("supermaven-nvim").setup({
      keymaps = {},
      ignore_filetypes = { cpp = true }, -- or { "cpp", }
      color = {
        -- suggestion_color = "#EDE3E4",
        suggestion_color = "#FF0000",
        cterm = 244,
      },
      log_level = "info", -- set to "off" to disable logging completely
      disable_inline_completion = false, -- disables inline completion for use with cmp
      disable_keymaps = false, -- disables built in keymaps for more manual control
      condition = function()
        return false
      end, -- condition to check for stopping supermaven, `true` means to stop supermaven when the condition is true.
    })

    local completion_preview = require("supermaven-nvim.completion_preview")
    vim.keymap.set("i", "<TAB>", completion_preview.on_accept_suggestion, { noremap = true, silent = true })
    vim.keymap.set("i", "<c-j>", completion_preview.on_accept_suggestion_word, { noremap = true, silent = true })
  end,
}
