return {
  {
    'rebelot/kanagawa.nvim',
    lazy = false,
    opts = {
      dimInactive = true, -- dim inactive window `:h hl-NormalNC`
      colors = { theme = { all = { ui = { bg_gutter = 'none' } } } },
      overrides = function(colors)
        local theme = colors.theme
        return {
          -- completion menu
          Pmenu = { fg = theme.ui.shade0, bg = theme.ui.bg_p1 }, -- add `blend = vim.o.pumblend` to enable transparency
          PmenuSel = { fg = 'NONE', bg = theme.ui.bg_p2 },
          PmenuSbar = { bg = theme.ui.bg_m1 },
          PmenuThumb = { bg = theme.ui.bg_p2 },
          -- telescope window
          TelescopeTitle = { fg = theme.ui.special, bold = true },
          TelescopePromptNormal = { bg = theme.ui.bg_p1 },
          TelescopePromptBorder = { fg = theme.ui.bg_p1, bg = theme.ui.bg_p1 },
          TelescopeResultsNormal = { fg = theme.ui.fg_dim, bg = theme.ui.bg_m1 },
          TelescopeResultsBorder = { fg = theme.ui.bg_m1, bg = theme.ui.bg_m1 },
          TelescopePreviewNormal = { bg = theme.ui.bg_dim },
          TelescopePreviewBorder = { bg = theme.ui.bg_dim, fg = theme.ui.bg_dim },
        }
      end,
      theme = 'dragon',
      background = {
        dark = 'dragon',
        light = 'lotus',
      },
    },
    config = function(_, opts)
      require('kanagawa').setup(opts)
      vim.cmd('colorscheme kanagawa')
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
            return ' '
          elseif trunc_width and trunc_len and win_width < trunc_width and #str > trunc_len then
            return str:sub(1, trunc_len) .. (no_ellipsis and '' or '…')
          else
            return str
          end
        end
      end

      local function diff_sources()
        local gitsigns = vim.b.gitsigns_status_dict
        if gitsigns then
          return {
            added = gitsigns.added,
            modified = gitsigns.changed,
            removed = gitsigns.removed,
          }
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
            { 'b:gitsigns_head', icon = '', fmt = trunc(1000, 20, 80, false) },
            { 'diff', source = diff_sources },
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
    'Bekaboo/dropbar.nvim',
    event = 'VeryLazy',
  },
  { 'nvim-tree/nvim-web-devicons' },
}
