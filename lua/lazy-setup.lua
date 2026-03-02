local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
end ---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)

require('lazy').setup({
  'tpope/vim-sleuth', -- Detect tabstop and shiftwidth automatically

  { 'numToStr/Comment.nvim', opts = {} },

  require 'lazy-plugins.gitsigns',

  require 'lazy-plugins.which-key',

  require 'lazy-plugins.telescope',

  require 'lazy-plugins.lspconfig',

  require 'lazy-plugins.conform',

  require 'lazy-plugins.nvim-cmp',

  require 'lazy-plugins.theme',

  -- Highlight todo, notes, etc in comments
  { 'folke/todo-comments.nvim', event = 'VimEnter', dependencies = { 'nvim-lua/plenary.nvim' }, opts = { signs = false } },

  require 'lazy-plugins.mini',
  require 'lazy-plugins.treesitter',

  { 'tpope/vim-fugitive' },
  { 'mfussenegger/nvim-dap' },
  { 'rcarriga/nvim-dap-ui', dependencies = { 'mfussenegger/nvim-dap', 'nvim-neotest/nvim-nio' } },
  { 'leoluz/nvim-dap-go' },
  { 'theHamsta/nvim-dap-virtual-text' },
  { 'github/copilot.vim' },
  { 'Weissle/persistent-breakpoints.nvim' },
  require 'lazy-plugins.auto-session',
  {
    'stevearc/aerial.nvim',
    opts = {},
    -- Optional dependencies
    dependencies = {
      'nvim-treesitter/nvim-treesitter',
      'nvim-tree/nvim-web-devicons',
    },
  },
  --  { 'jiangmiao/auto-pairs' },
  {
    'stevearc/oil.nvim',
    opts = {},
    -- Optional dependencies
    dependencies = { 'nvim-tree/nvim-web-devicons' },
  },
  {
    'mrcjkb/rustaceanvim',
    version = '^4', -- Recommended
    lazy = false, -- This plugin is already lazy
  },
  { 'kmonad/kmonad-vim' },
  { 'mxsdev/nvim-dap-vscode-js' },
  { 'nvim-treesitter/nvim-treesitter-context' },
  { 'akinsho/git-conflict.nvim', version = '*', config = true },
}, {
  ui = {
    -- If you are using a Nerd Font: set icons to an empty table which will use the
    -- default lazy.nvim defined Nerd Font icons, otherwise define a unicode icons table
    icons = vim.g.have_nerd_font and {} or {
      cmd = '⌘',
      config = '🛠',
      event = '📅',
      ft = '📂',
      init = '⚙',
      keys = '🗝',
      plugin = '🔌',
      runtime = '💻',
      require = '🌙',
      source = '📄',
      start = '🚀',
      task = '📌',
      lazy = '💤 ',
    },
  },
})
