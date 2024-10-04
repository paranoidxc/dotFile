return {
	"rcarriga/nvim-notify",

	config = function()
		local notify = require("notify")

		vim.notify = notify

		notify("Welcome Hunter! Let's Fucking The Whole World!!!")
	end,
}
