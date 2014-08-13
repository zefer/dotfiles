MUSIC_HOST='http://music'

alias play='music_control play'
alias pause='music_control pause'
alias skip='music_control next'
alias playing=music_status
alias music="open $MUSIC_HOST"

# usage: 'music_control play', music_control pause'
function music_control() {
  curl -sI "$MUSIC_HOST/command/?cmd=$1" | head -n 1
  music_status
}

function music_status() {
  curl -s $MUSIC_HOST/_player_engine.php | jq '. | {state, bitrate, fileext, currentsong, currentalbum, currentartist}'
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
  curl -X POST -d "path=BBCRADIO/$playlist.m3u" "$MUSIC_HOST/db/?cmd=addreplaceplay"
}

# play 1 massive random playlist
function random() {
  music_control "random 1"
  curl -X POST -d "path=NAS/music" "$MUSIC_HOST/db/?cmd=addreplaceplay"
}
