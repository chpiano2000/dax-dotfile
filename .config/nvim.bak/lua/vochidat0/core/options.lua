vim.cmd("let g:netrw_liststyle = 3")

local opt = vim.opt
-- vim.cmd([[
--   highlight Normal guibg=none ctermbg=none
--   highlight NonText guibg=none ctermbg=none
--   highlight LineNr guibg=none ctermbg=none
--   highlight SignColumn guibg=none ctermbg=none
--   highlight VertSplit guibg=none ctermbg=none
--   highlight EndOfBuffer guibg=none ctermbg=none
--   highlight StatusLine guibg=none ctermbg=none
--   highlight StatusLineNC guibg=none ctermbg=none
-- ]])

opt.relativenumber = true
opt.number = true

-- tabs & indentation
opt.tabstop = 2 -- 2 spaces for tabs (prettier default)
opt.shiftwidth = 2 -- 2 spaces for indent width
opt.expandtab = true -- expand tab to spaces
opt.autoindent = true -- copy indent from current line when starting new one
vim.opt.scrolloff = 9999

opt.wrap = false

-- search settings
opt.ignorecase = true -- ignore case when searching
opt.smartcase = true -- if you include mixed case in your search, assumes you want case-sensitive

opt.cursorline = true

-- turn on termguicolors for tokyonight colorscheme to work
-- (have to use iterm2 or any other true color terminal)
opt.termguicolors = true
opt.background = "light" -- colorschemes that can be light or dark will be made dark
opt.signcolumn = "yes" -- show sign column so that text doesn't shift

-- backspace
opt.backspace = "indent,eol,start" -- allow backspace on indent, end of line or insert mode start position

-- clipboard
opt.clipboard:append("unnamedplus") -- use system clipboard as default register

-- split windows
opt.splitright = true -- split vertical window to the right
opt.splitbelow = true -- split horizontal window to the bottom

-- turn off swapfile
opt.swapfile = false

-- fold
opt.foldcolumn = "1"
opt.foldmethod = "indent"
opt.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
opt.foldlevelstart = 99
opt.foldenable = true
opt.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]]
vim.g.python3_host_prog = "/opt/homebrew/bin/python3"
