return {
	"akinsho/toggleterm.nvim",

	config = function()
		require("toggleterm").setup({
			shade_terminals = true,
			direction = "horizontal",
			size = 20,
			open_mapping = [[<c-t>]],
		})
	end,
}
