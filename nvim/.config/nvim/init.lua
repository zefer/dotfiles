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

-- Don't create backup files in these directories.
vim.opt.backupskip:append({
  '/tmp/*',
  '/private/tmp/*'
})

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

local function strip_trailing_whitespace()
  local save_cursor = vim.api.nvim_win_get_cursor(0)
  vim.api.nvim_command('keepjumps keeppatterns %s/\\s\\+$//e')
  vim.api.nvim_win_set_cursor(0, save_cursor)
end

-- KEY MAPPINGS
-- ------------

-- Local functions.
vim.keymap.set('n', '<Leader>w', toggle_wrap, { silent = true, desc = 'Toggle word wrap' })
vim.keymap.set('n', '<Leader>8', toggle_colorcolumn, { silent = true, desc = 'Toggle colorcolumn' })
vim.keymap.set('n', '<Leader>5', strip_trailing_whitespace, { silent = true, desc = 'Strip trailing whitespace' })

vim.keymap.set('i', 'jj', '<ESC>')

-- FZF mappings
vim.keymap.set('n', '<Leader>f', ':Files<CR>', { desc = 'Find files' })
vim.keymap.set('n', '<Leader>b', ':Buffers<CR>', { desc = 'Find buffers' })

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

-- Fix my common fat-fingered command typos.
vim.api.nvim_create_user_command('W', 'w', {})
vim.api.nvim_create_user_command('Wq', 'wq', {})
vim.api.nvim_create_user_command('Wqa', 'wqa', {})

-- PLUGINS
-- -------

-- [[ Install `lazy.nvim` plugin manager ]]
-- See `:help lazy.nvim.txt` or https://github.com/folke/lazy.nvim
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  local out = vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
  if vim.v.shell_error ~= 0 then
    error('Error cloning lazy.nvim:\n' .. out)
  end
end

---@type vim.Option
local rtp = vim.opt.rtp
rtp:prepend(lazypath)

-- Setup lazy.nvim
require("lazy").setup({
  'tpope/vim-fugitive',         -- Git integration
  'tpope/vim-unimpaired',       -- Bracket mappings
  'tpope/vim-commentary',       -- Comment/uncomment
  'tpope/vim-surround',         -- Surround text objects
  'tpope/vim-endwise',          -- Auto-end structures
  'tpope/vim-vinegar',          -- Better netrw
  'tpope/vim-rhubarb',          -- GitHub integration
  'tpope/vim-rails',            -- Rails proj helpers
  'tpope/vim-rake',             -- Ruby proj helpers
  'christoomey/vim-tmux-navigator', -- Tmux integration
  'airblade/vim-gitgutter',     -- Git and version control
  'vim-scripts/VimCompletesMe', -- Completion
  'tomasr/molokai',             -- Colorscheme

  {
    'junegunn/fzf.vim',
    dependencies = { 'junegunn/fzf' },
    config = function()
      -- FZF configuration.
      vim.g.fzf_action = {
        ['ctrl-t'] = 'tab split',
        ['ctrl-s'] = 'split',
        ['ctrl-v'] = 'vsplit'
      }
    end
  },

  -- Search
  {
    'mileszs/ack.vim',
    config = function()
      -- Use ag if available (from your vimrc)
      if vim.fn.executable('ag') == 1 then
        vim.g.ackprg = 'ag --vimgrep'
      end
    end
  },
}, {
  checker = { enabled = false }, -- Don't auto-check for updates
})

vim.cmd.colorscheme('molokai')

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
