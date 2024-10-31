-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")
vim.cmd.colorscheme("tokyonight-moon")

-- require("config.lualine-cf2")
--
vim.api.nvim_set_keymap("i", "iee", "if err != nil {}", { silent = true, expr = false, noremap = true })
