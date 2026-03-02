require 'options'
-- [[ Basic Autocommands ]]
--  See `:help lua-guide-autocommands`

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

require 'lazy-setup'

require('nvim-dap-virtual-text').setup()

require 'dap-setup'

-- OIL
require('oil').setup()

require 'helpers'

vim.filetype.add {
  extension = {
    gotmpl = 'gotmpl',
  },
  pattern = {
    ['.*/templates/.*%.html'] = 'gotmpl',
    ['.*/templates/.*%.tmpl'] = 'gotmpl',
    ['.*/templates/.*%.tpl'] = 'gotmpl',
    ['.*/templates/.*%.gohtml'] = 'gotmpl',
  },
}
require 'keymaps'
