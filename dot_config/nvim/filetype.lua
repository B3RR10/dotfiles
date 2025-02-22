vim.filetype.add({
  extension = {
    gotmpl = 'helm',
  },
  pattern = {
    ['compose.*%.ya?ml'] = 'yaml.docker-compose',
    ['docker%-compose.*%.ya?ml'] = 'yaml.docker-compose',

    ['.*/templates/.*%.ya?ml'] = 'helm',
    ['.*/templates/.*%.tpl'] = 'helm',
    ['.*/templates/.*%.txt'] = 'helm',
    ['helmfile.*%.ya?ml'] = 'helm',
  },
})
