local function generate_harpoon_picker()
  local file_paths = {}
  for _, item in ipairs(require('harpoon'):list().items) do
    table.insert(file_paths, {
      text = item.value,
      file = item.value,
    })
  end
  return file_paths
end

return {
  'ThePrimeagen/harpoon',
  branch = 'harpoon2',
  dependencies = { 'nvim-lua/plenary.nvim' },
  opts = {
    settings = { save_on_toggle = true },
  },
  config = function(_, opts)
    local harpoon = require('harpoon')
    harpoon:setup(opts)

    harpoon:extend({
      UI_CREATE = function(cx)
        vim.keymap.set('n', '<C-v>', function()
          harpoon.ui:select_menu_item({ vsplit = true })
        end, { buffer = cx.bufnr })

        vim.keymap.set('n', '<C-s>', function()
          harpoon.ui:select_menu_item({ split = true })
        end, { buffer = cx.bufnr })

        vim.keymap.set('n', '<C-t>', function()
          harpoon.ui:select_menu_item({ tabedit = true })
        end, { buffer = cx.bufnr })
      end,
    })
  end,
  keys = {
    {
      '<leader>a',
      function()
        require('harpoon'):list():add()
      end,
      desc = 'Add to Harpoon',
    },
    {
      '<leader>l',
      function()
        Snacks.picker({
          finder = generate_harpoon_picker,
          win = {
            input = {
              keys = {
                ['<C-x>'] = { 'harpoon_delete', mode = { 'i' } },
              },
            },
          },
          actions = {
            harpoon_delete = function(picker, item)
              local to_remove = item or picker:selected()
              table.remove(require('harpoon'):list().items, to_remove.idx)
              picker:find({ refresh = true })
            end,
          },
        })
      end,
      desc = 'Harpoon picker',
    },
  },
}
