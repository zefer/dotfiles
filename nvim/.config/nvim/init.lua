-- NOTE: needs to be set before plugins are loaded so they use correct leader.
vim.g.mapleader = ','
vim.g.maplocalleader = ','

vim.cmd('source ~/.vimrc')

-- SETTINGS
-- --------

vim.o.spelllang = "en_gb"
vim.opt.showcmd = true -- display incomplete commands
vim.opt.number = true -- show line numbers

vim.opt.background = 'dark'
vim.cmd.colorscheme('molokai')

-- Cursor line.
vim.o.cursorline = true
vim.api.nvim_set_hl(0, 'CursorLine', { bg = '#252525' })

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

-- Searching.
vim.opt.hlsearch = true   -- highlight matches
vim.opt.incsearch = true  -- hightlight as we type
vim.opt.ignorecase = true -- searches are case insensitive...
vim.opt.smartcase = true  -- ... unless they contain at least one capital letter

-- Code folding.
vim.opt.foldmethod = 'indent'
vim.opt.foldlevelstart = 20
vim.keymap.set('n', '<Space>', 'za')

-- Status line.
vim.opt.laststatus = 2
vim.opt.statusline = "[%n] %f [%{&ft}] %m %r%=%-0(%l,%v [%P]%)"

-- Colour column.
vim.opt.colorcolumn = "80"  -- Show column at position 80
vim.api.nvim_set_hl(0, 'ColorColumn', { ctermbg = 234, bg = '#3E3D32' })  -- Style the column

vim.opt.exrc = true   -- enable per-directory .[n]vimrc files
vim.opt.secure = true -- disable unsafe commands in local .[n]vimrc files

-- FUNCTIONS
-- ---------
-- TODO: consider moving to a separate file/modules.

-- Toggle word wrap
local function toggle_wrap()
  if vim.wo.wrap then
    print("Wrap OFFs")
    vim.wo.wrap = false
  else
    print("Wrap ONs")
    vim.wo.wrap = true
    vim.wo.linebreak = true
    vim.wo.list = false
    vim.opt.display:append('lastline')
  end
end

-- Toggle colorcolumn
local function toggle_colorcolumn()
  if vim.wo.colorcolumn == "80" then
    vim.wo.colorcolumn = "0"
  else
    vim.wo.colorcolumn = "80"
  end
end

-- KEY MAPPINGS
-- ------------

-- Local functions.
vim.keymap.set('n', '<Leader>w', toggle_wrap, { silent = true, desc = 'Toggle word wrap' })
vim.keymap.set('n', '<Leader>8', toggle_colorcolumn, { silent = true, desc = 'Toggle colorcolumn' })

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

-- Move to next/previous displayed lines rather than physical lines (for wordwrap).
vim.keymap.set('n', 'j', 'gj')
vim.keymap.set('n', 'k', 'gk')

-- Reload config.
vim.keymap.set('n', '<Leader>so', function()
  vim.cmd('source $MYVIMRC')
  print('Config reloaded!')
end, { desc = 'Reload config' })

-- Write with sudo, for read-only files.
vim.keymap.set('c', 'w!!', '%!sudo tee > /dev/null %')

-- PLUGINS
-- -------

-- AUTOCOMMANDS
-- ------------

local augroup = vim.api.nvim_create_augroup('UserConfig', { clear = true })

vim.api.nvim_create_autocmd({'BufRead', 'BufNewFile'}, {
  pattern = '*.go',
  group = augroup,
  command = 'setlocal noexpandtab'
})

vim.api.nvim_create_autocmd({'BufRead', 'BufNewFile'}, {
  pattern = '*.svelte',
  group = augroup,
  command = 'setlocal filetype=html'
})

vim.api.nvim_create_autocmd('FileType', {
  pattern = {'text', 'markdown', 'gitcommit'},
  group = augroup,
  command = 'setlocal spell'
})
