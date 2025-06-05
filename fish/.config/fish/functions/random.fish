function random --description "Play a massive random playlist"
  mpc random 1
  mpc clear
  mpc add music
  mpc play
end
