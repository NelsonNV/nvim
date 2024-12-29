-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
vim.g.loaded_undotree = 4
vim.o.number = true
vim.o.relativenumber = true
vim.o.mouse = "a"
vim.o.encoding = "utf-8"
vim.o.syntax = "on"
-- formato de archivos para evitar caracteres de salto de línea
vim.opt.fileformats = { "unix", "dos" }
-- Configuración personalizada para el título de la ventana
vim.o.title = true
vim.o.titlestring = " : %-24.55F %a%r%m"
vim.o.titlelen = 70
-- habilitar el portapaples
vim.o.clipboard = "unnamedplus"
vim.o.ruler = true
-- LSP
vim.g.lazyvim_php_lsp = "intelephense"
vim.g.lazyvim_python_lsp = "pyright"
vim.g.lazyvim_python_ruff = "ruff"
local opts = vim.opt
opts = {
  ensure_installed = {
    "ninja",
    "rst",
    "phpcs",
    "php-cs-fixer",
  },
}
