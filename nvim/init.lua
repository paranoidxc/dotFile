vim.g.mapleader = " "
require("preferences")

vim.cmd("colorscheme retrobox")

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		vim.api.nvim_echo({
			{ "Failed to clone lazy.nvim:\n", "ErrorMsg" },
			{ out,                            "WarningMsg" },
			{ "\nPress any key to exit..." },
		}, true, {})
		vim.fn.getchar()
		os.exit(1)
	end
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
	spec = {
		{ import = "plugins" },
	},

	install = {
		colorscheme = { "tokyonight-night" },
	},

	ui = {
		border = "single",
	},
})

require("keymaps")

require("nvim-window").setup({
	hint_hl = "Bold",
	border = "single",
	render = "float",
})

-- vim.cmd.colorscheme("monokai-pro")
-- vim.cmd.colorscheme("dracula")
vim.cmd.colorscheme("tokyonight-moon")

vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("lsp", { clear = true }),
	callback = function(args)
		-- 2
		vim.api.nvim_create_autocmd("BufWritePre", {
			pattern = { "*.go" },
			callback = function()
				local params = vim.lsp.util.make_range_params(nil, "utf-16")
				params.context = { only = { "source.organizeImports" } }
				local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params, 3000)
				for _, res in pairs(result or {}) do
					for _, r in pairs(res.result or {}) do
						if r.edit then
							vim.lsp.util.apply_workspace_edit(r.edit, "utf-16")
						else
							vim.lsp.buf.execute_command(r.command)
						end
					end
				end
			end,
		})
		vim.api.nvim_create_autocmd("BufWritePre", {
			-- 3
			buffer = args.buf,
			callback = function()
				-- 4 + 5
				-- vim.api.nvim_command("%! goimports")
				vim.lsp.buf.format({ async = false, id = args.data.client_id })
			end,
		})
	end,
})

-- place this in one of your configuration file(s)
local hop = require("hop")
local directions = require("hop.hint").HintDirection
vim.keymap.set("", "f", function()
	hop.hint_char1({ direction = directions.AFTER_CURSOR, current_line_only = true })
end, { remap = true })
vim.keymap.set("", "F", function()
	hop.hint_char1({ direction = directions.BEFORE_CURSOR, current_line_only = true })
end, { remap = true })
vim.keymap.set("", "t", function()
	hop.hint_char1({ direction = directions.AFTER_CURSOR, current_line_only = true, hint_offset = -1 })
end, { remap = true })
vim.keymap.set("", "T", function()
	hop.hint_char1({ direction = directions.BEFORE_CURSOR, current_line_only = true, hint_offset = 1 })
end, { remap = true })

vim.api.nvim_set_keymap("i", "ss", "$$", { silent = true, expr = false, noremap = true })
vim.api.nvim_set_keymap("i", "iee", "if err != nil {}", { silent = true, expr = false, noremap = true })

if vim.g.neovide then
	-- vim.o.guifont = "DejaVuSansMono Nerd Font:h18" -- text below applies for VimScript
	vim.o.guifont = "JetBrainsMono Nerd Font:h18" -- text below applies for VimScript
end

require("debugging")
--require("lualine-cf")
