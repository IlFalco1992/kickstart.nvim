return {
  'rmagatti/auto-session',
  lazy = false,
  dependencies = {
    'nvim-telescope/telescope.nvim',
  },
  keys = {
    -- Will use Telescope if installed or a vim.ui.select picker otherwise
    { '<leader>wr', '<cmd>AutoSession search<CR>', desc = 'Session search' },
    { '<leader>ws', '<cmd>AutoSession save<CR>', desc = 'Save session' },
    { '<leader>wa', '<cmd>AutoSession toggle<CR>', desc = 'Toggle autosave' },
  },
  config = function()
    require('auto-session').setup {
      log_level = 'error',
      auto_session_suppress_dirs = { '~/', '~/Projects', '~/Downloads', '/' },
      pre_save_cmds = {
        function()
          require('dapui').close()
          require('aerial').close()
        end,
      },
      session_lens = {
        -- If load_on_setup is false, make sure you use `:SessionSearch` to open the picker as it will initialize everything first
        load_on_setup = true,
        theme_conf = { border = true },
        previewer = false,
      },
    }
  end,
}
