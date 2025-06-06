# Environment variables
set -gx EDITOR nvim
set -gx CDPATH . ~/ ~/Development ~/Development/go/src/github.com/zefer

set -U fish_greeting

if status is-interactive
  fish_vi_key_bindings
  bind -M insert \cr 'history | fzf | read -l result; and commandline $result'
end
