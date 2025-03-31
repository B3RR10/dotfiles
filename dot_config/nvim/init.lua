-- Clone 'mini.nvim' manually in a way that it gets managed by 'mini.deps'
local path_package = vim.fn.stdpath('data') .. '/site/'
local mini_path = path_package .. 'pack/deps/start/mini.nvim'
if not vim.uv.fs_stat(mini_path) then
  vim.cmd('echo "Installing `mini.nvim`" | redraw')
  local clone_cmd =
    { 'git', 'clone', '--filter=blob:none', 'https://github.com/echasnovski/mini.nvim', mini_path }
  vim.fn.system(clone_cmd)
  vim.cmd('packadd mini.nvim | helptags ALL')
  vim.cmd('echo "Installed `mini.nvim`" | redraw')
end

require('mini.deps').setup({ path = { package = path_package } })

---@class SpecOpts
---@field add string|table?
---@field require string|table?
---@field setup string|table?

---Add plugin and execute setup function
---@param opts SpecOpts
---@return function
local load = function(opts)
  local apply = function(x, func)
    if type(x) == 'table' and (#x > 0 or next(x) == nil) then
      for _, o in ipairs(x) do
        func(o)
      end
    else
      func(x)
    end
  end

  return function()
    if opts.add then apply(opts.add, function(s) MiniDeps.add(s) end) end
    if opts.require then apply(opts.require, function(name) require(name) end) end
    if opts.setup then apply(opts.setup, function(name) require(name).setup() end) end
  end
end

---@param opts SpecOpts
local now = function(opts) MiniDeps.now(load(opts)) end
---@param opts SpecOpts
local later = function(opts) MiniDeps.later(load(opts)) end

now({ require = { 'options', 'keymaps' } })

now({ add = 'rebelot/kanagawa.nvim', require = 'plugins.kanagawa' })
now({ add = 'Bekaboo/dropbar.nvim' })

now({
  add = {
    source = 'ThePrimeagen/harpoon',
    checkout = 'harpoon2',
    monitor = 'harpoon2',
    depends = { 'nvim-lua/plenary.nvim' },
  },
  require = 'plugins.harpoon',
})
now({ add = 'tpope/vim-fugitive' })
now({ setup = 'mini.icons' })
now({ setup = 'mini.tabline' })
now({ setup = 'plugins.mini-statusline' })
now({ add = 'folke/snacks.nvim', require = 'plugins.snacks' })

now({ add = 'whiteinge/diffconflicts' })
now({ add = 'b0o/SchemaStore.nvim' })
now({ add = 'tpope/vim-git' })
now({ add = 'NoahTheDuke/vim-just' })
now({ add = 'adelarsq/neofsharp.vim' })
now({ add = 'mrcjkb/rustaceanvim' })

later({
  add = {
    source = 'saghen/blink.cmp',
    depends = { 'rafamadriz/friendly-snippets' },
    checkout = 'v1.0.0',
    hooks = {
      post_checkout = function() vim.system({ 'cargo', 'build', '--release' }):wait() end,
      post_install = function() vim.system({ 'cargo', 'build', '--release' }):wait() end,
    },
  },
  require = 'plugins.blink',
})

later({
  add = {
    {
      source = 'nvim-treesitter/nvim-treesitter',
      depends = { 'JoosepAlviste/nvim-ts-context-commentstring' },
      hooks = { post_checkout = function() vim.cmd.TSUpdate() end },
    },
    { source = 'nvim-treesitter/nvim-treesitter-textobjects', depends = { 'nvim-treesitter' } },
  },
  require = 'plugins.treesitter',
})
later({ add = 'williamboman/mason.nvim', require = 'plugins.mason' })

later({ setup = 'mini.ai' })
later({ setup = 'mini.align' })
later({ setup = 'mini.indentscope' })
later({ setup = 'mini.jump2d' })
later({ setup = 'mini.surround' })
later({ setup = 'plugins.mini-bufremove' })
later({ setup = 'plugins.mini-clue' })
later({ setup = 'plugins.mini-diff' })
later({ setup = 'plugins.mini-files' })
later({ setup = 'plugins.mini-pairs' })

later({
  add = { source = 'stevearc/conform.nvim', depends = { 'mason.nvim' } },
  require = 'plugins.conform',
})
later({
  add = { source = 'andythigpen/nvim-coverage', depends = { 'nvim-lua/plenary.nvim' } },
  setup = 'coverage',
})
later({ add = 'RRethy/vim-illuminate', require = 'plugins.illuminate' })
later({
  add = { source = 'mfussenegger/nvim-lint', depends = { 'mason.nvim' } },
  require = 'plugins.lint',
})

later({
  add = { source = 'ionide/Ionide-vim', depends = { 'blink.cmp' } },
  require = 'plugins.ionide',
})
later({
  add = { source = 'seblj/roslyn.nvim', depends = { 'blink.cmp' } },
  require = 'plugins.roslyn',
})

later({ add = 'zk-org/zk-nvim', setup = 'zk' })

later({ add = 'norcalli/nvim-colorizer.lua', setup = 'colorizer' })
later({ add = 'ellisonleao/glow.nvim', setup = 'glow' })
