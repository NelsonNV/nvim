return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        intelephense = {
          settings = {
            intelephense = {
              environment = {
                includePaths = { "vendor" }, -- Ruta al directorio vendor
              },
              -- Opcional: Deshabilita advertencias si usas Eloquent sin Laravel
              diagnostics = {
                undefinedTypes = false,
              },
            },
          },
        },
      },
    },
  },
}
