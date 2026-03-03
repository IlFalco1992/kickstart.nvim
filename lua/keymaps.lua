vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous [D]iagnostic message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next [D]iagnostic message' })
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Show diagnostic [E]rror messages' })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

vim.keymap.set('n', '<C-d>', '<C-d>zz')
vim.keymap.set('n', '<C-u>', '<C-u>zz')

-- DAP
local dap = require 'dap'
local permanent_breakpoints = require 'persistent-breakpoints.api'
require('persistent-breakpoints').setup {
  load_breakpoints_event = { 'BufReadPost' },
}
vim.keymap.set('n', '<leader>b', permanent_breakpoints.toggle_breakpoint, { desc = 'DAP: [b]reakpoint' })
vim.keymap.set('n', '<leader>B', function()
  permanent_breakpoints.set_conditional_breakpoint()
end, { desc = 'DAP: Conditional [B]reakpoint' })
vim.keymap.set('n', '<leader>dC', permanent_breakpoints.clear_all_breakpoints, { desc = 'DAP: [C]lear all breakpoints' })
vim.keymap.set('n', '<leader>dc', dap.continue, { desc = 'DAP: [c]ontinue' })
RustaceanKeymap = function()
  vim.keymap.set('n', '<leader>dc', function()
    if require('dap').session() == nil then
      vim.cmd.RustLsp 'debuggables'
    else
      require('dap').continue()
    end
  end, { desc = 'DAP: [c]ontinue' })
end
vim.keymap.set('n', '<leader>dt', dap.terminate, { desc = 'DAP: [t]erminate' })
vim.keymap.set('n', '<leader>di', dap.step_into, { desc = 'DAP: Step [i]nto' })
vim.keymap.set('n', '<leader>do', dap.step_over, { desc = 'DAP: Step [o]ver' })
vim.keymap.set('n', '<leader>dO', dap.step_out, { desc = 'DAP: Step [O]ut' })
vim.keymap.set('n', '<leader>dr', dap.run_to_cursor, { desc = 'DAP: [r]un to cursor' })

-- DAP UI
vim.keymap.set('n', '<leader>du', require('dapui').toggle, { desc = 'DAP: Show dap-ui' })

-- SPELL CHECK
vim.opt.spelllang = 'en_us'
vim.opt.spell = true

-- 5 lines jumps
vim.keymap.set('n', '<M-h>', '5h', { desc = '5 left' })
vim.keymap.set('n', '<M-j>', '5j', { desc = '5 down' })
vim.keymap.set('n', '<M-k>', '5k', { desc = '5 up' })
vim.keymap.set('n', '<M-l>', '5l', { desc = '5 right' })
vim.keymap.set('n', '<M-e>', '5<C-e>', { desc = '5 scroll up' })
vim.keymap.set('n', '<M-y>', '5<C-y>', { desc = '5 scroll down' })

-- AERIAL
vim.keymap.set('n', '<leader>a', function()
  require('aerial').toggle { direction = 'left', focus = false }
end, { desc = '[a]erial toggle' })
require('aerial').setup {
  -- optionally use on_attach to set keymaps when aerial has attached to a buffer
  on_attach = function(bufnr)
    -- Jump forwards/backwards with '{' and '}'
    vim.keymap.set('n', '{', '<cmd>AerialPrev<CR>', { buffer = bufnr })
    vim.keymap.set('n', '}', '<cmd>AerialNext<CR>', { buffer = bufnr })
  end,
}

vim.keymap.set('n', '<leader><leader>', BufferSearcher, { desc = '[ ] Find existing buffers' })

