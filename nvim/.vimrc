set nocompatible                " choose no compatibility with legacy vi
filetype off                    " required by Vundle, override later

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" Vundle bundles!
Plugin 'VundleVim/Vundle.vim'
Plugin 'fholgado/minibufexpl.vim'
Plugin 'junegunn/fzf.vim'
Plugin 'tomasr/molokai'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-unimpaired'
Plugin 'tpope/vim-commentary'
Plugin 'tpope/vim-rails'
Plugin 'tpope/vim-rake'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-markdown'
Plugin 'tpope/vim-vinegar'
Plugin 'tpope/vim-rhubarb'
Plugin 'mileszs/ack.vim'
Plugin 'dense-analysis/ale'
Plugin 'tpope/vim-endwise'
Plugin 'airblade/vim-gitgutter'
Plugin 'vim-scripts/VimCompletesMe'
Plugin 'christoomey/vim-tmux-navigator'
Plugin 'ngmy/vim-rubocop'
Plugin 'fatih/vim-go'
Plugin 'kchmck/vim-coffee-script'
Plugin 'digitaltoad/vim-pug'
Plugin 'groenewege/vim-less'
Plugin 'leafgarland/typescript-vim'
call vundle#end()
filetype plugin indent on       " load file type plugins + indentation
" set autoread                    " reload files when changed on disk

syntax enable
set encoding=utf-8
set showcmd                     " display incomplete commands
set nocursorline                " disable cursor line as it is very CPU-heavy, unfortunately
set number                      " show line numbers

set background=dark
colorscheme molokai

"" Whitespace
set nowrap                      " don't wrap lines
set scrolloff=3                 " show context above/below cursorline
set tabstop=2 shiftwidth=2      " a tab is two spaces (or set this to 4)
set expandtab                   " use spaces, not tabs (optional)
set backspace=indent,eol,start  " backspace through everything in insert mode
" List chars
set list
set listchars=""                " Reset the listchars
set listchars=tab:\ \           " a tab should display as "  ", trailing whitespace as "."
set listchars+=trail:.          " show trailing spaces as dots
set listchars+=extends:>        " The character to show in the last column when wrap is
                                " off and the line continues beyond the right of the screen
set listchars+=precedes:<       " The character to show in the first column when wrap is

"" Searching
set hlsearch                    " highlight matches
set incsearch                   " incremental searching
set ignorecase                  " searches are case insensitive...
set smartcase                   " ... unless they contain at least one capital letter

set wildignore+=log/**,node_modules/**,tmp/**,*.scssc,*.sassc
set backupskip=/tmp/*,/private/tmp/*   " don't create backup files here

set secure                      " disable unsafe commands in local .vimrc files

set colorcolumn=80
hi ColorColumn ctermbg=234 guibg=#3E3D32

set spelllang=en_gb

if has("autocmd")
  autocmd BufRead,BufNewFile *.go setlocal filetype=go noexpandtab
  autocmd BufRead,BufNewFile *.svelte setlocal filetype=html
  " autocmd BufRead,BufNewFile *.hbs setlocal filetype=html
  autocmd BufRead,BufNewFile *.handlebars,*.hbs set ft=html syntax=html
  autocmd FileType text,markdown,gitcommit setlocal spell
endif

" fix gx to open the URL under the cursor, like it used to.
" https://github.com/vim/vim/issues/4738
nmap gx yiW:!open <cWORD><CR> <C-r>" & <CR><CR>

" write with sudo, for read-only files
cmap w!! %!sudo tee > /dev/null %

map <Leader>g ::GitGutterToggle<cr>
map <Leader>8 :call ToggleColorColumn()<cr>
map <Leader>d :call DeclutterModeToggle()<cr>
map <Leader>5 :call StripTrailingWhitespace()<cr>

" move within 'displayed lines rather than 'physical' lines (for wordwrap)
noremap k gk
noremap j gj

" make :W do the same as :w
if !exists(':W')
  command W w
endif

" double percentage sign in command mode is expanded
" to directory of current file - http://vimcasts.org/e/14
cnoremap %% <C-R>=expand('%:h').'/'<cr>

" code folding
set foldmethod=indent
set foldlevelstart=20
nnoremap <Space> za

if executable('ag')
  let g:ackprg = 'ag --vimgrep'
endif

if has("statusline") && !&cp
  set laststatus=2  " always show the status bar
  set statusline=[%n]\ %f\ [%{&ft}]\ %m\ %r   " left
  set statusline+=%=%-0(%l,%v\ [%P]%)         " right
endif

let g:miniBufExplStatusLineText = '%='
let g:go_fmt_command = "goimports"

" FZF (replaces Ctrl-P, FuzzyFinder and Command-T)
set rtp+=/usr/local/opt/fzf
set rtp+=~/.fzf
nmap <Leader>b :Buffers<cr>
nmap <Leader>f :Files<cr>
nmap <Leader>t :Tags<cr>
nmap <Leader>s :Ag<cr>
let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-s': 'split',
  \ 'ctrl-v': 'vsplit' }

" ALE
let g:ale_sign_warning = '▲'
let g:ale_sign_error = '✗'
" let g:ale_linters = { 'ruby': ['rubocop'] }
highlight link ALEWarningSign String
highlight link ALEErrorSign Title

" ALE linting error/warning navigation.
nmap [o <Plug>(ale_previous_wrap)
nmap ]o <Plug>(ale_next_wrap)

function! StripTrailingWhitespace()
    " Preparation: save last search, and cursor position.
    let _s=@/
    let l = line(".")
    let c = col(".")
    " Do the business:
    %s/\s\+$//e
    " Clean up: restore previous search history, and cursor position
    let @/=_s
    call cursor(l, c)
endfunction

" Convert Markdown to HTML and open to preview
map <F8> <ESC>:w!<CR>:!markdown % \| smartypants > %.html && open %.html<CR><CR>a

" Toggle 'focus mode' - hides UI junk for a more fullscreen-like view
let g:DeclutterMode = 0
function! DeclutterModeToggle()
  if g:DeclutterMode==1
    echo "CLUTTER MODE"
    windo set number
    windo :GitGutterEnable
    :MBEOpen
    let g:DeclutterMode = 0
  else
    echo "DECLUTTER MODE"
    :MBEClose
    windo set nonumber
    windo :GitGutterDisable
    let g:DeclutterMode = 1
  endif
endfunction

" Toggle word wrap
noremap <silent> <Leader>w :call ToggleWrap()<CR>
function! ToggleWrap()
  if &wrap
    echo "Wrap OFF"
    setlocal nowrap
  else
    echo "Wrap ON"
    setlocal wrap linebreak nolist
    setlocal display+=lastline
  endif
endfunction

" Toggle colorcolumn
function! ToggleColorColumn()
  if &colorcolumn==80
    setlocal colorcolumn=0
  else
    setlocal colorcolumn=80
  endif
endfunction
