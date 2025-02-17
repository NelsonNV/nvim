-- config/menu/base.lua
local M = {}

-- Opciones comunes que se usarán en todos los menús
M.common_options = {
  {
    name = "󰈚  Icon Search",
    cmd = function()
      -- Aquí puedes llamar a la función o plugin de búsqueda de íconos
      print("Searching icons...")
    end,
    rtxt = "i",
  },
  {
    name = "separator",
  },
}

-- Menú por defecto (se usará cuando no haya un menú específico)
function M.default_menu()
  local menu_items = vim.deepcopy(M.common_options) -- Copia las opciones comunes

  -- Agrega opciones adicionales para el menú por defecto
  table.insert(menu_items, {
    name = "  Open File",
    cmd = function()
      vim.cmd("Telescope find_files")
    end,
    rtxt = "f",
  })
  table.insert(menu_items, {
    name = "  Search Text",
    cmd = function()
      vim.cmd("Telescope live_grep")
    end,
    rtxt = "s",
  })

  -- Abrir el menú con las opciones
  require("menu").open(menu_items)
end

return M
