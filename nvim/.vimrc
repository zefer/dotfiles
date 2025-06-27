filetype off                    " required by Vundle, override later

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" Vundle bundles!
Plugin 'VundleVim/Vundle.vim'
Plugin 'dense-analysis/ale'
Plugin 'vim-scripts/VimCompletesMe'
Plugin 'ngmy/vim-rubocop'
call vundle#end()
filetype plugin indent on       " load file type plugins + indentation
" set autoread                    " reload files when changed on disk

let g:go_fmt_command = "goimports"

" ALE
let g:ale_sign_warning = '▲'
let g:ale_sign_error = '✗'
" let g:ale_linters = { 'ruby': ['rubocop'] }
highlight link ALEWarningSign String
highlight link ALEErrorSign Title

" ALE linting error/warning navigation.
nmap [o <Plug>(ale_previous_wrap)
nmap ]o <Plug>(ale_next_wrap)
