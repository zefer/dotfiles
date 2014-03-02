MUSIC_HOST='http://music'

alias play='music_control play'
alias pause='music_control pause'
alias playing=music_status
alias music="open $MUSIC_HOST"

function music_control() {
  curl -sI "$MUSIC_HOST/command/?cmd=$1" | head -n 1
  music_status
}

function music_status() {
  curl -s $MUSIC_HOST/_player_engine.php | jq '. | {state, bitrate, fileext, currentsong, currentalbum, currentartist}'
}
