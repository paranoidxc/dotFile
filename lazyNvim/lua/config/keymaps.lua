local keymap = vim.keymap
local opts = { noremap = true, silent = true }

keymap.set("n", "x", '"_x')

-- Increment/decrement
keymap.set("n", "+", "<C-a>")
keymap.set("n", "-", "<C-x>")

keymap.set("n", "<C-p>", ":BufferLinePick<Return>", opts)

-- Select all
keymap.set("n", "<C-a>", "gg<S-v>G")

-- Save file and quit
keymap.set("n", "<Leader>w", ":update<Return>", opts)
keymap.set("n", "<Leader>q", ":quit<Return>", opts)
keymap.set("n", "<Leader>Q", ":qa<Return>", opts)

-- File explorer with NvimTree
keymap.set("n", "<Leader>f", ":NvimTreeFindFile<Return>", opts)
keymap.set("n", "<Leader>t", ":NvimTreeToggle<Return>", opts)
keymap.set("n", "<Leader>n", ":Neotree focus<Return>", opts)

-- float terminal
keymap.set("n", "<Leader>tl", ":Telescope floaterm<Return>", opts)
keymap.set("n", "<Leader>tf", ":FloatermNew --height=0.8 --width=0.8<Return>", opts)
keymap.set("n", "<Leader>tt", ":FloatermToggle<Return>", opts)

-- Tabs
keymap.set("n", "te", ":tabedit")
keymap.set("n", "<tab>", ":tabnext<Return>", opts)
keymap.set("n", "<s-tab>", ":tabprev<Return>", opts)
keymap.set("n", "tw", ":tabclose<Return>", opts)

-- Split window
keymap.set("n", "ss", ":split<Return>", opts)
keymap.set("n", "sv", ":vsplit<Return>", opts)

-- Move window
keymap.set("n", "sh", "<C-w>h")
keymap.set("n", "sk", "<C-w>k")
keymap.set("n", "sj", "<C-w>j")
keymap.set("n", "sl", "<C-w>l")

-- Resize window
keymap.set("n", "<C-S-h>", "<C-w><")
keymap.set("n", "<C-S-l>", "<C-w>>")
keymap.set("n", "<C-S-k>", "<C-w>+")
keymap.set("n", "<C-S-j>", "<C-w>-")

vim.keymap.set("n", "<C-n>", ":Neotree filesystem reveal left toggle<CR>")
vim.keymap.set("n", "<leader>n", ":Neotree focus<CR>")

vim.keymap.set("n", "<leader>ff", ":Telescope find_files<CR>", {})
vim.keymap.set("n", "<leader>fw", ":Telescope live_grep<CR>", {})
vim.keymap.set("n", "<leader>fh", ":Telescope help_tags<CR>", {})
vim.keymap.set("n", "<leader>th", ":Telescope colorscheme<CR>", {})
vim.keymap.set("n", "<leader>of", ":Telescope oldfiles<CR>", {})
vim.keymap.set("n", "<leader>km", ":Telescope keymaps<CR>", {})
vim.keymap.set("n", "<leader>ls", ":Telescope lsp_document_symbols<CR>")
-- vim.keymap.set("n", "<leader>lm", ":Telescope lsp_document_symbol({symbols = { 'Method' }})<CR>")
vim.keymap.set(
  "n",
  "<leader>lm",
  ":lua require('telescope.builtin').lsp_document_symbols({symbols = { 'Method' }})<CR>"
)
vim.keymap.set("n", "<leader>lr", ":Telescope lsp_references<CR>")
vim.keymap.set("n", "<leader>ld", ":Telescope lsp_definitions<CR>")
vim.keymap.set("n", "<leader>bw", ":Telescope current_buffer_fuzzy_find<CR>")
vim.keymap.set("n", "<leader>bl", ":Telescope buffers<CR>")
vim.keymap.set("n", "<leader>df", ":lua require 'telescope'.extensions.file_browser.file_browser()<CR>")
vim.keymap.set("n", "<leader>ft", vim.lsp.buf.format, {})
vim.keymap.set("n", "<C-p>", ":BufferLinePick<CR>")
vim.keymap.set("n", "<leader>x", ":bd<CR>")
vim.keymap.set("n", "<leader>/", "gcc", { remap = true })

-- rename
--mapbuf("n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", opt)
vim.keymap.set("n", "<leader>rn", ":lua vim.lsp.buf.rename()<CR>")

-- code action
--mapbuf("n", "<space>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", opt)
vim.keymap.set("n", "<leader>ca", ":lua vim.lsp.buf.code_action()<CR>")

-- go xx
vim.keymap.set("n", "gD", ":lua vim.lsp.buf.type_definition()<CR>")
-- mapbuf("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opt)
vim.keymap.set("n", "gd", ":lua vim.lsp.buf.definition()<CR>")

-- mapbuf("n", "gh", "<cmd>lua vim.lsp.buf.hover()<CR>", opt)
vim.keymap.set("n", "gh", ":lua vim.lsp.buf.hover()<CR>")

-- mapbuf("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opt)
vim.keymap.set("n", "gD", ":lua vim.lsp.buf.declaration()<CR>")

-- mapbuf("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opt)
vim.keymap.set("n", "gi", ":lua vim.lsp.buf.implementation()<CR>")

-- mapbuf("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opt)
vim.keymap.set("n", "gr", ":lua vim.lsp.buf.references()<CR>")

-- diagnostic
-- mapbuf("n", "go", "<cmd>lua vim.diagnostic.open_float()<CR>", opt)
vim.keymap.set("n", "go", ":lua vim.diagnostic.open_float()<CR>")
-- mapbuf("n", "gp", "<cmd>lua vim.diagnostic.goto_prev()<CR>", opt)
vim.keymap.set("n", "gp", ":lua vim.diagnostic.goto_prev()<CR>")
-- mapbuf("n", "gn", "<cmd>lua vim.diagnostic.goto_next()<CR>", opt)
vim.keymap.set("n", "gn", ":lua vim.diagnostic.goto_next()<CR>")
-- mapbuf('n', '<leader>q', '<cmd>lua vim.diagnostic.setloclist()<CR>', opt)

-- Diagnostics
keymap.set("n", "<C-j>", function()
  vim.diagnostic.goto_next()
end, opts)
