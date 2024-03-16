return {
  {
    'nvim-telescope/telescope.nvim',
    dependencies = {
      'nvim-web-devicons',
      'nvim-lua/plenary.nvim',
      { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
    },
    keys = function()
      local builtin = require('telescope.builtin')

      local function is_git_repo()
        vim.fn.system('git rev-parse --is-inside-work-tree')
        return vim.v.shell_error == 0
      end
      local function get_git_root()
        local dot_git_path = vim.fn.finddir('.git', '.;')
        return vim.fn.fnamemodify(dot_git_path, ':h')
      end

      local function find_files_from_project_git_root()
        local opts = {}
        if is_git_repo() then
          opts = { cwd = get_git_root() }
        end
        builtin.find_files(opts)
      end

      local function live_grep_from_project_git_root()
        local opts = {}
        if is_git_repo() then
          opts = { cwd = get_git_root() }
        end
        builtin.live_grep(opts)
      end

      -- stylua: ignore
      return {
        { '<Leader><Space>', function() builtin.buffers({ sort_mru = true, ignore_current_buffer = true }) end, desc = 'Find Buffers', },
        { '<Leader>ff', function() find_files_from_project_git_root() end, desc = 'Find Files in current git project', },
        { '<Leader>fF', function() builtin.find_files({ cwd = '~/' }) end, desc = 'Find Files in ~', },
        { '<Leader>fs', function() builtin.find_files({ cwd = vim.fn.expand('%:p:h') }) end, desc = 'Find Sibling files' },
        { '<Leader><Leader>', function() builtin.help_tags() end, desc = 'Fzf builtin commands', },
        { '<Leader>fr', function() live_grep_from_project_git_root() end, desc = 'Fzf RG', },
      }
    end,
    opts = function()
      local actions = require('telescope.actions')

      return {
        defaults = {
          mappings = {
            i = {
              ['<Esc>'] = actions.close,
              ['<C-u>'] = false,
              ['<C-d>'] = actions.delete_buffer + actions.move_to_top,
            },
          },
        },
        extensions = {
          fzf = {
            fuzzy = true,
            override_generic_sorter = true,
            override_file_sorter = true,
            case_mode = 'smart_case',
          },
        },
      }
    end,
    config = function(_, opts)
      local telescope = require('telescope')
      telescope.setup(opts)

      telescope.load_extension('fzf')
    end,
  },
}
