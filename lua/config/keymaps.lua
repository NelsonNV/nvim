-- Cargar comandos personalizados
require("config.utils.removeCharM")
require("config.utils.copyfile")
local g = vim.g

-- Mapeo de comandos de vim-visual-multi
g.VM_maps = {
  ["Find Under"] = "<C-d>", -- Reemplazar C-n
  ["Find Subword Under"] = "<C-d>", -- Reemplazar visual C-n
  ["Select Cursor Down"] = "<M-C-Down>", -- Selección hacia abajo
  ["Select Cursor Up"] = "<M-C-Up>", -- Selección hacia arriba
}

-- Mapear el comando RemoveCtrlM
vim.keymap.set("n", "<leader>rm", ":RemoveCtrlM<CR>", { desc = "Elimina ^M o muestra mensaje limpio" })

-- Mapear el comando CopyFileToClipboard
vim.keymap.set("n", "<leader>cp", ":CopyFile<CR>", { desc = "Copiar archivo al portapapeles" })

-- Invertir funcion por teclado corne

vim.api.nvim_set_keymap("n", "{", "}", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "}", "{", { noremap = true, silent = true })

vim.api.nvim_set_keymap("n", "[[", "]]", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "]]", "[[", { noremap = true, silent = true })

