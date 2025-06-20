return {
  "ziontee113/icon-picker.nvim",
  cmd = { "IconPickerInsert", "IconPickerNormal" },
  config = function()
    require("icon-picker").setup({ disable_legacy_commands = true })
  end,
}
