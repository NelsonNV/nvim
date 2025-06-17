local base_menu = require("config.menu.base")
local M = {}

local function read_toml_name(filepath)
  local lines = vim.fn.readfile(filepath)
  for _, line in ipairs(lines) do
    if line:match("^%s*name%s*=%s*") then
      return line:match("name%s*=%s*[\"']?(.-)[\"']?")
    end
  end
  return nil
end

local function is_pyproject()
  return vim.fn.filereadable("pyproject.toml") == 1
end

local function is_cargo_project()
  return vim.fn.filereadable("Cargo.toml") == 1
end

local function get_project_type()
  if is_pyproject() then
    local name = read_toml_name("pyproject.toml")
    if name then
      return "python"
    end
  elseif is_cargo_project() then
    local name = read_toml_name("Cargo.toml")
    if name then
      return "rust"
    end
  end
  return nil
end

-- Plantillas base

local function insert_pyproject_template()
  local year = os.date("%Y") -- Obtiene el año actual como string

  local template = string.format(
    [[
[project]
name = "my_project"
version = "0.1.0"
dependencies = []

[tool.poetry]
name = "my_project"
version = "0.1.0"
description = ""
authors = ["Your Name <you@example.com>"]
copyright = "© %s Your Name"
  ]],
    year
  )

  vim.fn.append(0, vim.split(template, "\n"))
end

local function insert_cargo_template()
  local year = os.date("%Y")

  local template = string.format(
    [[
[package]
name = "my_project"
version = "0.1.0"
edition = "2021"

[dependencies]

# © %s Your Name
  ]],
    year
  )

  vim.fn.append(0, vim.split(template, "\n"))
end

-- Comandos generales
local function add_python_dependency()
  local dep = vim.fn.input("Dependency to add (e.g. requests): ")
  if dep ~= "" then
    os.execute("poetry add " .. dep)
    print("Dependency added: " .. dep)
  end
end

local function add_python_temp_dependency()
  local dep = vim.fn.input("Install temporarily (not saved): ")
  if dep ~= "" then
    os.execute("pip install " .. dep)
    print("Temp installed: " .. dep)
  end
end

local function add_rust_dependency()
  local dep = vim.fn.input("Crate to add (e.g. serde): ")
  if dep ~= "" then
    os.execute("cargo add " .. dep)
    print("Crate added: " .. dep)
  end
end

local function install_rust()
  os.execute("cargo build")
  print("Rust project built.")
end

local function run_rust()
  os.execute("cargo run")
end

local function run_python()
  os.execute("poetry run python")
end

function M.open_menu()
  local menu_items = vim.deepcopy(base_menu.common_options)
  local project_type = get_project_type()

  table.insert(menu_items, { name = "separator" })

  if project_type == "python" then
    table.insert(menu_items, {
      name = "  Insert Pyproject Template",
      cmd = insert_pyproject_template,
      rtxt = "t",
    })
    table.insert(menu_items, {
      name = "  Poetry Add Dependency",
      cmd = add_python_dependency,
      rtxt = "a",
    })
    table.insert(menu_items, {
      name = "  Temp Install Dependency",
      cmd = add_python_temp_dependency,
      rtxt = "i",
    })
    table.insert(menu_items, {
      name = "  Run Python (Poetry)",
      cmd = run_python,
      rtxt = "r",
    })
  elseif project_type == "rust" then
    table.insert(menu_items, {
      name = "  Insert Cargo Template",
      cmd = insert_cargo_template,
      rtxt = "t",
    })
    table.insert(menu_items, {
      name = "  Cargo Add Crate",
      cmd = add_rust_dependency,
      rtxt = "a",
    })
    table.insert(menu_items, {
      name = "  Cargo Build",
      cmd = install_rust,
      rtxt = "b",
    })
    table.insert(menu_items, {
      name = "  Cargo Run",
      cmd = run_rust,
      rtxt = "r",
    })
  else
    table.insert(menu_items, {
      name = "  Not a recognized TOML project",
      cmd = function()
        print("No pyproject.toml or Cargo.toml detected.")
      end,
      rtxt = "n",
    })
  end

  require("menu").open(menu_items)
end

return M