-- TELESCOPE
local builtin = require 'telescope.builtin'
vim.keymap.set('n', '<leader>sh', builtin.help_tags, { desc = '[S]earch [H]elp' })
vim.keymap.set('n', '<leader>sk', builtin.keymaps, { desc = '[S]earch [K]eymaps' })
vim.keymap.set('n', '<leader>sf', function()
  builtin.find_files { hidden = true }
end, { desc = '[S]earch [F]iles' })
vim.keymap.set('n', '<leader>sv', builtin.git_files, { desc = '[S]earch [V]ersion Control' })
vim.keymap.set('n', '<leader>ss', builtin.builtin, { desc = '[S]earch [S]elect Telescope' })
vim.keymap.set('n', '<leader>sw', builtin.grep_string, { desc = '[S]earch current [W]ord' })
vim.keymap.set('v', '<leader>*', function()
  local current_clipboard_content = vim.fn.getreg '"'
  vim.cmd 'noau normal! "vy'
  local text = vim.fn.getreg 'v'
  vim.fn.setreg('v', {})
  vim.fn.setreg('"', current_clipboard_content)
  text = string.gsub(text, '\n', '')
  if #text == 0 then
    text = ''
  end
  builtin.live_grep { default_text = EscapeRegex(text) }
end, { desc = '[S]earch current text in visual mode' })
vim.keymap.set('n', '<leader>sg', builtin.live_grep, { desc = '[S]earch by [G]rep' })
vim.keymap.set('n', '<leader>sd', builtin.diagnostics, { desc = '[S]earch [D]iagnostics' })
vim.keymap.set('n', '<leader>sr', builtin.resume, { desc = '[S]earch [R]esume' })
vim.keymap.set('n', '<leader>s.', builtin.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
vim.keymap.set('n', '<leader>j', builtin.jumplist, { desc = '[J] Jumplist' })

-- Slightly advanced example of overriding default behavior and theme
vim.keymap.set('n', '<leader>/', function()
  -- You can pass additional configuration to Telescope to change the theme, layout, etc.
  builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
    winblend = 10,
    previewer = false,
  })
end, { desc = '[/] Fuzzily search in current buffer' })

-- It's also possible to pass additional configuration options.
--  See `:help telescope.builtin.live_grep()` for information about particular keys
vim.keymap.set('n', '<leader>s/', function()
  builtin.live_grep {
    grep_open_files = true,
    prompt_title = 'Live Grep in Open Files',
  }
end, { desc = '[S]earch [/] in Open Files' })

-- LSP-CONFIG
function LspKeymap(event)
  local map = function(keys, func, desc)
    vim.keymap.set('n', keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
  end

  -- Jump to the definition of the word under your cursor.
  --  This is where a variable was first declared, or where a function is defined, etc.
  --  To jump back, press <C-t>.
  map('gd', builtin.lsp_definitions, '[G]oto [D]efinition')

  -- Find references for the word under your cursor.
  map('gr', builtin.lsp_references, '[G]oto [R]eferences')

  -- Jump to the implementation of the word under your cursor.
  --  Useful when your language has ways of declaring types without an actual implementation.
  map('gI', builtin.lsp_implementations, '[G]oto [I]mplementation')

  -- Jump to the type of the word under your cursor.
  --  Useful when you're not sure what type a variable is and you want to see
  --  the definition of its *type*, not where it was *defined*.
  map('<leader>D', builtin.lsp_type_definitions, 'Type [D]efinition')

  -- Fuzzy find all the symbols in your current document.
  --  Symbols are things like variables, functions, types, etc.
  map('<leader>ds', builtin.lsp_document_symbols, '[D]ocument [S]ymbols')

  -- Fuzzy find all the symbols in your current workspace.
  --  Similar to document symbols, except searches over your entire project.
  map('<leader>ws', builtin.lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')

  -- Rename the variable under your cursor.
  --  Most Language Servers support renaming across files, etc.
  map('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')

  -- Execute a code action, usually your cursor needs to be on top of an error
  -- or a suggestion from your LSP for this to activate.
  map('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')

  -- Opens a popup that displays documentation about the word under your cursor
  --  See `:help K` for why this keymap.
  map('K', vim.lsp.buf.hover, 'Hover Documentation')

  -- WARN: This is not Goto Definition, this is Goto Declaration.
  --  For example, in C this would take you to the header.
  map('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')

  -- Show the signature of the function call you're currently on.
  map('<leader>h', vim.lsp.buf.signature_help, 'Signature [H]elp')
end
