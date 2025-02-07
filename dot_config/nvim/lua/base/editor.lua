return {
  {
    'nvim-tree/nvim-tree.lua',
    keys = {
      { '<C-p>', '<Cmd>NvimTreeToggle<CR>', desc = 'Toggle neovim-tree' },
    },
    opts = {
      sync_root_with_cwd = true,
      hijack_unnamed_buffer_when_opening = true,
      select_prompts = true,
      view = {
        width = '25%',
        number = true,
        relativenumber = true,
      },
      renderer = {
        group_empty = true,
        highlight_git = 'name',
        highlight_opened_files = 'name',
      },
      update_focused_file = {
        enable = true,
        update_root = {
          enable = true,
          ignore_list = { '.git', 'node_modules', '.cache' },
        },
      },
      filters = {
        git_ignored = false,
      },
      actions = {
        open_file = {
          quit_on_open = true,
        },
      },
    },
  },
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
    'lewis6991/gitsigns.nvim',
    event = { 'BufReadPre', 'BufNewFile' },
    opts = {
      on_attach = function(bufnr)
        local gs = package.loaded.gitsigns

        local function map(mode, l, r, desc)
          vim.keymap.set(mode, l, r, { desc = desc, buffer = bufnr })
        end

        -- stylua: ignore start
        map("n", "]h", gs.next_hunk, "Next Hunk")
        map("n", "[h", gs.prev_hunk, "Prev Hunk")
        map('n', '<leader>gs', gs.stage_hunk, 'Stage hunk')
        map('n', '<leader>gr', gs.reset_hunk, 'Reset hunk')
        map('v', '<leader>gs', function() gs.stage_hunk({ vim.fn.line('.'), vim.fn.line('v') }) end, 'Stage hunk')
        map('v', '<leader>gr', function() gs.reset_hunk({ vim.fn.line('.'), vim.fn.line('v') }) end, 'Reset hunk')
        map('n', '<leader>gS', gs.stage_buffer, 'Stage buffer')
        map('n', '<leader>gu', gs.undo_stage_hunk, 'Undo stage hunk')
        map('n', '<leader>gR', gs.reset_buffer, 'Reset buffer')
        map('n', '<leader>gp', gs.preview_hunk, 'Preview hunk')
        map('n', '<leader>gb', function() gs.blame_line({ full = true }) end, 'Blame line')
        map('n', '<leader>gtb', gs.toggle_current_line_blame, 'Toggle current line blame')
        map('n', '<leader>gd', gs.diffthis, 'diffthis')
        map('n', '<leader>gD', function() gs.diffthis('~') end, 'diffthis ~')
        map('n', '<leader>gtd', gs.toggle_deleted, 'Toggle deleted')
        -- stylua: ignore end

        -- Text object
        map({ 'o', 'x' }, 'ih', ':<C-U>Gitsigns select_hunk<CR>')
      end,
    },
  },
  {
    'sindrets/diffview.nvim',
    cmd = { 'DiffviewFileHistory', 'DiffviewOpen' },
    opts = {},
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
    'kdheepak/lazygit.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
    keys = {
      { '<Leader>gg', '<Cmd>LazyGit<CR>', desc = 'LazyGit' },
    },
  },
  {
    'tpope/vim-fugitive',
    event = 'VeryLazy',
  },
  {
    'RRethy/vim-illuminate',
    event = { 'BufReadPost', 'BufNewFile' },
    opts = {
      delay = 100,
      large_file_cutoff = 2000,
      large_file_overrides = {
        providers = { 'lsp', 'treesitter' },
      },
    },
    config = function(_, opts)
      require('illuminate').configure(opts)
    end,
    -- stylua: ignore
    keys = {
      { '[[', function() require('illuminate').goto_prev_reference() end, desc = 'Prev Reference', },
      { ']]', function() require('illuminate').goto_next_reference() end, desc = 'Next Reference', },
    },
  },
  {
    'rmagatti/auto-session',
    lazy = false,
    opts = {
      auto_create = false,
      auto_restore = true,
      auto_save = true,
      log_level = 'error',
      use_git_branch = true,
    },
  },
  {
    'wellle/targets.vim',
    event = 'VeryLazy',
  },
  {
    'echasnovski/mini.align',
    event = 'VeryLazy',
    config = true,
  },
  {
    'echasnovski/mini.indentscope',
    event = { 'BufReadPre', 'BufNewFile' },
    config = true,
  },
  {
    'kylechui/nvim-surround',
    version = '*',
    event = 'VeryLazy',
    config = true,
  },
  {
    'folke/zen-mode.nvim',
    dependencies = { 'folke/twilight.nvim' },
    opts = {
      window = {
        options = {
          signcolumn = 'no',
          number = true,
          relativenumber = true,
          cursorline = true,
          cursorcolumn = false,
          foldcolumn = '0',
          list = false,
        },
      },
      plugins = {
        options = {
          enabled = true,
          ruler = false,
          showcmd = true,
        },
        twilight = { enabled = true },
        gitsigns = { enabled = false },
        tmux = { enabled = true },
        kitty = {
          enabled = true,
          font = '+8',
        },
      },
    },
    -- stylua: ignore
    keys = {
      { '<Leader>Z', function() require('zen-mode').toggle() end, desc = 'Zen Mode' },
    },
  },
  {
    'whiteinge/diffconflicts',
    cmd = 'DiffConflicts',
  },
  -- Enhance built-in search functionality showing labels at the end of each match.
  {
    'folke/flash.nvim',
    event = 'VeryLazy',
    opts = {
      label = {
        rainbow = {
          enabled = true,
        },
      },
      modes = {
        search = {
          enabled = true,
        },
      },
    },
    -- stylua: ignore
    keys = {
      { '<Leader>s', mode = { 'n', 'o', 'x' }, function() require('flash').jump() end,   desc = 'Flash', },
      { '<Leader>S', mode = { 'n', 'o', 'x' }, function() require('flash').treesitter() end, desc = 'Flash Treesitter', },
      { 'r', mode = 'o', function() require('flash').remote() end, desc = 'Remote Flash', },
      { 'R', mode = { 'o', 'x' }, function() require('flash').treesitter_search() end, desc = 'Treesitter Search', },
      { '<c-s>', mode = { 'c' }, function() require('flash').toggle() end, desc = 'Toggle Flash Search', },
    },
  },
  {
    'tpope/vim-unimpaired',
    event = 'VeryLazy',
  },
  {
    'norcalli/nvim-colorizer.lua',
    event = 'VeryLazy',
    config = true,
  },
  {
    'stevearc/dressing.nvim',
    event = 'VeryLazy',
    opts = {},
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
  {
    'j-hui/fidget.nvim',
    event = 'VeryLazy',
    opts = {
      progress = {
        display = {
          done_ttl = 10,
        },
      },
      notification = {
        override_vim_notify = true,
      },
    },
  },
  {
    'xvzc/chezmoi.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
    opts = {
      edit = {
        watch = true,
        force = true,
      },
    },
    config = function(_, opts)
      require('chezmoi').setup(opts)

      local chezmoi_source_path = require('chezmoi.commands.__source-path').execute()[1]
      vim.api.nvim_create_autocmd({ 'BufReadPre', 'BufNewFile' }, {
        pattern = { chezmoi_source_path .. '/*' },
        callback = function()
          vim.schedule(require('chezmoi.commands.__edit').watch)
        end,
      })
      vim.api.nvim_create_autocmd('BufReadPost', {
        pattern = { chezmoi_source_path .. '/*' },
        callback = function()
          vim.fn.chdir(chezmoi_source_path)
        end,
      })
    end,
  },
  {
    'zk-org/zk-nvim',
    ft = 'markdown',
    lazy = false,
    config = function()
      require('zk').setup({})
    end,
  },
}
