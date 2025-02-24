local base_menu = require("config.menu.base")

local M = {}

local function fetch_gitignore()
  -- Solicitar al usuario el tipo de proyecto
  local project_type = vim.fn.input("Enter project type for .gitignore: ")

  -- Reemplazar espacios con comas y espacios antes de 'l' con '+'
  project_type = project_type:gsub(", ", ","):gsub(" ", "+")

  -- URL de la API para obtener el archivo .gitignore
  local url = "https://www.toptal.com/developers/gitignore/api/" .. project_type

  -- Realizar la petición GET usando curl
  local handle = io.popen("curl -s " .. url)
  local gitignore_content = handle:read("*a")
  handle:close()

  -- Verificar si se obtuvo contenido
  if gitignore_content and #gitignore_content > 0 then
    -- Insertar el contenido en el archivo actual
    local current_buf = vim.api.nvim_get_current_buf()
    vim.api.nvim_buf_set_lines(current_buf, 0, -1, false, vim.split(gitignore_content, "\n"))

    print(".gitignore content inserted for " .. project_type)
  else
    print("Failed to fetch .gitignore")
  end
end
function M.open_menu()
  -- Copia las opciones comunes del módulo base
  local menu_items = vim.deepcopy(base_menu.common_options)

  -- Agrega las opciones específicas de Git
  table.insert(menu_items, {
    name = "  Fetch .gitignore",
    cmd = fetch_gitignore,
    rtxt = "g",
  })

  -- Abrir el menú con las opciones
  require("menu").open(menu_items)
end

return M
