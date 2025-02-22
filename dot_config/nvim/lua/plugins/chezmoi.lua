return {
  'xvzc/chezmoi.nvim',
  lazy = false,
  dependencies = { 'nvim-lua/plenary.nvim' },
  opts = {
    edit = {
      watch = true,
      force = true,
    },
  },
  config = function(_, opts)
    require('chezmoi').setup(opts)

    local chezmoi_source_path = require('chezmoi.commands.__source-path').execute({})[1]
    vim.api.nvim_create_autocmd({ 'BufRead', 'BufNewFile' }, {
      pattern = { chezmoi_source_path .. '/*' },
      callback = function(ev)
        local bufnr = ev.buf
        local edit_watch = function()
          require('chezmoi.commands.__edit').watch(bufnr)
        end
        vim.schedule(edit_watch)
      end,
    })
    vim.api.nvim_create_autocmd('BufReadPost', {
      pattern = { chezmoi_source_path .. '/*' },
      callback = function()
        vim.fn.chdir(chezmoi_source_path)
      end,
    })
  end,

  -- TODO: Add keybinding to select chezmoi files in Snacks.picker
}
