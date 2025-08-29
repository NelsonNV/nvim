local function imagengaleria()
  local default_path = os.getenv("HOME") .. "/.nvimheader/"

  -- Asegura que el directorio existe
  local function ensure_directory(path)
    os.execute('mkdir -p "' .. path .. '"')
  end

  ensure_directory(default_path)

  -- Carga todos los archivos .txt del directorio
  local function load_ascii_list()
    local list = {}
    local handle = io.popen('ls "' .. default_path .. '"')
    if handle then
      for file in handle:lines() do
        if file:match("%.txt$") then
          table.insert(list, default_path .. file)
        end
      end
      handle:close()
    end
    return list
  end

  local files = load_ascii_list()
  if #files == 0 then
    return "echo 'No se encontraron archivos .txt con ASCII en " .. default_path .. "'", 10
  end

  -- Selecciona uno basado en la hora actual (para variedad)
  local time = os.date("*t")
  local index = (time.hour + time.min + time.sec) % #files + 1
  local filepath = files[index]

  -- Calcula la altura del archivo para el dashboard
  local height = 20
  local f = io.open(filepath, "r")
  if f then
    height = 0
    for _ in f:lines() do
      height = height + 1
    end
    f:close()
  end

  return string.format('cat "%s"', filepath), height
end

local imagen_cmd, imagen_height = imagengaleria()
return {
  dashboard = {
    enabled = true,
    preset = {
      header = [[
            ⣿⣿⣿⣿⣿⣿⣿⣿⡟⠀⠀⡄⠀⠀⠀⠀⢀⡀⠀⠀⠀⠀⠢⠀⡇⠀⢸⣿⣽⣾⣿⣿
            ⣿⣿⣿⣿⣿⣿⣿⡟⠀⠀⠀⡀⠐⠈⠁⠀⠀⠀⠀⠈⠈⠢⣀⠀⣇⠀⠀⢿⠀⢘⣼⣿
            ⣿⣿⣿⣿⣿⣿⣻⠀⠀⠀⠈⢀⣀⠤⠤⠴⠶⠶⠶⢰⣤⡄⣀⠈⣾⠀⡈⠩⡀⠘⣽⣿
            ⣿⣿⣿⣿⣿⣿⠇⠀⠀⠀⠀⠀⠀⠀⠀⡄⠀⠐⠀⠀⠀⠀⠉⠚⠌⡆⠒⠀⠐⣰⣷⣿
            ⣿⣿⣿⣿⣿⣷⠀⠀⠀⠀⠀⢀⣇⣤⡤⣳⢤⣤⣤⠤⣀⣄⠀⠀⠀⠛⡴⠰⣀⣿⣿⣿
            ⣿⣿⣿⣿⣿⣽⠀⠀⠀⠄⠀⣡⠞⠽⢦⣿⣿⣿⣿⣏⡴⣲⣍⠆⠀⢸⢀⠘⠀⢿⣿⣿
            ⣿⣿⣿⣿⣿⡏⢀⠀⠀⠀⠀⣿⡖⣶⣸⣿⣿⡿⣿⣿⢼⣠⢸⠃⠀⡼⢸⠀⣕⠊⢿⣿
            ⣿⣿⣿⣿⣿⣷⠀⠀⠀⠀⠀⢹⣿⣽⣿⣿⣿⢻⣿⣿⣿⣷⣿⠀⠀⢹⠞⠀⣿⣗⢼⣸
            ⣿⣿⣿⣿⣿⣼⡆⠈⠀⠀⣦⢳⣿⣿⡟⠾⠭⠭⠽⣿⣿⡿⡕⣠⠀⠀⠀⠀⢻⣿⡷⣿
            ⣿⣿⣿⣿⣿⣿⢡⠀⠀⠀⣿⣿⣿⣿⡠⣛⣋⣛⠦⠘⣿⣿⣿⡏⠀⠀⠐⠀⠻⣿⣿⣿
            ⣿⣿⣿⣿⣿⣿⣸⠀⡂⠀⣀⣿⣿⣷⢿⣿⣿⣿⣿⢇⣿⣿⡿⠁⠀⠐⠀⢳⣗⣿⣿⣿
            ⣿⣿⣿⣿⣿⣿⣿⣦⣁⠀⣯⣿⣿⡿⣿⣶⣷⣮⣶⣿⣿⣿⣾⠀⠀⠆⣠⣯⣾⣿⣿⣻
            ⣿⣿⣿⣿⣿⣿⣿⣿⣛⣿⣻⠿⣿⣿⣷⣭⣻⣛⣵⢷⣿⣿⡿⢀⢴⣽⠿⡽⣿⣿⣿⢻
            ⣿⣿⣿⣿⣿⠟⠀⠀⠀⠈⠳⣄⠂⠈⠻⣿⣿⣿⣿⠙⢿⢻⣿⣿⣵⠀⠀⠀⠀⣿⠟⢿
            ⣿⣿⣿⡻⠁⠀⠀⠀⠈⠀⠀⠀⠙⢤⠀⠈⢿⣿⡟⠈⡏⠀⠉⠚⠁⠀⠀⠀⠀⠈⣶⣿
            ⣿⣿⠋⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠙⢤⠀⠙⠀⢠⠀⠀⠀⠀⠀⠀⠀⠀⠀⢠⣾⣿
            ⡿⡉⠁⠀⠂⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠙⣄⠀⡟⠀⠀⠀⠀⠀⠀⠀⠀⠀⠫⣿⣿
          ]],

      keys = {
        { icon = " ", key = "f", desc = "Buscar Archivo", action = ":lua Snacks.dashboard.pick('files')" },

        {
          icon = " ",
          key = "n",
          desc = "Nuevo Archivo",
          action = function()
            -- Comando para obtener archivos válidos (ignora ocultos/carpetas comunes)
            local cmd = "fd . --type f --hidden --exclude .git --exclude node_modules --exclude .cache 2>/dev/null"
            local handle = io.popen(cmd) or io.popen('find . -type f -not -path "*/\\.*" 2>/dev/null')
            if not handle then
              vim.cmd("ene | startinsert") -- fallback simple
              return
            end

            local files = handle:read("*a")
            handle:close()

            -- Extraer extensiones únicas
            local ext_set = {}
            for file in files:gmatch("[^\r\n]+") do
              local ext = file:match("^.+%.([a-zA-Z0-9]+)$")
              if ext and #ext <= 5 then
                ext_set[ext] = true
              end
            end

            local extensions = vim.tbl_keys(ext_set)
            table.sort(extensions)

            -- Añadir opción vacía (sin extensión) al principio
            table.insert(extensions, 1, "") -- archivo sin extensión

            -- Mostrar menú
            vim.ui.select(extensions, { prompt = "Elige una extensión (Enter para sin extensión):" }, function(choice)
              if choice == nil then
                return
              end

              local filename = "nuevo_archivo"
              if choice ~= "" then
                filename = filename .. "." .. choice
              end

              vim.cmd("edit " .. filename)
              vim.cmd("startinsert")
            end)
          end,
        },

        { icon = " ", key = "f", desc = "Buscar Texto", action = ":lua Snacks.dashboard.pick('live_grep')" },
        { icon = " ", key = "r", desc = "Recent Files", action = ":lua Snacks.dashboard.pick('oldfiles')" },
        { icon = " ", key = "g", desc = "LazyGit", action = ":LazyGit" },
        { icon = "💤", key = "l", desc = "Lazy", action = ":Lazy" },
        {
          icon = " ",
          key = "c",
          desc = "Config",
          action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})",
        },
        { icon = " ", key = "q", desc = "Quit", action = ":qa" },
      },
    },
    sections = {
      {
        section = "terminal",
        cmd = imagen_cmd,
        height = imagen_height or 20,
        padding = 1,
      },
      {
        title = "Info Personal",
        icon = " ",
        padding = 1,
        text = {
          {
            "[ " .. (vim.fn.system("git config --get user.name"):gsub("\n", "") or "No configurado") .. "]",
            hl = "SnacksDashboardDesc",
          },
          { "[ " .. (vim.fn.system("whoami"):gsub("\n", "") or "unknown") .. "]", hl = "SnacksDashboardDesc" },
          { "[󰖟 navarrolabs.cl]", hl = "SnacksDashboardDesc" },
        },
      },
      { pane = 2, { section = "keys", gap = 1, padding = 1 }, { section = "startup" } },
    },
  },
}
