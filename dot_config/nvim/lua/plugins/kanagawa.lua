require('kanagawa').setup({
  dimInactive = true,
  colors = { theme = { all = { ui = { bg_gutter = 'none' } } } },
  overrides = function(colors)
    local theme = colors.theme
    return {
      -- completion menu
      Pmenu = { fg = theme.ui.shade0, bg = theme.ui.bg_p1 },
      PmenuSbar = { bg = theme.ui.bg_m1 },
      PmenuSel = { fg = 'NONE', bg = theme.ui.bg_p2 },
      PmenuThumb = { bg = theme.ui.bg_p1 },
    }
  end,
})

vim.cmd.colorscheme('kanagawa-dragon')
