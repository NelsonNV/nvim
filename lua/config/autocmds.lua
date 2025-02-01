-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

-- Highlight trailing whitespace

local colorWhiteSpaceFont = "#ff007c"
local colorWitheSpaceBackground = "#414868"

vim.cmd(
  string.format(
    [[ autocmd BufReadPre * hi TrailingWhitespace guibg=%s guifg=%s | match TrailingWhitespace /\s\+$/ ]],
    colorWitheSpaceBackground,
    colorWhiteSpaceFont
  )
)
