LIGHTWAVE_HOST='lightwaverf'

# Map room IDs to friendly names.
typeset -A ROOMS
ROOMS[livingroom]=1
ROOMS[office]=2
ROOMS[bedroom]=3

# Listen to and dump the JSON data being broadcast by Lightwave, including the
# current home electricity usage.
function lw_listen() {
  nc -ulk -w 2 9761
}

# Register this hardware device with the Lightwave link so it accepts commands.
# Confirm by pressing the button on the link device after running this.
function lw_register() {
  echo -ne '100,!F*p.' | nc -u -w1 $LIGHTWAVE_HOST 9760
}

# Usage:
# off: turns everything off.
# off downstairs/upstairs/outside: turns everything in that space/room off.
# off 1/2/3: turns that everything in that space off.
# off 1 2: turns off device 2 in room 1.
# off downstairs 2: turns off device 2 downstairs.
off() {
  rooms=${1:-all}
  devices=${2:-all}
  room_id=${ROOMS[$rooms]:=$rooms}

  if [[ $rooms == "all" ]]
  then
    for room_id in 1 2 3
    do
      echo -ne "100,\!R${room_id}Fa" | nc -u -w1 $LIGHTWAVE_HOST 9760
    done
    return
  fi

  if [[ $devices == "all" ]]
  then
    devices=(1 2 3 4)
  fi

  for device_id in "${devices[@]}"
  do
    echo -ne "100,!R${room_id}D${device_id}F0" | nc -u -w1 $LIGHTWAVE_HOST 9760
  done
}

rooms() {
  for k in "${(@k)ROOMS}"; do
    echo "$k: $ROOMS[$k]"
  done
}

# Usage:
# on: turns on everything in room 1.
# on 2: turns on everything in room 2.
# on downstairs: turns on everything downstairs.
# on 1 3: turns on device 3 in room 1.
# on downstairs 3: turns on device 3 downstairs.
on() {
  room=${1:-1}
  devices=${2:-all}
  room_id=${ROOMS[$room]:=$room}

  if [[ $devices == "all" ]]
  then
    devices=(1 2 3 4)
  fi

  for device_id in "${devices[@]}"
  do
    echo -ne "100,!R${room_id}D${device_id}F1" | nc -u -w1 $LIGHTWAVE_HOST 9760
  done
}

