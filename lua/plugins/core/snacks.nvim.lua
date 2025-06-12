function imagengaleria()
  local path = os.getenv("HOME") .. "/Imágenes/"
  local max_width = 60
  local max_height = 20
  local min_width = 20
  local min_height = 10

  -- Obtener dimensiones con ImageMagick
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

  -- Listar imágenes
  local handle = io.popen('ls "' .. path .. '"')
  local images = {}

  if handle then
    for file in handle:lines() do
      if file:match("%.jpe?g$") or file:match("%.png$") or file:match("%.gif$") then
        table.insert(images, path .. file)
      end
    end
    handle:close()
  else
    return "Error: no se pudo listar el directorio."
  end

  -- Seleccionar imagen
  if #images == 0 then
    return "No se encontró ninguna imagen."
  end

  -- Usar la hora actual para elegir imagen (puedes cambiar esto a math.random)
  local time = os.date("*t") -- tabla con hora actual
  local index = (time.hour + time.min + time.sec) % #images + 1
  local filepath = images[index]

  -- Obtener dimensiones y ajustar tamaño
  local iw, ih = get_image_size(filepath)
  if not iw or not ih then
    return "No se pudo obtener el tamaño de la imagen."
  end

  local scale_w = max_width / iw
  local scale_h = max_height / ih
  local scale = math.min(scale_w, scale_h, 1)

  local width = math.floor(iw * scale)
  local height = math.floor(ih * scale)

  if width < min_width then
    width = min_width
  end
  if height < min_height then
    height = min_height
  end

  -- Crear comando final
  local command = string.format(
    'chafa "%s" --format symbols --symbols vhalf --size %dx%d --stretch; sleep 0.1',
    filepath,
    width,
    height
  )

  return command
end

return {
  "folke/snacks.nvim",
  opts = {
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

          { icon = " ", key = "n", desc = "New File", action = ":ene | startinsert" },

          { icon = " ", key = "g", desc = "Buscar Texto", action = ":lua Snacks.dashboard.pick('live_grep')" },

          { icon = " ", key = "r", desc = "Recent Files", action = ":lua Snacks.dashboard.pick('oldfiles')" },

          {
            icon = " ",
            key = "c",
            desc = "Config",
            action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})",
          },

          -- { icon = " ", key = "s", desc = "Restore Session", section = "session" },

          -- { icon = "󰒲 ", key = "L", desc = "Lazy", action = ":Lazy", enabled = package.loaded.lazy ~= nil },

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
    picker = {
      sources = {
        explorer = {
          layout = { layout = { position = "right" } },
        },
      },
    },
  },
}
