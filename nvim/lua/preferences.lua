vim.cmd([[autocmd FileType * set formatoptions-=ro]])

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.wrap = false
vim.opt.expandtab = false
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.cursorline = true
vim.opt.ignorecase = true
vim.opt.splitbelow = true
vim.opt.scrolloff = 10
vim.opt.termguicolors = true
vim.opt.hlsearch = false
vim.opt.autoindent = true
vim.opt.clipboard = "unnamedplus"

-- 是否显示不可见字符
vim.o.list = true
-- 不可见字符的显示，这里只把空格显示为一个点
--vim.o.listchars = "space:·,tab:<->,eol:¬"
vim.o.listchars = "space:·,tab:┊ ,eol:¬"
vim.o.linebreak = true
vim.o.showbreak = "↪"

-- 禁止创建备份文件
vim.o.backup = false
vim.o.writebackup = false
vim.o.swapfile = false

-- 当文件被外部程序修改时，自动加载
vim.o.autoread = true
vim.bo.autoread = true

-- 搜索大小写不敏感，除非包含大写
vim.o.ignorecase = true
vim.o.smartcase = true

-- jkhl 移动时光标周围保留40行
vim.o.scrolloff = 40
vim.o.sidescrolloff = 40

-- 缩短某些 Vim 消息的长度，以避免在屏幕上显示过长的消息。
vim.api.nvim_command("set shortmess+=c")

vim.opt.guifont = "JetBrainsMono Nerd Font"
