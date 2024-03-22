local augroup = vim.api.nvim_create_augroup('filetypedetect', { clear = false })

vim.api.nvim_create_autocmd({ 'BufNewFile', 'BufRead' }, {
  pattern = '*.tmpl',
  callback = function()
    if vim.fn.search('{{.+}}', 'nw') then
      vim.opt_local.filetype = 'gotmpl'
    end
  end,
  group = augroup,
})
