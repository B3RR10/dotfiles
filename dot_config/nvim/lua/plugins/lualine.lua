return {
  'hoob3rt/lualine.nvim',
  event = 'UIEnter',
  opts = function()
    local function harpooned()
      local harpoon = require('harpoon')
      local harpoon_icon = require('mini.icons').get('filetype', 'harpoon')

      local root_dir = harpoon:list().config.get_root_dir()
      local current_file_path = vim.api.nvim_buf_get_name(0)

      local harpoon_items = harpoon:list().items

      for _, harpoon_item in ipairs(harpoon_items) do
        local harpoon_path = harpoon_item.value

        -- If relative path, prepend root_dir
        if string.sub(harpoon_path, 1, 1) ~= '/' then
          local path_separator = '/'
          if vim.fn.has('win32') == 1 or vim.fn.has('win32unix') == 1 then path_separator = '\\' end

          harpoon_path = root_dir .. path_separator .. harpoon_path
        end

        if harpoon_path == current_file_path then return harpoon_icon end
      end

      return ''
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
        lualine_a = { 'mode', harpooned },
        lualine_b = {
          { 'FugitiveHead', icon = '', fmt = trunc(1000, 20, 80, false) },
          { 'diff' }, --, source = diff_sources },
          { 'diagnostics', sources = { 'nvim_lsp' } },
        },
        lualine_c = {
          { 'filename', fmt = trunc(100, 30, nil, false) },
        },
        lualine_x = {
          'copilot',
          {
            require('lazy.status').updates,
            cond = require('lazy.status').has_updates,
            color = { fg = 'ff9e64' },
          },
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
