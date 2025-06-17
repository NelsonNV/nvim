local function imagengaleria()
  local default_path = os.getenv("HOME") .. "/.nvimheader/"
  local config_file = default_path .. "imagelist.txt"
  local max_width = 60
  local max_height = 20
  local min_width = 20
  local min_height = 10

  local function ensure_directory(path)
    local ok = os.execute('mkdir -p "' .. path .. '"')
    return ok
  end

  local function ensure_file(file)
    local f = io.open(file, "r")
    if not f then
      f = io.open(file, "w")
      if f then
        f:close()
      end
    else
      f:close()
    end
  end

  ensure_directory(default_path)
  ensure_file(config_file)

  local function load_image_list(file)
    local list = {}
    local f = io.open(file, "r")
    if f then
      for line in f:lines() do
        if line:match("%.jpe?g$") or line:match("%.png$") or line:match("%.gif$") or line:match("%.webp$") then
          table.insert(list, line)
        end
      end
      f:close()
    end
    return list
  end

  local function get_image_size(filepath)
    local handle = io.popen('identify -format "%w %h" "' .. filepath .. '" 2>/dev/null')
    if handle then
      local output = handle:read("*a")
      handle:close()
      if output and output ~= "" then
        local w, h = output:match("(%d+)%s+(%d+)")
        return tonumber(w), tonumber(h)
      end
    end
    return nil, nil
  end

  local images = load_image_list(config_file)
  if #images == 0 then
    local handle = io.popen('ls "' .. default_path .. '"')
    if handle then
      for file in handle:lines() do
        if file:match("%.jpe?g$") or file:match("%.png$") or file:match("%.gif$") or file:match("%.webp$") then
          table.insert(images, default_path .. file)
        end
      end
      handle:close()
    end
  end

  if #images == 0 then
    return "No se encontraron imágenes en " .. default_path .. " ni en imagelist.txt"
  end

  local time = os.date("*t")
  local index = (time.hour + time.min + time.sec) % #images + 1
  local filepath = images[index]
  local filename = filepath:match("^.+/(.+)$") or filepath

  local preferred_w, preferred_h = filename:match("_(%d+)x(%d+)")
  preferred_w = tonumber(preferred_w)
  preferred_h = tonumber(preferred_h)

  local iw, ih = get_image_size(filepath)
  if not iw or not ih then
    return "No se pudo obtener el tamaño de la imagen: " .. filename
  end

  local width, height
  if preferred_w and preferred_h then
    width = preferred_w
    height = preferred_h
  else
    local scale = math.min(max_width / iw, max_height / ih, 1)
    width = math.max(math.floor(iw * scale), min_width)
    height = math.max(math.floor(ih * scale), min_height)
  end

  return string.format(
    'chafa "%s" --format symbols --symbols vhalf --size %dx%d --stretch; sleep 0.1',
    filepath,
    width,
    height
  )
end

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

        { icon = " ", key = "g", desc = "Buscar Texto", action = ":lua Snacks.dashboard.pick('live_grep')" },
        { icon = " ", key = "r", desc = "Recent Files", action = ":lua Snacks.dashboard.pick('oldfiles')" },
        { icon = "💤", key = "l", desc = "LazyGit", action = ":LazyGit" },
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
        cmd = imagengaleria(),
        height = 17,
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
