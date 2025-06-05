install: stow

stow:
	stow -t ~ tmux
	stow -t ~ fish
	stow -t ~ ghostty
	stow -t ~ nvim
	stow -t ~ git

.PHONY: install stow
