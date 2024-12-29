-- Archivo: copyfile.lua

-- Función para copiar el contenido del archivo actual al portapapeles
local function copy_file_to_clipboard()
  -- Obtener el nombre del archivo actual
  local filename = vim.fn.expand("%:p")

  -- Verificar si el archivo existe
  if vim.fn.filereadable(filename) == 1 then
    -- Leer el contenido del archivo
    local content = vim.fn.readfile(filename)

    -- Convertir el contenido en una sola cadena
    local joined_content = table.concat(content, "\n")

    -- Enviar el contenido al portapapeles usando xclip
    local handle = io.popen("xclip -selection clipboard", "w")
    if handle then
      handle:write(joined_content)
      handle:close()
      print("Contenido copiado al portapapeles")
    else
      print("Error: No se pudo abrir xclip")
    end
  else
    print("Error: No se pudo leer el archivo")
  end
end

-- Registrar el comando en Neovim
vim.api.nvim_create_user_command("CopyFileToClipboard", copy_file_to_clipboard, {})
