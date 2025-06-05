set -g MUSIC_HOST 'music'
set -gx MPD_HOST $MUSIC_HOST

alias playing mpc
alias play 'mpc play'
alias pause 'mpc pause'
alias p pause
alias skip 'mpc next'
alias music "open http://$MUSIC_HOST"
alias mpcc ncmpcpp
alias randomoff 'mpc random 0'
alias randomon 'mpc random 1'
