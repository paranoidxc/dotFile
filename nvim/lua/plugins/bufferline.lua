return {
	"akinsho/bufferline.nvim",
	dependencies = {
		"nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
	},
	config = function()
		require("bufferline").setup({
			options = {
				themable = true,
				separator_style = "slant",
				diagnostics_indicator = function(count, level, diagnostics_dict, context)
					local icon = level:match("error") and " " or " "
					return " " .. icon .. count
				end,
			},
		})
	end,
}
