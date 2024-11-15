MUSIC_HOST='music'
# Set this env var for the MPC client.
export MPD_HOST=$MUSIC_HOST

alias playing=music_status
alias play='music_control play; playing'
alias pause='music_control pause'
alias p=pause
alias skip='music_control next; playing'
alias music="open http://$MUSIC_HOST"
alias mpcc=ncmpcpp
alias randomoff='music_control "random 0"'
alias randomon='music_control "random 1"'

# usage: 'music_control play', music_control pause'
function music_control() {
  echo "$1\nclose" | nc $MUSIC_HOST 6600 > /dev/null
}

function music_status() {
  echo "currentsong\nclose" | nc $MUSIC_HOST 6600 | grep -E "(^Artist|^Title|^Album|^file)"
}

# usage 'radio', 'radio 4'. Defaults to 6 music
function radio() {
  music_control "random 0"
  station=${1:-6}
  if [ $station = "6" ]; then
    playlist="BBC $station Music"
  elif [ $station = "p" ] || [ $station = "paradise" ]; then
    playlist="Radio Paradise (main)"
  else
    playlist="BBC Radio $station"
  fi
  music_control clear
  music_control "load \"radio/$playlist.m3u\""
  music_control play
}

# play 1 massive random playlist
function random() {
  music_control "random 1"
  music_control clear
  music_control "add music"
  music_control play
  playing
}

