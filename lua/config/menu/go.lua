-- config/menu/go.lua
local base_menu = require("config.menu.base")
local M = {}

local function open_terminal(command)
  Snacks.terminal.open(command, {
    win = {
      width = 0.6,
      height = 0.5,
      border = "rounded",
      title = "Go Terminal",
      title_pos = "center",
    },
    auto_close = false,
    auto_insert = false,
    interactive = false,
  })
end

local function run_go_file()
  local current_file = vim.fn.expand("%")
  local command = "go run " .. current_file
  open_terminal(command)
end

local function build_go()
  local command = "go build"
  open_terminal(command)
end

local function test_go()
  local command = "go test ./..."
  open_terminal(command)
end

local function test_go_file()
  local current_file = vim.fn.expand("%")
  local command = "go test " .. current_file
  open_terminal(command)
end

local function format_go()
  local command = "go fmt ./..."
  open_terminal(command)
end

function M.open_menu()
  -- Copia las opciones comunes del módulo base
  local menu_items = vim.deepcopy(base_menu.common_options)

  -- Agrega las opciones específicas de Go
  table.insert(menu_items, {
    name = "󱓞  Run Go",
    hl = "@conditional",
    cmd = run_go_file,
    rtxt = "r",
  })
  table.insert(menu_items, {
    name = "  Build Go",
    hl = "@conditional",
    cmd = build_go,
    rtxt = "b",
  })
  table.insert(menu_items, {
    name = "󰤑  Test Go",
    hl = "@conditional",
    cmd = test_go,
    rtxt = "t",
  })
  table.insert(menu_items, {
    name = "󰤑  Test Go File",
    hl = "@conditional",
    cmd = test_go_file,
    rtxt = "f",
  })
  table.insert(menu_items, {
    name = "󰤑  Format Go",
    hl = "@conditional",
    cmd = format_go,
    rtxt = "m",
  })
  -- Abrir el menú con las opciones
  require("menu").open(menu_items)
end

return M
