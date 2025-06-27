-- NOTE: needs to be set before plugins are loaded so they use correct leader.
vim.g.mapleader = ','
vim.g.maplocalleader = ','


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

-- Use ripgrep for :grep command
vim.opt.grepprg = 'rg --vimgrep --smart-case --follow'

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

-- FZF and search mappings
vim.keymap.set('n', '<Leader>f', ':Files<CR>', { desc = 'Find files' })
vim.keymap.set('n', '<Leader>b', ':Buffers<CR>', { desc = 'Find buffers' })
vim.keymap.set('n', '<Leader>a', ':Rg ', { desc = 'Search with ripgrep' })
-- TODO: change mapping and check :cw behaviour.
vim.keymap.set('n', '<Leader>qa', ':grep ', { desc = 'Search to quickfix' })
vim.keymap.set('n', '<Leader>s', ':Rg<CR>', { desc = 'Search current word' })
vim.keymap.set('n', '<Leader>t', ':Tags<CR>', { desc = 'Find tags' })

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
  'tomasr/molokai',             -- Colorscheme

  -- LSP and completion
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      { 'mason-org/mason.nvim', opts = {} },
      'mason-org/mason-lspconfig.nvim',
      'WhoIsSethDaniel/mason-tool-installer.nvim',
      -- Useful status updates for LSP.
      { 'j-hui/fidget.nvim', opts = {} },
      -- Allows extra capabilities provided by blink.cmp.
      {
        'saghen/blink.cmp',
        version = '1.*',
      },
    },
  },

  -- TODO: replace MiniBufExplorer?
  {
    'fholgado/minibufexpl.vim',
    config = function()
      vim.g.miniBufExplStatusLineText = '%='
      vim.g.miniBufExplBuffersNeeded = 0
    end
  },

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

}, {
  checker = { enabled = false }, -- Don't auto-check for updates
})

vim.cmd.colorscheme('molokai')

-- LSP CONFIGURATION
-- -----------------

-- Setup mason
require('mason').setup()
require('mason-lspconfig').setup({
  ensure_installed = { 'gopls', 'ruby_lsp', 'lua_ls' },
})

-- LSP keymaps and configuration
local on_attach = function(client, bufnr)
  local opts = { buffer = bufnr, silent = true }
  -- TODO: check these.
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
  vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
  vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, opts)
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
  vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
  vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)

  -- Format on save for Go
  if client.supports_method('textDocument/formatting') then
    vim.api.nvim_create_autocmd('BufWritePre', {
      buffer = bufnr,
      callback = function()
        vim.lsp.buf.format({ bufnr = bufnr })
      end,
    })
  end
end

-- Configure LSP servers
local lspconfig = require('lspconfig')
local capabilities = require('blink.cmp').get_lsp_capabilities()

lspconfig.gopls.setup({
  capabilities = capabilities,
  on_attach = on_attach,
  settings = {
    gopls = {
      gofumpt = true,
    },
  },
})

lspconfig.ruby_lsp.setup({
  capabilities = capabilities,
  on_attach = on_attach,
})

lspconfig.lua_ls.setup({
  capabilities = capabilities,
  on_attach = on_attach,
  settings = {
    Lua = {
      diagnostics = {
        globals = { 'vim' },
      },
    },
  },
})

-- COMPLETION CONFIGURATION
-- ------------------------

require('blink.cmp').setup({
  keymap = {
    preset = 'default',
    ['<Tab>'] = { 'select_next', 'fallback' },
    ['<S-Tab>'] = { 'select_prev', 'fallback' },
    ['<CR>'] = { 'accept', 'fallback' },
    ['<C-Space>'] = { 'show', 'show_documentation', 'hide_documentation' },
    ['<C-e>'] = { 'hide', 'fallback' },
  },

  appearance = {
    use_nvim_cmp_as_default = true,
    nerd_font_variant = 'mono'
  },

  sources = {
    default = { 'lsp', 'path', 'snippets', 'buffer' },
    providers = {
      buffer = {
        max_items = 4,
        min_keyword_length = 4,
      },
      path = {
        -- Trigger after 3+ chars.
        min_keyword_length = 3,
      },
    },
  },

  completion = {
    accept = {
      auto_brackets = {
        enabled = true,
      },
    },
    list = {
      selection = { preselect = true, auto_insert = true },
    },
    menu = {
      draw = {
        treesitter = { "lsp" }
      }
    },
    documentation = {
      auto_show = true,
      auto_show_delay_ms = 200,
    },
  },

  signature = { enabled = true }
})

-- AUTOCOMMANDS
-- ------------

local augroup = vim.api.nvim_create_augroup('UserConfig', { clear = true })

vim.api.nvim_create_autocmd({'BufRead', 'BufNewFile'}, {
  pattern = '*.go',
  group = augroup,
  callback = function()
    vim.opt_local.expandtab = false
    vim.opt_local.tabstop = 4
    vim.opt_local.shiftwidth = 4
  end
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
