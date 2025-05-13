---@type vim.lsp.ClientConfig
return {
  cmd = { 'texlab' },
  filetypes = { 'tex', 'plaintex', 'bib', 'cls', 'sty' },
  root_markers = { '.latexmkrc', '.texlabroot', 'texlabroot', 'Tectonic.toml', '.git' },
  settings = {
    texlab = {
      rootDirectory = nil,
      build = {
        executable = vim.fn.exepath('latexmk'),
        -- TODO: Move this to a .latexmkrc file on the project...
        args = {
          '-pdf',
          '-interaction=nonstopmode',
          '-output-directory=build',
          '-synctex=1',
          '-shell-escape',
          '%f',
        },
        onSave = true,
      },
      chktex = { onOpenAndSave = true },
      formatterLineLength = 120,
    },
  },
}
