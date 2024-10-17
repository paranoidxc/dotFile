-- Eviline config for lualine
-- Author: shadmansaleh
-- Credit: glepnir
local lualine = require("lualine")

-- Color table for highlights
-- stylua: ignore
local colors = {
	bg       = '#202328',
	fg       = '#bbc2cf',
	yellow   = '#ECBE7B',
	cyan     = '#008080',
	darkblue = '#081633',
	green    = '#98be65',
	orange   = '#FF8800',
	violet   = '#a9a1e1',
	magenta  = '#c678dd',
	blue     = '#51afef',
	red      = '#ec5f67',
	blue     = "#80a0ff",
	cyan     = "#79dac8",
	black    = "#080808",
	white    = "#c6c6c6",
	red      = "#ff5189",
	violet   = "#d183e8",
	grey     = "#303030",
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

local bubbles_theme = {
	normal = {
		a = { fg = colors.black, bg = colors.violet },
		b = { fg = colors.white, bg = colors.grey },
		c = { fg = colors.white },
	},

	insert = { a = { fg = colors.black, bg = colors.blue } },
	visual = { a = { fg = colors.black, bg = colors.cyan } },
	replace = { a = { fg = colors.black, bg = colors.red } },

	inactive = {
		a = { fg = colors.white, bg = colors.black },
		b = { fg = colors.white, bg = colors.black },
		c = { fg = colors.white },
	},
}

-- Config
local config = {
	options = {
		-- Disable sections and component separators
		component_separators = "",
		section_separators = "",
		section_separators = { left = "", right = "" },
		theme = bubbles_theme,
		-- theme = {
		-- 	-- We are going to use lualine_c an lualine_x as left and
		-- 	-- right section. Both are highlighted by c theme .  So we
		-- 	-- are just setting default looks o statusline
		-- 	normal = { c = { fg = colors.fg, bg = colors.bg } },
		-- 	inactive = { c = { fg = colors.fg, bg = colors.bg } },
		-- },
	},
	sections = {
		-- these are to remove the defaults
		lualine_a = { { "mode", separator = { left = "" }, right_padding = 2 } },
		-- lualine_b = {},
		lualine_b = { { "filename", color = { gui = "bold" } }, "filetype", "location", "progress" },
		lualine_y = {},
		lualine_z = {
			--separator = { right = "" },
			--left_padding = 0,
		},
		-- lualine_z = {
		-- 	{ "branch", separator = { right = "" }, left_padding = 2 },
		-- },
		-- These will be filled later
		lualine_c = {},
		lualine_x = {},
	},
	inactive_sections = {
		-- these are to remove the defaults
		lualine_a = {},
		lualine_b = {},
		lualine_y = {},
		lualine_z = {},
		lualine_c = {},
		lualine_x = {},
	},
}

-- Inserts a component in lualine_c at left section
local function ins_left(component)
	table.insert(config.sections.lualine_c, component)
end

-- Inserts a component in lualine_x at right section
local function ins_right(component)
	table.insert(config.sections.lualine_x, component)
end

-- ins_left({
-- 	function()
-- 		return "▊"
-- 	end,
-- 	color = { fg = colors.blue },   -- Sets highlighting of component
-- 	color = { fg = colors.black, bg = colors.violet },
-- 	padding = { left = 0, right = 1 }, -- We don't need space before this
-- })

ins_left({
	-- mode component
	function()
		return ""
	end,
	color = function()
		-- auto change color according to neovims mode
		local mode_color = {
			n = colors.red,
			i = colors.green,
			v = colors.blue,
			[""] = colors.blue,
			V = colors.blue,
			c = colors.magenta,
			no = colors.red,
			s = colors.orange,
			S = colors.orange,
			[""] = colors.orange,
			ic = colors.yellow,
			R = colors.violet,
			Rv = colors.violet,
			cv = colors.red,
			ce = colors.red,
			r = colors.cyan,
			rm = colors.cyan,
			["r?"] = colors.cyan,
			["!"] = colors.red,
			t = colors.red,
		}
		return { fg = mode_color[vim.fn.mode()] }
	end,
	padding = { left = 1, right = 1 },
})

-- ins_left({
-- 	-- filesize component
-- 	"filesize",
-- 	cond = conditions.buffer_not_empty,
-- 	color = { fg = colors.black, bg = colors.violet },
-- })

-- ins_left({
-- 	"filename",
-- 	cond = conditions.buffer_not_empty,
-- 	color = { fg = colors.magenta, gui = "bold" },
-- })

-- ins_left({ "location" })
-- ins_left({ "progress", color = { fg = colors.fg, gui = "bold" } })

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
	color = { fg = colors.orange, gui = "bold" },
})

ins_left({
	"diagnostics",
	sources = { "nvim_diagnostic" },
	symbols = { error = " ", warn = " ", info = " " },
	diagnostics_color = {
		error = { fg = colors.red },
		warn = { fg = colors.yellow },
		info = { fg = colors.cyan },
	},
})

ins_right({
	function()
		return ""
	end,
	color = { fg = colors.green, bg = colors.grey },
	padding = { left = 0 },
})

ins_right({
	"filename",
	file_status = true,
	path = 4,
	icons_enabled = true,
	color = { bg = colors.green, gui = "bold", fg = colors.grey },
	inactive = { bg = colors.grey, gui = "bold", fg = colors.green },
})
-- Insert mid section. You can make any number of sections in neovim :)
-- for lualine it's any number greater then 2
-- ins_left({
-- 	function()
-- 		return "%=sep"
-- 	end,
-- })

-- Add components to right sections
ins_right({
	"o:encoding", -- option component same as &encoding in viml
	fmt = string.upper, -- I'm not sure why it's upper case either ;)
	-- cond = conditions.hide_in_width,
	--color = { fg = colors.green, gui = "bold", bg = colors.grey },
	color = { bg = colors.green, gui = "bold", fg = colors.grey },
})

ins_right({
	"fileformat",
	fmt = string.upper,
	-- icons_enabled = true, -- I think icons are cool but Eviline doesn't have them. sigh
	--color = { fg = colors.green, gui = "bold", bg = colors.grey },
	color = { bg = colors.green, gui = "bold", fg = colors.grey },
	padding = { left = 0, right = 1 },
})

ins_right({
	"branch",
	icon = "",
	--color = { fg = colors.green, bg = colors.grey, gui = "bold" },
	color = { bg = colors.green, gui = "bold", fg = colors.grey },
	padding = { left = 1, right = 1 },
})

ins_right({
	"diff",
	-- Is it me or the symbol for modified us really weird
	symbols = { added = " ", modified = "󰝤 ", removed = " " },
	diff_color = {
		added = { fg = colors.magenta, bg = colors.darkblue },
		modified = { fg = colors.orange, bg = colors.darkblue },
		removed = { fg = colors.red, bg = colors.darkblue },
	},
	cond = conditions.hide_in_width,
})

ins_right({
	function()
		return ""
	end,
	-- color = { fg = colors.blue, bg = colors.grey },
	color = { fg = colors.green, gui = "bold", bg = colors.grey },
	padding = { left = 0, right = 0 },
})

-- Now don't forget to initialize lualine
lualine.setup(config)
