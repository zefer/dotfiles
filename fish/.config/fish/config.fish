# Environment variables
set -gx EDITOR nvim

set -U fish_greeting

if status is-interactive
  # Commands to run in interactive sessions can go here
  fish_vi_key_bindings
end
