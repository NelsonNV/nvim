local base_menu = require("config.menu.base")
local M = {}

local function open_terminal(command)
  Snacks.terminal.open(command, {
    win = {
      width = 0.6,
      height = 0.5,
      border = "rounded",
      title = "php terminal",
      title_pos = "center",
    },
    auto_close = false,
    auto_insert = false,
    interactive = false,
  })
end

local function run_code()
  local command = "php run"
  open_terminal(command)
end

local function run_tests()
  local command = "php test"
  open_terminal(command)
end

local function run_check()
  local command = "php test"
  open_terminal(command)
end

function M.open_menu()
  -- Copia las opciones comunes del módulo base
  local menu_items = vim.deepcopy(base_menu.common_options)

  -- Agrega las opciones específicas de Python
  table.insert(menu_items, {
    name = "󰤑  Run Tests",
    hl = "@conditional",
    cmd = run_tests,
    rtxt = "t",
  })

  table.insert(menu_items, {
    name = "󱓳  Run Check",
    hl = "@conditional",
    cmd = run_check,
    rtxt = "f",
  })

  table.insert(menu_items, { name = "separator" })

  table.insert(menu_items, {
    name = "  Run Code",
    cmd = run_code,
    rtxt = "r",
  })

  -- Abrir el menú con las opciones
  require("menu").open(menu_items)
end

return M
