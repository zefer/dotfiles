-- NOTE: needs to be set before plugins are loaded so they use correct leader.
vim.g.mapleader = ','
vim.g.maplocalleader = ','

vim.cmd('source ~/.vimrc')

-- SETTINGS
-- --------

vim.o.spelllang = "en_gb"

vim.o.list = true
vim.opt.listchars = {
  tab = '» ', trail = '·', nbsp = '␣', extends = '>', precedes = '<'
}

-- Whitespace.
vim.opt.wrap = false     -- don't wrap lines
vim.opt.scrolloff = 3    -- show context above/below cursorline
vim.opt.tabstop = 2      -- a tab is two spaces
vim.opt.shiftwidth = 2   -- a tab is two spaces
vim.opt.expandtab = true -- use spaces, not tabs
vim.opt.backspace = {'indent', 'eol', 'start'}  -- backspace through everything in insert mode

-- Code folding.
vim.opt.foldmethod = 'indent'
vim.opt.foldlevelstart = 20
vim.keymap.set('n', '<Space>', 'za')

-- KEY MAPPINGS
-- ------------

vim.keymap.set('i', 'jj', '<ESC>')

vim.keymap.set('n', '<Leader>a', ':Ack!<space>')
vim.keymap.set('n', '<Leader>\'', ':s/"/\'/g<CR>')
vim.keymap.set('n', '<Leader>"', ':s/\'/"/g<CR>')
vim.keymap.set('n', '<Leader>l', ':set invnumber<CR>')
vim.keymap.set('n', '<Leader>gf', ':!gofmt -w "%"<CR>')
vim.keymap.set('n', '<Leader>tf', ':!npm run lint -- --fix --files %<CR>')
vim.keymap.set('n', '<Leader>gr', ':!go run %<CR>')

-- Clear the search buffer with <return>.
vim.keymap.set('n', '<CR>', '<cmd>nohlsearch<CR>')

-- Easier navigation between split windows
vim.keymap.set('n', '<C-j>', '<C-w>j')
vim.keymap.set('n', '<C-k>', '<C-w>k')
vim.keymap.set('n', '<C-h>', '<C-w>h')
vim.keymap.set('n', '<C-l>', '<C-w>l')

-- Reload config.
vim.keymap.set('n', '<Leader>so', function()
  vim.cmd('source $MYVIMRC')
  print('Config reloaded!')
end, { desc = 'Reload config' })

-- PLUGINS
-- -------

-- FUNCTIONS
-- ---------

-- AUTOCOMMANDS
-- ------------
