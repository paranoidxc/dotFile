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
		lualine_a = { { "mode", separator = { left = "" }, right_padding = 2 } },
		-- lualine_b = {},
		lualine_b = { { "filename", color = { gui = "bold" } }, "filetype", "location", "progress" },
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
	padding = { left = 1, right = 1 },
})

ins_right({
	"o:encoding", -- option component same as &encoding in viml
	fmt = string.upper, -- I'm not sure why it's upper case either ;)
	color = { bg = colors.green, gui = "bold", fg = colors.gray },
})

ins_right({
	"fileformat",
	fmt = string.upper,
	color = { bg = colors.green, gui = "bold", fg = colors.gray },
	padding = { left = 0, right = 1 },
})

require("lualine").setup(config)
