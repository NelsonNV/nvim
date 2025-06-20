-- config/menu/base.lua
local M = {}

-- Opciones comunes que se usarán en todos los menús
M.common_options = {
  {
    name = "󰈚  Icon Search",
    cmd = function()
      vim.cmd("IconPickerInsert")
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
    name = "󰘦  Toggle Tressitter join",
    cmd = function()
      vim.cmd("TSJToggle")
    end,
    rtxt = "m",
  })
  table.insert(menu_items, {
    name = " To-do",
    cmd = function()
      vim.cmd("Dooing")
    end,
    rtxt = "d",
  })

  -- Abrir el menú con las opciones
  require("menu").open(menu_items)
end

return M
