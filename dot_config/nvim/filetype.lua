vim.filetype.add({
  extension = {
    -- helm
    gotmpl = 'helm',
  },
  pattern = {
    -- Ansible
    ['.*/defaults/.*%.ya?ml'] = 'yaml.ansible',
    ['.*/host_vars/.*%.ya?ml'] = 'yaml.ansible',
    ['.*/group_vars/.*%.ya?ml'] = 'yaml.ansible',
    ['.*/group_vars/.*/.*%.ya?ml'] = 'yaml.ansible',
    ['.*/playbook.*%.ya?ml'] = 'yaml.ansible',
    ['.*/playbooks/.*%.ya?ml'] = 'yaml.ansible',
    ['.*/roles/.*/tasks/.*%.ya?ml'] = 'yaml.ansible',
    ['.*/roles/.*/handlers/.*%.ya?ml'] = 'yaml.ansible',
    ['.*/tasks/.*%.ya?ml'] = 'yaml.ansible',
    ['.*/molecule/.*%.ya?ml'] = 'yaml.ansible',

    -- docker-compose
    ['compose.*%.ya?ml'] = 'yaml.docker-compose',
    ['docker%-compose.*%.ya?ml'] = 'yaml.docker-compose',

    -- helm
    ['.*/templates/.*%.ya?ml'] = 'helm',
    ['.*/templates/.*%.tpl'] = 'helm',
    ['.*/templates/.*%.txt'] = 'helm',
    ['helmfile.*%.ya?ml'] = 'helm',
  },
})
