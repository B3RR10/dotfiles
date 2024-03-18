return {
  {
    'rebelot/kanagawa.nvim',
    event = 'VimEnter',
    opts = {
      undercurl = true, -- enable undercurls
      commentStyle = { italic = true },
      functionStyle = {},
      keywordStyle = { italic = true },
      statementStyle = { bold = true },
      typeStyle = {},
      variablebuiltinStyle = { italic = true },
      specialReturn = true, -- special highlight for the return keyword
      specialException = true, -- special highlight for exception handling keywords
      transparent = false, -- do not set background color
      dimInactive = true, -- dim inactive window `:h hl-NormalNC`
      globalStatus = false, -- adjust window separators highlight for laststatus=3
      terminalColors = true, -- define vim.g.terminal_color_{0,17}
      colors = {},
      theme = 'default', -- Load "default" theme or the experimental "light" theme
    },
    config = function(_, opts)
      require('kanagawa').setup(opts)
      vim.cmd('colorscheme kanagawa-dragon')
    end,
  },
  {
    'hoob3rt/lualine.nvim',
    dependencies = {
      'AndreM222/copilot-lualine',
    },
    event = 'VeryLazy',
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
            return ''
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
            { 'branch', fmt = trunc(150, 20, 80, false) },
            'diff',
            { 'diagnostics', sources = { 'nvim_lsp' } },
          },
          lualine_c = {
            { 'filename', fmt = trunc(100, 30, nil, false) },
          },
          lualine_x = {
            'copilot',
            { require('lazy.status').updates, cond = require('lazy.status').has_updates, color = { fg = 'ff9e64' } },
            'searchcount',
            'encoding',
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
        extensions = { 'fzf', 'nvim-tree', 'quickfix', 'fugitive' },
      }
    end,
  },
  {
    'akinsho/nvim-bufferline.lua',
    event = 'VeryLazy',
    opts = {
      options = {
        -- mappings = true | false,
        max_prefix_length = 15, -- prefix used when a buffer is de-duplicated
        --tab_size = 18,
        diagnostics = 'nvim_lsp',
        diagnostics_indicator = function(count, _, _, _)
          return ' (' .. count .. ')'
        end,
        offsets = { { filetype = 'NvimTree', text = 'File Explorer', text_align = 'left' } },
        show_buffer_close_icons = false,
        show_close_icon = false,
        show_tab_indicators = true,
        always_show_bufferline = true,
        sort_by = 'extension',
      },
    },
  },
  {
    'nvim-tree/nvim-web-devicons',
    dependencies = { 'DaikyXendo/nvim-material-icon' },
    config = function()
      require('nvim-web-devicons').setup({
        override = require('nvim-material-icon').get_icons(),
      })
    end,
  },
}
