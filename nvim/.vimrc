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

set wildignore+=log/**,node_modules/**,tmp/**,*.scssc,*.sassc
set backupskip=/tmp/*,/private/tmp/*   " don't create backup files here

map <Leader>g ::GitGutterToggle<cr>
map <Leader>d :call DeclutterModeToggle()<cr>

" double percentage sign in command mode is expanded
" to directory of current file - http://vimcasts.org/e/14
cnoremap %% <C-R>=expand('%:h').'/'<cr>

if executable('ag')
  let g:ackprg = 'ag --vimgrep'
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
