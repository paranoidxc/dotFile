local keymap = vim.keymap
local opts = { noremap = true, silent = true }

keymap.set("n", "x", '"_x')

-- Increment/decrement
keymap.set("n", "+", "<C-a>")
keymap.set("n", "-", "<C-x>")

keymap.set("n", "<C-p>", ":BufferLinePick<CR>", opts)
keymap.set("n", "<leader>x", ":bd<CR>", opts)
-- keymap.set("n", "<leader>/", "gcc", { remap = true })

-- Select all
keymap.set("n", "<C-a>", "gg<S-v>G")

-- Save file and quit
-- keymap.set("n", "<Leader>w", ":update<Return>", opts)
-- keymap.set("n", "<Leader>q", ":quit<Return>", opts)
-- keymap.set("n", "<Leader>Q", ":qa<Return>", opts)

-- File explorer with NvimTree
-- keymap.set("n", "<Leader>f", ":NvimTreeFindFile<Return>", opts)
-- keymap.set("n", "<Leader>t", ":NvimTreeToggle<Return>", opts)
-- keymap.set("n", "<Leader>n", ":Neotree focus<Return>", opts)

-- float terminal
keymap.set("n", "<Leader>tl", ":Telescope floaterm<Return>", opts)
keymap.set("n", "<Leader>tf", ":FloatermNew --height=0.8 --width=0.8<Return>", opts)
keymap.set("n", "<Leader>tt", ":FloatermToggle<Return>", opts)

-- Tabs
-- keymap.set("n", "te", ":tabedit")
-- keymap.set("n", "<tab>", ":tabnext<Return>", opts)
-- keymap.set("n", "<s-tab>", ":tabprev<Return>", opts)
-- keymap.set("n", "tw", ":tabclose<Return>", opts)

-- Split window
keymap.set("n", "ss", ":split<Return>", opts)
keymap.set("n", "sv", ":vsplit<Return>", opts)

-- Move window
keymap.set("n", "sh", "<C-w>h")
keymap.set("n", "sk", "<C-w>k")
keymap.set("n", "sj", "<C-w>j")
keymap.set("n", "sl", "<C-w>l")

-- Resize window
-- keymap.set("n", "<C-S-h>", "<C-w><")
-- keymap.set("n", "<C-S-l>", "<C-w>>")
-- keymap.set("n", "<leader>w<", "<C-w>10<")
-- keymap.set("n", "<leader>w>", "<C-w>10>")
-- keymap.set("n", "<C-S-k>", "<C-w>+")
-- keymap.set("n", "<C-S-j>", "<C-w>-")

keymap.set("n", "<C-n>", ":Neotree filesystem reveal left toggle<CR>", opts)
keymap.set("n", "<leader>n", ":Neotree focus<CR>", opts)

keymap.set("n", "<leader>ff", ":Telescope find_files<CR>", opts)
keymap.set("n", "<leader>fw", ":Telescope live_grep<CR>", opts)
keymap.set("n", "<leader>fh", ":Telescope help_tags<CR>", opts)
keymap.set("n", "<leader>th", ":Telescope colorscheme<CR>", opts)
keymap.set("n", "<leader>of", ":Telescope oldfiles<CR>", opts)
keymap.set("n", "<leader>km", ":Telescope keymaps<CR>", opts)
keymap.set("n", "<leader>ls", ":Telescope lsp_document_symbols<CR>", opts)
keymap.set(
  "n",
  "<leader>lm",
  ":lua require('telescope.builtin').lsp_document_symbols({symbols = { 'Method' }})<CR>",
  opts
)
keymap.set("n", "<leader>lr", ":Telescope lsp_references<CR>", opts)
keymap.set("n", "<leader>ld", ":Telescope lsp_definitions<CR>", opts)
keymap.set("n", "<leader>bw", ":Telescope current_buffer_fuzzy_find<CR>", opts)
keymap.set("n", "<leader>bl", ":Telescope buffers<CR>", opts)
keymap.set("n", "<leader>df", ":lua require 'telescope'.extensions.file_browser.file_browser()<CR>", opts)
keymap.set("n", "<leader>ft", vim.lsp.buf.format, opts)

-- rename
keymap.set("n", "<leader>rn", ":lua vim.lsp.buf.rename()<CR>", opts)

-- code action
keymap.set("n", "<leader>ca", ":lua vim.lsp.buf.code_action()<CR>", opts)

-- go xx
keymap.set("n", "gD", ":lua vim.lsp.buf.type_definition()<CR>", opts)
keymap.set("n", "gd", ":lua vim.lsp.buf.definition()<CR>", opts)
keymap.set("n", "gh", ":lua vim.lsp.buf.hover()<CR>", opts)
keymap.set("n", "gD", ":lua vim.lsp.buf.declaration()<CR>", opts)
keymap.set("n", "gi", ":lua vim.lsp.buf.implementation()<CR>", opts)
keymap.set("n", "gr", ":lua vim.lsp.buf.references()<CR>", opts)

-- diagnostic
keymap.set("n", "go", ":lua vim.diagnostic.open_float()<CR>", opts)
keymap.set("n", "gp", ":lua vim.diagnostic.goto_prev()<CR>", opts)
keymap.set("n", "gn", ":lua vim.diagnostic.goto_next()<CR>", opts)
-- mapbuf('n', '<leader>q', '<cmd>lua vim.diagnostic.setloclist()<CR>', opt)

-- Diagnostics
keymap.set("n", "<C-j>", function()
  vim.diagnostic.goto_next()
end, opts)
