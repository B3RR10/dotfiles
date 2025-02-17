return {
  'hoob3rt/lualine.nvim',
  dependencies = {
    'AndreM222/copilot-lualine',
  },
  event = 'UIEnter',
  opts = function()
    local function isSession()
      if vim.v.this_session ~= '' then
        return '▣ '
      else
        return ''
      end
    end

    --- @param trunc_width number trunctates component when screen width is less than trunc_width
    --- @param trunc_len number truncates component to trunc_len number of chars
    --- @param hide_width number? hides component when window width is smaller then hide_width
    --- @param no_ellipsis boolean whether to disable adding '...' at end after truncation
    --- return function that can format the component accordingly
    local function trunc(trunc_width, trunc_len, hide_width, no_ellipsis)
      return function(str)
        local win_width = vim.fn.winwidth(0)
        if hide_width and win_width < hide_width then
          return ' '
        elseif trunc_width and trunc_len and win_width < trunc_width and #str > trunc_len then
          return str:sub(1, trunc_len) .. (no_ellipsis and '' or '…')
        else
          return str
        end
      end
    end

    return {
      options = {
        icons_enabled = true,
        theme = 'auto',
        component_separators = '',
        section_separators = '',
        disabled_filetypes = {},
        always_divide_middle = true,
      },
      sections = {
        lualine_a = { 'mode', isSession },
        lualine_b = {
          { 'branch', icon = '', fmt = trunc(1000, 20, 80, false) },
          { 'diff' }, --, source = diff_sources },
          { 'diagnostics', sources = { 'nvim_lsp' } },
        },
        lualine_c = {
          { 'filename', fmt = trunc(100, 30, nil, false) },
        },
        lualine_x = {
          'copilot',
          { require('lazy.status').updates, cond = require('lazy.status').has_updates, color = { fg = 'ff9e64' } },
          'searchcount',
          { 'encoding', show_bomb = true },
          'fileformat',
          'filetype',
        },
        lualine_y = { 'progress' },
        lualine_z = { 'location' },
      },
      inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { 'filename' },
        lualine_x = { 'location' },
        lualine_y = {},
        lualine_z = {},
      },
      tabline = {},
      winbar = {},
      extensions = { 'fugitive', 'fzf', 'lazy', 'mason', 'nvim-tree', 'quickfix' },
    }
  end,
}
