vim.cmd.syntax('enable')
vim.cmd.filetype({ 'plugin', 'indent', 'on' })

if vim.opt.diff:get() then
  vim.o.foldopen = ''
else
  vim.o.foldopen = 'all'
end

vim.o.breakindent = true
vim.o.clipboard = 'unnamedplus'
vim.o.completeopt = 'menuone,noselect'
vim.o.cursorline = true
vim.o.cursorlineopt = 'number'
vim.o.expandtab = true
vim.o.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
vim.o.foldmethod = 'expr'
vim.o.foldnestmax = 3
vim.o.ignorecase = true
vim.o.linebreak = true
vim.o.list = true
vim.o.number = true
vim.o.relativenumber = true
vim.o.scrolloff = 5
vim.o.sessionoptions = 'buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions'
vim.o.shiftwidth = 0
vim.o.showbreak = '> '
vim.o.showtabline = 2
vim.o.smartcase = true
vim.o.smartindent = true
vim.o.spelllang = 'en,de,es'
vim.o.spelloptions = 'camel'
vim.o.splitbelow = true
vim.o.splitright = true
vim.o.swapfile = false
vim.o.tabstop = 4
vim.o.termguicolors = true
vim.o.textwidth = 120
vim.o.timeoutlen = 500
vim.o.updatetime = 300
vim.o.visualbell = true
vim.o.winborder = 'rounded'

vim.opt.formatoptions:remove('t')
vim.opt.listchars = {
  tab = '| ',
  trail = '·',
  precedes = '«',
  extends = '»',
  nbsp = '·',
}
