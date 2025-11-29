return {
	"RedsXDD/neopywal.nvim",
	lazy = false,
	priority = 1000,
	config = function()
		-- Selecciona automáticamente el esquema según el fondo
		vim.cmd.colorscheme("neopywal-dark")
	end,
}
