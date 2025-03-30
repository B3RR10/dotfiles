-- Options
vim.cmd.syntax('enable')
vim.cmd.filetype({ 'plugin', 'indent', 'on' })

vim.cmd([[
    let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
    let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
  ]])
vim.opt.termguicolors = true

if vim.opt.diff:get() then
  vim.opt.foldopen = ''
else
  vim.opt.foldopen = 'all'
end

vim.opt.breakindent = true
vim.opt.clipboard = 'unnamedplus'
vim.opt.completeopt = 'menuone,noselect'
vim.opt.cursorline = true
vim.opt.cursorlineopt = 'number'
vim.opt.expandtab = true
-- vim.opt.foldclose = 'all'
vim.opt.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
vim.opt.foldmethod = 'expr'
vim.opt.foldnestmax = 3
vim.opt.formatoptions:remove('t')
vim.opt.ignorecase = true
vim.opt.linebreak = true
vim.opt.list = true
vim.opt.listchars = {
  tab = '| ',
  trail = '·',
  precedes = '«',
  extends = '»',
  nbsp = '·',
}
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.scrolloff = 5
vim.opt.sessionoptions = 'buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions'
vim.opt.shiftwidth = 0
vim.opt.showbreak = '> '
vim.opt.showtabline = 2
vim.opt.smartcase = true
vim.opt.smartindent = true
vim.opt.spelllang = 'en,de,es'
vim.opt.spelloptions = 'camel'
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.swapfile = false
vim.opt.tabstop = 4
vim.opt.textwidth = 120
vim.opt.timeoutlen = 500
vim.opt.updatetime = 300
vim.opt.visualbell = true
vim.opt.winborder = 'rounded'
