vim.api.nvim_create_autocmd('LspProgress', {
  callback = function(event)
    local spinner = { '⠋', '⠙', '⠹', '⠸', '⠼', '⠴', '⠦', '⠧', '⠇', '⠏' }
    vim.notify(vim.lsp.status(), vim.log.levels.INFO, {
      id = 'lsp_progress',
      title = 'LSP Progress',
      opts = function(notif)
        notif.icon = event.data.params.value.kind == 'end' and ' '
          or spinner[math.floor(vim.uv.hrtime() / (1e6 * 80)) % #spinner + 1]
      end,
    })
  end,
})

return {
  'folke/snacks.nvim',
  lazy = false,
  priority = 1000,
  opts = {
    bigfile = { enabled = true },
    dim = { enabled = true },
    input = { enabled = true },
    notifier = {
      enabled = true,
      timeout = 5000,
    },
    picker = {
      enabled = true,
      win = {
        input = {
          keys = {
            ['<Esc>'] = { 'close', mode = { 'i', 'n' } },
          },
        },
      },
      sources = {
        explorer = {
          auto_close = true,
          jump = { close = true },
          win = {
            list = {
              keys = {
                ['<C-p>'] = 'close',
                ['o'] = 'confirm',
              },
            },
          },
        },
      },
    },
    scroll = { enabled = true },
    statuscolumn = { enabled = true },
    styles = {
      input = {
        relative = 'cursor',
        row = -3,
        col = 0,
      },
    },
    zen = {
      enabled = true,
      toggles = {
        dim = true,
        git_signs = false,
        mini_diff_signs = false,
      },
      show = {
        statusline = false,
        tabline = false,
      },
    },
  },
  keys = function()
    local function is_git_repo()
      vim.fn.system('git rev-parse --is-inside-work-tree')
      return vim.v.shell_error == 0
    end
    local function get_git_root()
      local dot_git_path = vim.fn.finddir('.git', '.;')
      return vim.fn.fnamemodify(dot_git_path, ':h')
    end

    local function find_files_from_project_git_root()
      local opts = {
        hidden = true,
      }
      if is_git_repo() then
        vim.list_extend(opts, { cwd = get_git_root() })
      end
      Snacks.picker.files(opts)
    end

    local function live_grep_from_project_git_root()
      local opts = {}
      if is_git_repo() then
        opts = { cwd = get_git_root() }
      end
      Snacks.picker.grep(opts)
    end

    -- stylua: ignore
    return {
      -- Picker
      { '<leader><leader>', function() Snacks.picker.pickers() end,                               desc = 'Snacks pickers' },
      { '<leader><space>',  function() Snacks.picker.buffers() end,                               desc = 'Find Buffers' },
      { '<leader>ff',       function() find_files_from_project_git_root() end,                    desc = 'Find files', },
      { '<leader>fF',       function() Snacks.picker.files({ cwd = '~/' }) end,                   desc = 'Find files in ~' },
      { '<leader>fs',       function() Snacks.picker.files({ cwd = vim.fn.expand('%:p:h') }) end, desc = 'Find Sibling files' },
      { '<leader>fc',       function() Snacks.picker.commands() end,                              desc = 'Find Neovim commands' },
      { '<leader>fr',       function() live_grep_from_project_git_root() end,                     desc = 'Grep' },

      { '<leader>z',  function() Snacks.zen() end,                   desc = 'Toggle Zen Mode' },
      { '<leader>Z',  function() Snacks.zen.zoom() end,              desc = 'Toggle Zoom Mode' },
      { '<leader>ns', function() Snacks.notifier.show_history() end, desc = 'Notification History' },
      { '<leader>nh', function() Snacks.notifier.hide() end,         desc = 'Dismiss All Notification' },

      {
        '<leader>N',
        function()
          Snacks.win({
            file = vim.api.nvim_get_runtime_file('doc/news.txt', false)[1],
            width = 0.6,
            height = 0.6,
            wo = {
              spell = false,
              wrap = false,
              signcolumn = 'yes',
              statuscolumn = ' ',
              conceallevel = 3,
            },
          })
        end,
        desc = 'Neovim News',
      },
    }
  end,
}
