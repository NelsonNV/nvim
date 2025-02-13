-- config/menu/python.lua
local M = {}

local function is_django_project()
  return vim.fn.glob("manage.py") ~= ""
end

local function activate_venv()
  local venv_names = { ".venv", "venv", "env" }

  for _, venv_name in ipairs(venv_names) do
    local venv_path = vim.fn.finddir(venv_name, ".;")
    if venv_path ~= "" then
      local activate_script = "bin/activate"
      if vim.fn.has("win32") == 1 then
        activate_script = "Scripts\\activate"
      end

      local full_path = vim.fn.fnamemodify(venv_path, ":p") .. activate_script

      if vim.fn.filereadable(full_path) == 1 then
        return "source " .. full_path .. " && "
      end
    end
  end

  -- Si no se encuentra ningún entorno virtual, devolver una cadena vacía
  return ""
end

local function open_terminal(command)
  Snacks.terminal.open(command, {
    win = {
      width = 0.6,
      height = 0.5,
      border = "rounded",
      title = "Python Terminal",
      title_pos = "center",
    },
    close_on_exit = false,
  })
end

local function stop_server()
  -- Busca un proceso de Python que esté ejecutando el servidor de Django
  local handle = io.popen("pgrep -f 'python manage.py runserver'")
  local result = handle:read("*a")
  handle:close()

  if result ~= "" then
    os.execute("pkill -f 'python manage.py runserver'")
    print("Server stopped.")
  else
    print("No server is running.")
  end
end

local function run_tests()
  local command = is_django_project() and (activate_venv() .. "python manage.py test") or (activate_venv() .. "pytest")
  open_terminal(command)
end

local function run_test_file()
  local current_file = vim.fn.expand("%") -- Obtiene la ruta del archivo actual
  local command

  if is_django_project() then
    -- Transformar la ruta del archivo en formato de módulo de Django
    local module_path = current_file:gsub("/", ".") -- Reemplazar / con .
    module_path = module_path:gsub(".py$", "") -- Eliminar la extensión .py
    module_path = module_path:gsub("^%.+", "") -- Eliminar puntos iniciales (si los hay)

    command = activate_venv() .. "python manage.py test " .. module_path
  else
    -- Para pytest, ejecutar los tests del archivo actual
    command = activate_venv() .. "pytest " .. current_file
  end

  open_terminal(command)
end

local function run_code()
  stop_server() -- Detener el servidor si ya está en ejecución
  local command = is_django_project() and (activate_venv() .. "python manage.py runserver")
    or (activate_venv() .. "python " .. vim.fn.expand("%"))
  open_terminal(command)
end

local function run_code_debug()
  stop_server() -- Detener el servidor si ya está en ejecución
  local command = is_django_project() and (activate_venv() .. "python manage.py runserver --noreload")
    or (activate_venv() .. "python -m pdb " .. vim.fn.expand("%"))
  open_terminal(command)
end

local function open_django_shell()
  local command = activate_venv() .. "python manage.py shell"
  open_terminal(command)
end

local function open_django_shell_plus()
  local command = activate_venv() .. "python manage.py shell_plus"
  open_terminal(command)
end

local function run_migrations()
  local command = activate_venv() .. "python manage.py migrate"
  open_terminal(command)
end

local function run_makemigrations()
  local command = activate_venv() .. "python manage.py makemigrations"
  open_terminal(command)
end

function M.open_menu()
  -- Diccionario base de opciones del menú
  local menu_items = {
    {
      name = "󰤑  Run Tests",
      hl = "@conditional",
      cmd = run_tests,
      rtxt = "t",
    },
    {
      name = "󰤑  Run Test File",
      hl = "@conditional",
      cmd = run_test_file,
      rtxt = "f",
    },
    { name = "separator" },
    {
      name = "  Run Code",
      cmd = run_code,
      rtxt = "r",
    },
    {
      name = "󱏛  Run Code (Debug)",
      cmd = run_code_debug,
      rtxt = "d",
    },
  }

  -- Agregar opciones específicas de Django si es un proyecto Django
  if is_django_project() then
    table.insert(menu_items, { name = "separator" })
    table.insert(menu_items, {
      name = "  Django Shell",
      cmd = open_django_shell,
      rtxt = "s",
    })
    table.insert(menu_items, {
      name = "  Django Shell Plus",
      cmd = open_django_shell_plus,
      rtxt = "p",
    })
    table.insert(menu_items, { name = "separator" })
    table.insert(menu_items, {
      name = "󰪩  Run Migrations",
      cmd = run_migrations,
      rtxt = "m",
    })
    table.insert(menu_items, {
      name = "󰮆  Make Migrations",
      cmd = run_makemigrations,
      rtxt = "k",
    })
  end

  -- Abrir el menú con las opciones
  require("menu").open(menu_items)
end

return M
