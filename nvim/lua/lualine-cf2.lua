local old_colors = {
	bg = "#202328",
	fg = "#bbc2cf",
	yellow = "#ECBE7B",
	cyan = "#008080",
	darkblue = "#081633",
	green = "#98be65",
	orange = "#FF8800",
	violet = "#a9a1e1",
	magenta = "#c678dd",
	blue = "#51afef",
	red = "#ec5f67",
	blue = "#80a0ff",
	cyan = "#79dac8",
	black = "#080808",
	white = "#c6c6c6",
	red = "#ff5189",
	violet = "#d183e8",
	grey = "#303030",
}

local colors = {
	black = "#282828",
	white = "#ebdbb2",
	red = "#fb4934",
	green = "#b8bb26",
	blue = "#83a598",
	yellow = "#fe8019",
	gray = "#a89984",
	darkgray = "#3c3836",
	lightgray = "#504945",
	inactivegray = "#7c6f64",
}

local conditions = {
	buffer_not_empty = function()
		return vim.fn.empty(vim.fn.expand("%:t")) ~= 1
	end,
	hide_in_width = function()
		return vim.fn.winwidth(0) > 80
	end,
	check_git_workspace = function()
		local filepath = vim.fn.expand("%:p:h")
		local gitdir = vim.fn.finddir(".git", filepath .. ";")
		return gitdir and #gitdir > 0 and #gitdir < #filepath
	end,
}

local bubbles_themes = {
	normal = {
		a = { bg = colors.gray, fg = colors.black, gui = "bold" },
		b = { bg = colors.lightgray, fg = colors.white },
		c = { bg = colors.darkgray, fg = colors.gray },
	},
	insert = {
		a = { bg = colors.blue, fg = colors.black, gui = "bold" },
		b = { bg = colors.lightgray, fg = colors.white },
		c = { bg = colors.lightgray, fg = colors.white },
	},
	visual = {
		a = { bg = colors.yellow, fg = colors.black, gui = "bold" },
		b = { bg = colors.lightgray, fg = colors.white },
		c = { bg = colors.inactivegray, fg = colors.black },
	},
	replace = {
		a = { bg = colors.red, fg = colors.black, gui = "bold" },
		b = { bg = colors.lightgray, fg = colors.white },
		c = { bg = colors.black, fg = colors.white },
	},
	command = {
		a = { bg = colors.green, fg = colors.black, gui = "bold" },
		b = { bg = colors.lightgray, fg = colors.white },
		c = { bg = colors.inactivegray, fg = colors.black },
	},
	inactive = {
		a = { bg = colors.darkgray, fg = colors.gray, gui = "bold" },
		b = { bg = colors.darkgray, fg = colors.gray },
		c = { bg = colors.darkgray, fg = colors.gray },
	},
}

local config = {
	options = {
		component_separators = "",
		section_separators = { left = "", right = "" },
		theme = bubbles_themes,
	},
	sections = {
		-- these are to remove the defaults
		lualine_a = {
			{
				"mode",
				separator = { left = "" },
				right_padding = 2,
				color = { fg = old_colors.black, bg = old_colors.violet },
			},
		},
		-- lualine_b = { { "filename", color = { gui = "bold" } }, "filetype", "location", "progress" },
		lualine_b = {
			"filetype",
			"location",
			"progress",
		},
		lualine_y = {},
		lualine_z = {},
		lualine_c = {},
		lualine_x = {},
	},
}

local function ins_left(component)
	table.insert(config.sections.lualine_c, component)
end

-- Inserts a component in lualine_x at right section
local function ins_right(component)
	table.insert(config.sections.lualine_x, component)
end

ins_left({
	-- mode component
	function()
		return ""
	end,
	color = function()
		local mode_color = {
			n = old_colors.red,
			i = old_colors.green,
			v = old_colors.blue,
			-- [""] = old_colors.blue,
			V = old_colors.blue,
			c = old_colors.magenta,
			no = old_colors.red,
			s = old_colors.orange,
			S = old_colors.orange,
			[""] = old_colors.orange,
			ic = old_colors.yellow,
			R = old_colors.violet,
			Rv = old_colors.violet,
			cv = old_colors.red,
			ce = old_colors.red,
			r = old_colors.cyan,
			rm = old_colors.cyan,
			["r?"] = old_colors.cyan,
			["!"] = old_colors.red,
			t = old_colors.red,
		}
		return { fg = mode_color[vim.fn.mode()] }
	end,
	padding = { left = 1, right = 1 },
})

ins_left({
	-- Lsp server name .
	function()
		local msg = "No Active Lsp"
		local buf_ft = vim.api.nvim_buf_get_option(0, "filetype")
		local clients = vim.lsp.get_active_clients()
		if next(clients) == nil then
			return msg
		end
		for _, client in ipairs(clients) do
			local filetypes = client.config.filetypes
			if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
				return client.name
				-- return ""
			end
		end
		return msg
	end,
	icon = "  LSP:",
	color = { fg = old_colors.orange, gui = "bold" },
})

ins_left({
	"diagnostics",
	sources = { "nvim_diagnostic" },
	symbols = { error = " ", warn = " ", info = " " },
	diagnostics_color = {
		error = { fg = old_colors.red },
		warn = { fg = old_colors.yellow },
		info = { fg = old_colors.cyan },
	},
})

ins_right({
	function()
		return ""
	end,

	color = function()
		local mode_color = {
			n = colors.darkgray,
			i = colors.lightgray,
			v = colors.inactivegray,
			V = colors.inactivegray,
			Rv = colors.inactivegray,
			cv = colors.inactivegray,
		}
		return { fg = old_colors.green, bg = mode_color[vim.fn.mode()] }
	end,
	-- color = { fg = old_colors.green, bg = colors.darkgray },
	padding = { left = 0 },
})

ins_right({
	"o:encoding", -- option component same as &encoding in viml
	fmt = string.upper, -- I'm not sure why it's upper case either ;)
	color = { bg = old_colors.green, gui = "bold", fg = old_colors.grey },
})

ins_right({
	"fileformat",
	fmt = string.upper,
	color = { bg = old_colors.green, gui = "bold", fg = old_colors.grey },
	padding = { left = 0, right = 1 },
})

ins_right({
	"branch",
	icon = "",
	--color = { fg = colors.green, bg = colors.grey, gui = "bold" },
	color = { bg = old_colors.green, gui = "bold", fg = old_colors.grey },
	padding = { left = 1, right = 1 },
})

ins_right({
	"diff",
	-- Is it me or the symbol for modified us really weird
	symbols = { added = " ", modified = "󰝤 ", removed = " " },
	diff_color = {
		added = { fg = old_colors.magenta, bg = old_colors.darkblue },
		modified = { fg = old_colors.orange, bg = old_colors.darkblue },
		removed = { fg = old_colors.red, bg = old_colors.darkblue },
	},
	cond = conditions.hide_in_width,
})
ins_right({
	function()
		return ""
	end,
	-- color = { fg = colors.blue, bg = colors.grey },
	color = { fg = old_colors.green, gui = "bold", bg = old_colors.grey },
	padding = { left = 0, right = 0 },
})

require("lualine").setup(config)
