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

    -- Usar el portapapeles de Neovim (registro `+` para el portapapeles del sistema)
    vim.fn.setreg("+", joined_content)

    print("Contenido Copiado")
  else
    print("Error: No se pudo leer el archivo")
  end
end

-- Registrar el comando en Neovim
vim.api.nvim_create_user_command("CopyFileToClipboard", copy_file_to_clipboard, {})
