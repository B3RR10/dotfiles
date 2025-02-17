return {
  {
    'ThePrimeagen/harpoon',
    branch = 'harpoon2',
    dependencies = { 'nvim-lua/plenary.nvim', 'telescope.nvim' },
    event = 'VeryLazy',
    keys = function()
      local harpoon = require('harpoon')
      -- stylua: ignore
      return {
        { '<Leader>ha', function() harpoon:list():add() end, desc = 'Add current buffer to harpoon list', },
        { '<Leader>hl', function() harpoon.ui:toggle_quick_menu(harpoon:list()) end, desc = 'Open harpoon window' },

        { '<Leader>1', function() harpoon:list():select(1) end, desc = 'Jump to 1st on the list', },
        { '<Leader>2', function() harpoon:list():select(2) end, desc = 'Jump to 2nd on the list', },
        { '<Leader>3', function() harpoon:list():select(3) end, desc = 'Jump to 3rd on the list', },
        { '<Leader>4', function() harpoon:list():select(4) end, desc = 'Jump to 4th on the list', },
        { '<Leader>5', function() harpoon:list():select(5) end, desc = 'Jump to 5th on the list', },
        { '<Leader>6', function() harpoon:list():select(6) end, desc = 'Jump to 6th on the list', },
        { '<Leader>7', function() harpoon:list():select(7) end, desc = 'Jump to 7th on the list', },
        { '<Leader>8', function() harpoon:list():select(8) end, desc = 'Jump to 8th on the list', },
        { '<Leader>9', function() harpoon:list():select(9) end, desc = 'Jump to 9th on the list', },

        { '<Leader>hp', function() harpoon:list():prev({ ui_nav_wrap = true }) end, desc = 'Jump to previous on the list', },
        { '<Leader>hn', function() harpoon:list():next({ ui_nav_wrap  = true }) end, desc = 'Jump to next on the list', },
      }
    end,
    config = function()
      local harpoon = require('harpoon')
      harpoon:setup({
        settings = {
          save_on_toggle = true,
        },
      })
    end,
  },
  {
    'rhysd/committia.vim',
    event = 'BufReadPre',
    ft = 'gitcommit',
    config = function()
      vim.g.committia_hooks = {
        edit_open = function(_)
          vim.opt_local.spell = true

          vim.keymap.set('i', '<C-d>', '<Plug>(committia-scroll-diff-down-half)')
          vim.keymap.set('i', '<C-u>', '<Plug>(committia-scroll-diff-up-half)')
        end,
      }
    end,
  },
  {
    'whiteinge/diffconflicts',
    cmd = 'DiffConflicts',
  },
  {
    'norcalli/nvim-colorizer.lua',
    event = 'VeryLazy',
    config = true,
  },
  {
    'folke/which-key.nvim',
    event = 'VeryLazy',
    opts = {
      setup = {
        show_help = true,
        plugins = { spelling = true },
        triggers = 'auto',
        window = {
          border = 'single', -- none, single, double, shadow
          position = 'bottom', -- bottom, top
          margin = { 1, 0, 1, 0 }, -- extra window margin [top, right, bottom, left]
          padding = { 1, 1, 1, 1 }, -- extra window padding [top, right, bottom, left]
          winblend = 0,
        },
        layout = {
          height = { min = 4, max = 25 }, -- min and max height of the columns
          width = { min = 20, max = 50 }, -- min and max width of the columns
          spacing = 3, -- spacing between columns
          align = 'left', -- align columns left, center or right
        },
      },
      defaults = {
        mode = { 'n', 'v' },
        { '<Leader>f', group = 'File' },
        { '<Leader>g', group = 'Git' },
        { '<Leader>h', group = 'Harpoon' },
      },
    },
    config = function(_, opts)
      vim.o.timeoutlen = 300
      local wk = require('which-key')
      wk.setup(opts.setup)
      wk.register(opts.defaults)
    end,
  },
}
