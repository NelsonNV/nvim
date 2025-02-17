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

vim.api.nvim_set_keymap("v", "{", "}", { noremap = true, silent = true })
vim.api.nvim_set_keymap("v", "}", "{", { noremap = true, silent = true })

vim.api.nvim_set_keymap("n", "[[", "]]", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "]]", "[[", { noremap = true, silent = true })

-- Selecionar Menu

local menus = {
  python = "config.menu.python",
}

vim.api.nvim_create_autocmd("FileType", {
  pattern = vim.tbl_keys(menus),
  callback = function(event)
    local menu = menus[event.match]
    if menu then
      vim.keymap.set("n", "<C-m>", function()
        require(menu).open_menu()
      end, { buffer = true, desc = "Abrir menú de " .. event.match })
    end
  end,
})

-- Menú por defecto (se usará cuando no haya un menú específico)
vim.api.nvim_create_autocmd("FileType", {
  pattern = "*", -- Aplica a todos los tipos de archivo
  callback = function(event)
    local menu = menus[event.match]
    if not menu then
      vim.keymap.set("n", "<C-m>", function()
        require("config.menu.base").default_menu()
      end, { buffer = true, desc = "Abrir menú por defecto" })
    end
  end,
})
