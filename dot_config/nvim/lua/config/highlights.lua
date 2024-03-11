-- Highlight column 101 to warn for longer lines
vim.cmd('highlight OverLength ctermbg=red ctermfg=white guibg=#870000')
vim.cmd([[let w:m2=matchadd('OverLength', '\%101v', -1)]])

-- Match trailing spaces
vim.cmd([[match ErrorMsg '\s\+$']])

-- Hide ~ in blank lines
vim.cmd([[hi NonText guifg=bg]])
vim.cmd([[hi VertSplit guifg=black]])
