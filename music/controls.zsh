MUSIC_HOST='music'

alias playing=music_status
alias play='music_control play; playing'
alias pause='music_control pause'
alias skip='music_control next; playing'
alias music="open http://$MUSIC_HOST"

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
  if [ $station -eq 6 ]; then
    playlist="BBC $station Music"
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

