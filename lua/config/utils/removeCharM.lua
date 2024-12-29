-- Archivo: limpiararchivo.lua

-- Crear un comando personalizado para eliminar ^M si existen
vim.api.nvim_create_user_command("RemoveCtrlM", function()
  -- Buscar el carácter ^M en el archivo
  local has_ctrl_m = vim.fn.search("\r", "n") > 0
  if has_ctrl_m then
    -- Si encuentra ^M, elimina todas sus ocurrencias
    vim.cmd([[%s/\r//g]])
    vim.notify("^M eliminado", vim.log.levels.INFO)
  else
    -- Si no encuentra ^M, notifica que el archivo está limpio
    vim.notify("Archivo limpio", vim.log.levels.INFO)
  end
end, { desc = "Elimina los caracteres ^M si existen o notifica que el archivo está limpio" })
