require('dapui').setup()
local dap, dapui = require 'dap', require 'dapui'
dap.listeners.before.attach.dapui_config = function()
  dapui.open()
end
dap.listeners.before.launch.dapui_config = function()
  dapui.open()
end
-- dap.listeners.before.event_terminated.dapui_config = function()
--   dapui.close()
-- end
-- dap.listeners.before.event_exited.dapui_config = function()
--   dapui.close()
-- end

-- DAP Golang
require('dap-go').setup {
  delve = {
    -- the path to the executable dlv which will be used for debugging.
    -- by default, this is the "dlv" executable on your PATH.
    path = 'dlv',
    -- time to wait for delve to initialize the debug session.
    -- default to 20 seconds
    initialize_timeout_sec = 20,
    -- a string that defines the port to start delve debugger.
    -- default to string "${port}" which instructs nvim-dap
    -- to start the process in a random available port
    port = '4000',
    -- additional args to pass to dlv
    args = {},
    -- the build flags that are passed to delve.
    -- defaults to empty string, but can be used to provide flags
    -- such as "-tags=unit" to make sure the test suite is
    -- compiled during debugging, for example.
    -- passing build flags using args is ineffective, as those are
    -- ignored by delve in dap mode.
    build_flags = '',
    -- whether the dlv process to be created detached or not. there is
    -- an issue on Windows where this needs to be set to false
    -- otherwise the dlv server creation will fail.
    detached = true,
  },
}

-- DAP CODELLDB
dap.adapters.codelldb = {
  type = 'executable',
  command = os.getenv 'HOME' .. '/.vscode/extensions/vadimcn.vscode-lldb-1.11.1/adapter/codelldb',
}
-- DAP c files load codelldb
dap.configurations.c = {
  {
    name = 'Launch file',
    type = 'codelldb',
    request = 'launch',
    program = function()
      return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
    end,
    cwd = '${workspaceFolder}',
    stopOnEntry = false,
  },
}
dap.configurations.zig = {
  {
    name = 'Launch file',
    type = 'codelldb',
    request = 'launch',
    program = function()
      vim.fn.system('zig build-exe ' .. vim.fn.expand '%:p' .. ' --name ' .. vim.fn.expand '%:r')
      return '${workspaceFolder}/' .. '${fileBasenameNoExtension}'
    end,
    cwd = '${workspaceFolder}',
    stopOnEntry = false,
  },
  {
    name = 'Launch zig project',
    type = 'codelldb',
    request = 'launch',
    program = function()
      vim.fn.system 'zig build'
      return '${workspaceFolder}/zig-out/bin/${workspaceFolderBasename}'
    end,
    cwd = '${workspaceFolder}',
    stopOnEntry = false,
  },
}

-- DAP PHP
dap.adapters.php = {
  type = 'executable',
  command = 'node',
  args = { os.getenv 'HOME' .. '/vscode-php-debug/out/phpDebug.js' },
}

dap.configurations.php = {
  {
    type = 'php',
    request = 'launch',
    name = 'Listen for Xdebug',
    port = 9003,
    pathMappings = {
      ['/var/www/html/'] = vim.fn.getcwd() .. '/',
    },
  },
}

-- DAP VSCODE JS
require('dap-vscode-js').setup {
  -- node_path = "node", -- Path of node executable. Defaults to $NODE_PATH, and then "node"
  debugger_path = os.getenv 'HOME' .. '/vscode-js-debug/', -- Path to vscode-js-debug installation.
  -- debugger_cmd = { "js-debug-adapter" }, -- Command to use to launch the debug server. Takes precedence over `node_path` and `debugger_path`.
  adapters = { 'pwa-node', 'pwa-chrome', 'pwa-msedge', 'node-terminal', 'pwa-extensionHost' }, -- which adapters to register in nvim-dap
  -- log_file_path = "(stdpath cache)/dap_vscode_js.log" -- Path for file logging
  -- log_file_level = false -- Logging level for output to file. Set to false to disable file logging.
  -- log_console_level = vim.log.levels.ERROR -- Logging level for output to console. Set to false to disable console output.
}

for _, language in ipairs { 'typescript', 'javascript' } do
  require('dap').configurations[language] = {
    {
      type = 'pwa-node',
      request = 'launch',
      name = 'Launch file',
      program = '${file}',
      cwd = '${workspaceFolder}',
    },
    {
      type = 'pwa-node',
      request = 'attach',
      name = 'Attach',
      processId = require('dap.utils').pick_process,
      cwd = '${workspaceFolder}',
    },
  }
end

--RUSTACEAN VIM
vim.g.rustaceanvim = {
  -- Plugin configuration
  tools = {},
  -- LSP configuration
  server = {
    on_attach = function(client, bufnr)
      RustaceanKeymap()
    end,
    default_settings = {
      -- rust-analyzer language server configuration
      ['rust-analyzer'] = {},
    },
  },
  -- DAP configuration
  dap = {
    -- autoload_configurations = true,
  },
}
