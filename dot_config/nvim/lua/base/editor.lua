return {
  {
    'ibhagwan/fzf-lua',
    dependencies = { 'nvim-web-devicons' },
    -- stylua: ignore
    keys = {
      { '<Leader><Space>', function() require('fzf-lua').buffers() end, desc = 'Fzf Buffers', },
      { '<Leader>f', function() require('fzf-lua').files() end, desc = 'Fzf Files', },
      { '<Leader>F', function() require('fzf-lua').files({ cwd = '~/' }) end, desc = 'Fzf Files ~', },
      { '<Leader><Leader>', function() require('fzf-lua').builtin() end, desc = 'Fzf builtin commands', },
      { '<Leader>r', function() require('fzf-lua').live_grep({ cmd = "rg --color=always --smart-case -g '!{.git,node_modules}/'" }) end, desc = 'Fzf RG', },
    },
  },
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
    'lewis6991/gitsigns.nvim',
    event = { 'BufReadPre', 'BufNewFile' },
    opts = {
      signs = {
        add = { hl = 'GitSignsAdd', text = '▌', numhl = 'GitSignsAddNr', linehl = 'GitSignsAddLn' },
        change = { hl = 'GitSignsChange', text = '▌', numhl = 'GitSignsChangeNr', linehl = 'GitSignsChangeLn' },
        delete = { hl = 'GitSignsDelete', text = '▌', numhl = 'GitSignsDeleteNr', linehl = 'GitSignsDeleteLn' },
        topdelete = { hl = 'GitSignsDelete', text = '▌', numhl = 'GitSignsDeleteNr', linehl = 'GitSignsDeleteLn' },
        changedelete = {
          hl = 'GitSignsChange',
          text = '▌',
          numhl = 'GitSignsChangeNr',
          linehl = 'GitSignsChangeLn',
        },
      },
      on_attach = function(bufnr)
        local gs = package.loaded.gitsigns

        local function map(mode, l, r, desc)
          vim.keymap.set(mode, l, r, { desc = desc, buffer = bufnr })
        end

        -- stylua: ignore start
        map("n", "]h", gs.next_hunk, "Next Hunk")
        map("n", "[h", gs.prev_hunk, "Prev Hunk")
        map('n', '<leader>hs', gs.stage_hunk, 'Stage hunk')
        map('n', '<leader>hr', gs.reset_hunk, 'Reset hunk')
        map('v', '<leader>hs', function() gs.stage_hunk({ vim.fn.line('.'), vim.fn.line('v') }) end, 'Stage hunk')
        map('v', '<leader>hr', function() gs.reset_hunk({ vim.fn.line('.'), vim.fn.line('v') }) end, 'Reset hunk')
        map('n', '<leader>hS', gs.stage_buffer, 'Stage buffer')
        map('n', '<leader>hu', gs.undo_stage_hunk, 'Undo stage hunk')
        map('n', '<leader>hR', gs.reset_buffer, 'Reset buffer')
        map('n', '<leader>hp', gs.preview_hunk, 'Preview hunk')
        map('n', '<leader>hb', function() gs.blame_line({ full = true }) end, 'Blame line')
        map('n', '<leader>htb', gs.toggle_current_line_blame, 'Toggle current line blame')
        map('n', '<leader>hd', gs.diffthis, 'diffthis')
        map('n', '<leader>hD', function() gs.diffthis('~') end, 'diffthis ~')
        map('n', '<leader>htd', gs.toggle_deleted, 'Toggle deleted')
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
    'echasnovski/mini.surround',
    event = 'VeryLazy',
    opts = {
      mappings = {
        add = 'ys',
        delete = 'ds',
        replace = 'cs',
        find = 'gs',
        find_left = 'gS', -- Find surrounding (to the left)
        highlight = 'zs', -- Highlight surrounding
        update_n_lines = '', -- Update `n_lines`

        suffix_last = 'l', -- Suffix to search with "prev" method
        suffix_next = 'n', -- Suffix to search with "next" method
      },
    },
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
    -- stylua: ignore start
    keys = {
      { '<Leader>Z', function() require('zen-mode').toggle() end, desc = 'Zen Mode' },
    },
    -- stylua: ignore end
  },
  {
    'whiteinge/diffconflicts',
    cmd = 'DiffConflicts',
  },

  -- Enhance built-in search functionality showing labels at the end of each match.
  {
    'folke/flash.nvim',
    event = 'VeryLazy',
    vscode = true,
    opts = {},
    -- stylua: ignore start
    keys = {
      { '<Leader>s', mode = { 'n', 'o', 'x' }, function() require('flash').jump() end,   desc = 'Flash', },
      { '<Leader>S', mode = { 'n', 'o', 'x' }, function() require('flash').treesitter() end, desc = 'Flash Treesitter', },
      { 'r', mode = 'o', function() require('flash').remote() end, desc = 'Remote Flash', },
      { 'R', mode = { 'o', 'x' }, function() require('flash').treesitter_search() end, desc = 'Treesitter Search', },
      { '<c-s>', mode = { 'c' }, function() require('flash').toggle() end, desc = 'Toggle Flash Search', },
    },
    -- stylua: ignore end
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
      { '<Leader>g', '<Cmd>LazyGit<CR>', desc = 'LazyGit' },
    },
  },
  {
    'stevearc/dressing.nvim',
    event = 'VeryLazy',
  },
  {
    'anuvyklack/windows.nvim',
    event = 'VeryLazy',
    dependencies = {
      'anuvyklack/middleclass',
      'anuvyklack/animation.nvim',
    },
    opts = {
      ignore = {
        buftype = { 'quickfix' },
        filetype = { 'NvimTree' },
      },
    },
    config = function(_, opts)
      vim.o.winwidth = 10
      vim.o.winminwidth = 10
      vim.o.equalalways = false
      require('windows').setup(opts)
    end,
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
        ['<Leader>h'] = { name = '+Hunk' },
      },
    },
    config = function(_, opts)
      local wk = require('which-key')
      wk.setup(opts.setup)
      wk.register(opts.defaults)
    end,
  },
}
