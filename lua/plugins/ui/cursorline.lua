return {
  "yamatsum/nvim-cursorline",
  name = "cursorline",
  lazy = false,
  opts = {
    cursorline = {
      enable = true,
      timeout = 1000,
      number = false,
    },
    cursorword = {
      enable = true,
      min_length = 3,
      hl = { underline = true },
    },
  },
  init = function()
    -- Deshabilita nvim-cursorline en el buffer del dashboard
    local function disable_in_dashboard()
      local filetype = vim.bo.filetype
      if filetype == "dashboard" then
        require("nvim-cursorline").setup({
          cursorline = {
            enable = false,
          },
          cursorword = {
            enable = false,
          },
        })
      end
    end

    -- Agrega autocmd para llamar a la función cuando se abra un buffer
    vim.api.nvim_create_autocmd("BufEnter", {
      callback = disable_in_dashboard,
    })
  end,
}
