function radio --description "Play radio station (usage: 'music_radio', 'music_radio 4'). Defaults to 6 music"
  mpc random 0

  set -l station (test -n "$argv[1]"; and echo $argv[1]; or echo "6")

  if test "$station" = "6"
    set playlist "BBC $station Music"
  else if test "$station" = "p"; or test "$station" = "paradise"
    set playlist "Radio Paradise (main)"
  else
    set playlist "BBC Radio $station"
  end

  mpc clear
  mpc load "radio/$playlist.m3u"
  mpc play
end
