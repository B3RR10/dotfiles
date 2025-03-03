-- MiniFiles: toggle dotfiles
local show_dotfiles = true
local filter_show = function(_)
  return true
end
local filter_hide = function(fs_entry)
  return not vim.startswith(fs_entry.name, '.')
end
local toggle_dotfiles = function()
  show_dotfiles = not show_dotfiles
  local new_filter = show_dotfiles and filter_show or filter_hide
  MiniFiles.refresh({ content = { filter = new_filter } })
end
vim.api.nvim_create_autocmd('User', {
  pattern = 'MiniFilesBufferCreate',
  callback = function(args)
    local buf_id = args.data.buf_id
    vim.keymap.set('n', 'g.', toggle_dotfiles, { buffer = buf_id })
  end,
})

-- MiniFiles: add commands for horizontal and vertical split
local map_split = function(buf_id, lhs, direction)
  local rhs = function()
    -- Make new window and set it as target
    local cur_target = MiniFiles.get_explorer_state().target_window
    local new_target = vim.api.nvim_win_call(cur_target, function()
      vim.cmd(direction .. ' split')
      ---@diagnostic disable-next-line: redundant-return-value
      return vim.api.nvim_get_current_win()
    end)

    MiniFiles.set_target_window(new_target)
    MiniFiles.go_in({ close_on_file = true })
  end

  local desc = 'Split ' .. direction
  vim.keymap.set('n', lhs, rhs, { buffer = buf_id, desc = desc })
end
vim.api.nvim_create_autocmd('User', {
  pattern = 'MiniFilesBufferCreate',
  callback = function(args)
    local buf_id = args.data.buf_id
    -- Tweak keys to your liking
    map_split(buf_id, '<C-s>', 'belowright horizontal')
    map_split(buf_id, '<C-v>', 'belowright vertical')
  end,
})

-- MiniFiles: add command for jumping to current file
local focus_target_file = function()
  local target_window = MiniFiles.get_explorer_state().target_window
  local target_buf_id = vim.api.nvim_win_get_buf(target_window)
  local current_file_path = vim.api.nvim_buf_get_name(target_buf_id)
  if vim.uv.fs_stat(current_file_path) == nil then
    return vim.notify('Current buffer not found in disk')
  end

  local paths = { current_file_path }
  for dir in vim.fs.parents(current_file_path) do
    table.insert(paths, 1, dir)
    if dir == vim.env.PWD then
      break
    end
  end

  MiniFiles.set_branch(paths)
end
vim.api.nvim_create_autocmd('User', {
  pattern = 'MiniFilesBufferCreate',
  callback = function(args)
    vim.keymap.set('n', ',', focus_target_file, { buffer = args.data.buf_id, desc = 'Focus current buffer' })
  end,
})

return {
  'echasnovski/mini.nvim',
  lazy = false,
  config = function()
    require('mini.ai').setup()
    require('mini.align').setup()
    require('mini.bracketed').setup()
    require('mini.files').setup({
      windows = {
        preview = true,
        width_preview = 50,
      },
    })
    require('mini.icons').setup()
    require('mini.indentscope').setup()
    require('mini.jump2d').setup()
    require('mini.pairs').setup({
      modes = { insert = true, command = false, terminal = false },

      -- Global mappings. Each right hand side should be a pair information, a
      -- table with at least these fields (see more in |MiniPairs.map|):
      -- - <action> - one of 'open', 'close', 'closeopen'.
      -- - <pair> - two character string for pair to be used.
      -- By default pair is not inserted after `\`, quotes are not recognized by
      -- `<CR>`, `'` does not insert pair after a letter.
      -- Only parts of tables can be tweaked (others will use these defaults).
      mappings = {
        [')'] = { action = 'close', pair = '()', neigh_pattern = '[^\\].' },
        [']'] = { action = 'close', pair = '[]', neigh_pattern = '[^\\].' },
        ['}'] = { action = 'close', pair = '{}', neigh_pattern = '[^\\].' },
        ['['] = {
          action = 'open',
          pair = '[]',
          neigh_pattern = '.[%s%z%)}%]]',
          register = { cr = false },
          -- foo|bar -> press "[" -> foo[bar
          -- foobar| -> press "[" -> foobar[]
          -- |foobar -> press "[" -> [foobar
          -- | foobar -> press "[" -> [] foobar
          -- foobar | -> press "[" -> foobar []
          -- {|} -> press "[" -> {[]}
          -- (|) -> press "[" -> ([])
          -- [|] -> press "[" -> [[]]
        },
        ['{'] = {
          action = 'open',
          pair = '{}',
          -- neigh_pattern = ".[%s%z%)}]",
          neigh_pattern = '.[%s%z%)}%]]',
          register = { cr = false },
          -- foo|bar -> press "{" -> foo{bar
          -- foobar| -> press "{" -> foobar{}
          -- |foobar -> press "{" -> {foobar
          -- | foobar -> press "{" -> {} foobar
          -- foobar | -> press "{" -> foobar {}
          -- (|) -> press "{" -> ({})
          -- {|} -> press "{" -> {{}}
        },
        ['('] = {
          action = 'open',
          pair = '()',
          -- neigh_pattern = ".[%s%z]",
          neigh_pattern = '.[%s%z%)]',
          register = { cr = false },
          -- foo|bar -> press "(" -> foo(bar
          -- foobar| -> press "(" -> foobar()
          -- |foobar -> press "(" -> (foobar
          -- | foobar -> press "(" -> () foobar
          -- foobar | -> press "(" -> foobar ()
        },
        -- Single quote: Prevent pairing if either side is a letter
        ['"'] = {
          action = 'closeopen',
          pair = '""',
          neigh_pattern = '[^%w\\][^%w]',
          register = { cr = false },
        },
        -- Single quote: Prevent pairing if either side is a letter
        ["'"] = {
          action = 'closeopen',
          pair = "''",
          neigh_pattern = '[^%w\\][^%w]',
          register = { cr = false },
        },
        -- Backtick: Prevent pairing if either side is a letter
        ['`'] = {
          action = 'closeopen',
          pair = '``',
          neigh_pattern = '[^%w\\][^%w]',
          register = { cr = false },
        },
      },
    })
    require('mini.surround').setup()
  end,
  -- stylua: ignore
  keys = {
    { '<C-p>', function() if not MiniFiles.close() then MiniFiles.open() end end, desc = 'Toggle file explorer' },
  },
}
