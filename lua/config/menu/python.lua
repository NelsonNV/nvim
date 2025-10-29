-- config/menu/python.lua
local base_menu = require("config.menu.base")
local M = {}

local function find_project_root()
  local current_dir = vim.fn.getcwd()

  -- Buscar .git recursivamente hacia arriba
  local git_dir = vim.fn.finddir(".git", ".;")
  if git_dir ~= "" then
    return vim.fn.fnamemodify(git_dir, ":p:h:h")
  end

  -- Buscar manage.py recursivamente
  local manage_py = vim.fn.findfile("manage.py", ".;")
  if manage_py ~= "" then
    return vim.fn.fnamemodify(manage_py, ":p:h")
  end

  -- Buscar requirements.txt o pyproject.toml
  local requirements = vim.fn.findfile("requirements.txt", ".;")
  if requirements ~= "" then
    return vim.fn.fnamemodify(requirements, ":p:h")
  end

  local pyproject = vim.fn.findfile("pyproject.toml", ".;")
  if pyproject ~= "" then
    return vim.fn.fnamemodify(pyproject, ":p:h")
  end

  return current_dir
end

local function find_manage_py()
  local root = find_project_root()

  -- Buscar manage.py en la raíz y subdirectorios comunes
  local locations = {
    "",
    "backend/",
    "app/",
    "src/",
    "django/",
    "project/",
  }

  for _, location in ipairs(locations) do
    local path = root .. "/" .. location .. "manage.py"
    if vim.fn.filereadable(path) == 1 then
      return path
    end
  end

  -- Búsqueda recursiva como fallback
  local recursive_manage = vim.fn.findfile("manage.py", root .. "/**")
  if recursive_manage ~= "" then
    return recursive_manage
  end

  return ""
end

local function is_django_project()
  local manage_py = find_manage_py()
  if manage_py == "" then
    return false
  end

  -- Verificar adicionalmente que manage.py tenga contenido de Django
  local file = io.open(manage_py, "r")
  if file then
    local content = file:read("*all")
    file:close()
    return content:find("django") ~= nil or content:find("DJANGO") ~= nil
  end

  return true
end

local function find_venv_path()
  local venv_names = { ".venv", "venv", "env" }
  local root = find_project_root()

  -- Buscar en ubicaciones comunes
  local common_locations = {
    "",
    "backend/",
    "app/",
    "src/",
    ".venv/",
    "venv/",
  }

  for _, venv_name in ipairs(venv_names) do
    for _, location in ipairs(common_locations) do
      local venv_path = root .. "/" .. location .. venv_name
      if vim.fn.isdirectory(venv_path) == 1 then
        return venv_path
      end
    end

    -- Búsqueda recursiva como fallback
    local recursive_venv = vim.fn.finddir(venv_name, root .. "/**")
    if recursive_venv ~= "" then
      return vim.fn.fnamemodify(recursive_venv, ":p")
    end
  end

  return ""
end

local function get_python_path()
  local venv_path = find_venv_path()
  if venv_path == "" then
    return "python"
  end

  -- Verificar si es un entorno virtual de Linux/Mac
  local linux_python = venv_path .. "/bin/python"
  if vim.fn.filereadable(linux_python) == 1 then
    return linux_python
  end

  -- Verificar si es un entorno virtual de Windows
  local windows_python = venv_path .. "/Scripts/python"
  if vim.fn.filereadable(windows_python) == 1 then
    return windows_python
  end

  return "python"
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
    auto_close = false,
    auto_insert = false,
    interactive = false,
  })
end

local function stop_server()
  local handle = io.popen("pgrep -f 'python.*manage.py.*runserver'")
  if handle == nil then
    print("Error: no se pudo ejecutar pgrep")
    return
  end
  local result = handle:read("*a")
  handle:close()

  if result ~= "" then
    os.execute("pkill -f 'python.*manage.py.*runserver'")
    print("Server stopped.")
  else
    print("No server is running.")
  end
end

