return {
  cmd = { 'ansible-language-server', '--stdio' },
  settings = {
    ansible = {
      python = { interpreterPath = vim.fn.exepath('python3') },
      ansible = { path = vim.fn.exepath('ansible') },
      executionEnvironment = { enabled = false },
      validation = {
        enabled = true,
        lint = {
          enabled = true,
          path = vim.fn.exepath('ansible-lint'),
        },
      },
    },
  },
  filetypes = { 'yaml.ansible' },
  root_markers = { 'ansible.cfg', '.ansible-lint', '.git' },
}
