-- Match trailing spaces
-- vim.cmd([[match ErrorMsg '\s\+$']])
vim.cmd.match({ 'ErrorMsg', [['\s\+$']] })
