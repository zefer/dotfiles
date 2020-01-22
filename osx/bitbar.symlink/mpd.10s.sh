#!/bin/bash

export MPD_HOST=music

if [ "$1" = 'toggle' ]; then
  /usr/local/bin/mpc toggle
  exit
fi

if [ "$1" = 'next' ]; then
  /usr/local/bin/mpc next
  exit
fi

if [ "$1" = 'prev' ]; then
  /usr/local/bin/mpc prev
  exit
fi

count="$( /usr/local/bin/mpc | wc -l )"

if [ "$count" -gt 2 ]
then
  if [[ $(/usr/local/bin/mpc | head -2) == *"[paused]"* ]]
  then
    echo "❚❚"
  else
    echo "$(/usr/local/bin/mpc | head -1) | length=25 size=12"
  fi
else
  echo "❚❚"
fi

echo "---"
echo "Refresh | refresh=true"
echo "Mothership | color=#123def href=http://music/#/playing"
echo "❚❚/▶ Toggle | bash='$0' param1=toggle terminal=false"
echo "→ Next | bash='$0' param1=next terminal=false"
echo "← Previous | bash='$0' param1=prev terminal=false"
