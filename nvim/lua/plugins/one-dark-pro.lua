return {
	"olimorris/onedarkpro.nvim",
	config = function()
		require("onedarkpro").setup({
			highlights = {
				Comment = { italic = true },
				Directory = { bold = true },
				ErrorMsg = { italic = true, bold = true },
			},
			styles = {
				types = "NONE",
				methods = "NONE",
				numbers = "NONE",
				strings = "NONE",
				comments = "italic",
				keywords = "bold,italic",
				constants = "NONE",
				functions = "italic",
				operators = "NONE",
				variables = "NONE",
				parameters = "NONE",
				conditionals = "italic",
				virtual_text = "NONE",
			},
		})
	end,
}
