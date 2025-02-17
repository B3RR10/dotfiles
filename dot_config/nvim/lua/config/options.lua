local cmd = vim.cmd
local opt = vim.opt

cmd('syntax enable')
cmd('filetype plugin indent on')

vim.cmd([[
    let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
    let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
  ]])
opt.termguicolors = true

if opt.diff:get() then
  opt.foldopen = ''
else
  opt.foldopen = 'all'
end

opt.autoindent = true
opt.autoread = true
opt.breakindent = true
opt.clipboard = 'unnamedplus'
opt.cpoptions:append('n')
opt.cursorline = true
opt.cursorlineopt = 'number'
opt.encoding = 'utf-8'
opt.expandtab = true
opt.foldclose = 'all'
opt.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
opt.foldmethod = 'expr'
opt.foldnestmax = 3
opt.formatoptions:remove('o')
opt.formatoptions:remove('t')
opt.hidden = true
opt.ignorecase = true
opt.incsearch = true
opt.lazyredraw = true
opt.linebreak = true
opt.list = true
opt.listchars = {
  tab = '| ',
  trail = '·',
  precedes = '«',
  extends = '»',
  nbsp = '·',
}
opt.number = true
opt.relativenumber = true
opt.scrolloff = 5
opt.sessionoptions = 'buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions'
opt.shiftwidth = 0
opt.shortmess:append('n')
opt.showbreak = '> '
opt.showtabline = 2
opt.smartcase = true
opt.smartindent = true
opt.splitbelow = true
opt.splitright = true
opt.swapfile = false
opt.tabstop = 4
opt.textwidth = 120
opt.timeoutlen = 500
opt.updatetime = 300
opt.visualbell = true
