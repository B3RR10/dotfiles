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
  spec = {
    { import = 'base' },
    { import = 'pde' },
    { import = 'plugins' },
  },
  defaults = { lazy = true },
  install = { missing = true, colorscheme = { 'kanagawa-dragon' } },
  checker = { enabled = true, notify = false },
  change_detection = { enabled = true, notify = false },
  performance = { cache = { enabled = true } },
})
