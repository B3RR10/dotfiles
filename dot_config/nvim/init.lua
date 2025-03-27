-- Options
vim.cmd.syntax('enable')
vim.cmd.filetype({ 'plugin', 'indent', 'on' })

vim.cmd([[
    let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
    let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
  ]])
vim.opt.termguicolors = true

-- TODO: This should be dynamic, an autocmd perhaps?
if vim.opt.diff:get() then
  vim.opt.foldopen = ''
  -- vim.opt.foldclose = ''
else
  vim.opt.foldopen = 'all'
  -- vim.opt.foldclose = 'all'
end

vim.opt.breakindent = true
vim.opt.clipboard = 'unnamedplus'
vim.opt.completeopt = 'menu,menuone,noselect'
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

-- Install lazy.nvim
local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.uv.fs_stat(lazypath) then
  vim.fn.system({
    'git',
    'clone',
    '--filter=blob:none',
    '--branch=stable', -- latest stable release
    'https://github.com/folke/lazy.nvim.git',
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Setup lazy.nvim
require('lazy').setup({
  spec = { { import = 'plugins' } },
  defaults = { lazy = true },
  install = { missing = true, colorscheme = { 'kanagawa-dragon' } },
  checker = { enabled = true, notify = false },
  change_detection = { enabled = true, notify = false },
  performance = { cache = { enabled = true } },
})

-- Escape commands
vim.keymap.set('i', 'jk', '<ESC>', { noremap = true })
vim.keymap.set('i', 'JK', '<ESC>', { noremap = true })

-- Moving chars
vim.keymap.set('n', 'L', 'xp', { noremap = true })
vim.keymap.set('n', 'H', 'Xph', { noremap = true })

-- Keep visual selection after indent
vim.keymap.set('v', '<', '<gv', { noremap = true })
vim.keymap.set('v', '>', '>gv', { noremap = true })

-- Copy to end of line
vim.keymap.set('', 'Y', 'y$', { noremap = true })

-- nohlsearch
vim.keymap.set('n', '<Esc>', ':noh<CR>', { noremap = true, silent = true })
