# Environment variables
set -gx EDITOR nvim

set -U fish_greeting

if status is-interactive
  fish_vi_key_bindings
  bind -M insert \cr 'history | fzf | read -l result; and commandline $result'
end
