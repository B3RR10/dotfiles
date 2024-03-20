return {
  {
    'nvim-tree/nvim-tree.lua',
    keys = {
      { '<C-p>', '<Cmd>NvimTreeToggle<CR>', desc = 'Toggle neovim-tree' },
    },
    opts = {
      update_cwd = true,
      update_focused_file = {
        enable = true,
        ignore_list = { '.git', 'node_modules', '.cache' },
      },
      view = {
        width = '25%',
        number = true,
        relativenumber = true,
      },
      renderer = {
        group_empty = true,
        highlight_opened_files = 'name',
        highlight_git = true,
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
        { '<Leader>ha', function() harpoon:list():append() end, desc = 'Append current buffer to harpoon list', },
        { '<Leader>hl', function() harpoon.ui:toggle_quick_menu(harpoon:list()) end, desc = 'Open harpoon window' },

        { '<Leader>1', function() harpoon:list():nav_file(1) end, desc = 'Jump to 1st on the list', },
        { '<Leader>2', function() harpoon:list():nav_file(2) end, desc = 'Jump to 2nd on the list', },
        { '<Leader>3', function() harpoon:list():nav_file(3) end, desc = 'Jump to 3rd on the list', },
        { '<Leader>4', function() harpoon:list():nav_file(4) end, desc = 'Jump to 4th on the list', },

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

      local function map(key, dir, buffer)
        vim.keymap.set('n', key, function()
          require('illuminate')['goto_' .. dir .. '_reference'](false)
        end, { desc = dir:sub(1, 1):upper() .. dir:sub(2) .. ' Reference', buffer = buffer })
      end

      map('[[', 'prev')
      map(']]', 'next')

      vim.api.nvim_create_autocmd('FileType', {
        callback = function()
          local buffer = vim.api.nvim_get_current_buf()
          map('[[', 'prev', buffer)
          map(']]', 'next', buffer)
        end,
      })
    end,
    keys = {
      { '[[', desc = 'Prev Reference' },
      { ']]', desc = 'Next Reference' },
    },
  },
  {
    'rmagatti/auto-session',
    event = 'VimEnter',
    opts = {
      log_level = 'error',
      auto_save_enabled = true,
      auto_restore_enabled = true,
      auto_session_create_enabled = false,
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
    'norcalli/nvim-colorizer.lua',
    event = 'VeryLazy',
    config = true,
  },
  {
    'kdheepak/lazygit.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
    keys = {
      { '<Leader>gg', '<Cmd>LazyGit<CR>', desc = 'LazyGit' },
    },
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
        ['<Leader>f'] = { name = '+File' },
        ['<Leader>h'] = { name = '+Harpoon' },
        ['<Leader>g'] = { name = '+Git' },
      },
    },
    config = function(_, opts)
      local wk = require('which-key')
      wk.setup(opts.setup)
      wk.register(opts.defaults)
    end,
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
}