local function run_tests()
  local python_cmd = get_python_path()
  local command
  if is_django_project() then
    local manage_py = find_manage_py()
    command = python_cmd .. " " .. manage_py .. " test"
  else
    -- Verificar si existe pytest.ini o setup.cfg con configuración de pytest
    local root = find_project_root()
    local has_pytest_config = vim.fn.filereadable(root .. "/pytest.ini") == 1
      or vim.fn.filereadable(root .. "/setup.cfg") == 1
      or vim.fn.filereadable(root .. "/pyproject.toml") == 1

    if has_pytest_config or vim.fn.executable("pytest") == 1 then
      command = python_cmd .. " -m pytest"
    else
      command = python_cmd .. " -m unittest discover"
    end
  end
  open_terminal(command)
end

local function run_test_file()
  local current_file = vim.fn.expand("%:p")
  local python_cmd = get_python_path()
  local command

  if is_django_project() then
    local manage_py = find_manage_py()
    -- Convertir ruta absoluta a módulo Python
    local root = find_project_root()
    local module_path = current_file:gsub(root .. "/", "")
    module_path = module_path:gsub("/", ".")
    module_path = module_path:gsub(".py$", "")
    module_path = module_path:gsub(".__init__", "") -- Para archivos __init__.py

    module_path = vim.fn.input("Edit module path: ", module_path)
    command = python_cmd .. " " .. manage_py .. " test " .. module_path
  else
    command = python_cmd .. " -m pytest " .. current_file
  end
  open_terminal(command)
end

local function run_code()
  stop_server()
  local python_cmd = get_python_path()
  local command
  if is_django_project() then
    local manage_py = find_manage_py()
    command = python_cmd .. " " .. manage_py .. " runserver"
  else
    command = python_cmd .. " " .. vim.fn.expand("%:p")
  end
  open_terminal(command)
end

local function run_code_debug()
  stop_server()
  local python_cmd = get_python_path()
  local command
  if is_django_project() then
    local manage_py = find_manage_py()
    command = python_cmd .. " " .. manage_py .. " runserver --noreload"
  else
    command = python_cmd .. " -m pdb " .. vim.fn.expand("%:p")
  end
  open_terminal(command)
end

local function open_django_shell()
  local python_cmd = get_python_path()
  local manage_py = find_manage_py()
  local command = python_cmd .. " " .. manage_py .. " shell"
  open_terminal(command)
end

local function open_django_shell_plus()
  local python_cmd = get_python_path()
  local manage_py = find_manage_py()
  local command = python_cmd .. " " .. manage_py .. " shell -v2"
  open_terminal(command)
end

local function run_migrations()
  local python_cmd = get_python_path()
  local manage_py = find_manage_py()
  local command = python_cmd .. " " .. manage_py .. " migrate"
  open_terminal(command)
end

local function run_makemigrations()
  local python_cmd = get_python_path()
  local manage_py = find_manage_py()
  local command = python_cmd .. " " .. manage_py .. " makemigrations"
  open_terminal(command)
end

local function run_create_superuser()
  local python_cmd = get_python_path()
  local manage_py = find_manage_py()
  local command = python_cmd .. " " .. manage_py .. " createsuperuser"
  open_terminal(command)
end

function M.open_menu()
  local menu_items = vim.deepcopy(base_menu.common_options)

  table.insert(menu_items, {
    name = "󰤑  Run Tests",
    hl = "@conditional",
    cmd = run_tests,
    rtxt = "t",
  })
  table.insert(menu_items, {
    name = "󰤑  Run Test File",
    hl = "@conditional",
    cmd = run_test_file,
    rtxt = "f",
  })
  table.insert(menu_items, { name = "separator" })
  table.insert(menu_items, {
    name = "  Run Code",
    cmd = run_code,
    rtxt = "r",
  })
  table.insert(menu_items, {
    name = "󱏛  Run Code (Debug)",
    cmd = run_code_debug,
    rtxt = "d",
  })

  if is_django_project() then
    table.insert(menu_items, { name = "separator" })
    table.insert(menu_items, {
      name = "  Django Shell",
      cmd = open_django_shell,
      rtxt = "s",
    })
    table.insert(menu_items, {
      name = "  Django Shell v2",
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
    table.insert(menu_items, {
      name = "  Create SuperUser",
      cmd = run_create_superuser,
      rtxt = "c",
    })
  end

  require("menu").open(menu_items)
end

return M
