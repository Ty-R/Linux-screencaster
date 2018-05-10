#! /bin/bash

icon='player_record'  # The icon used by Yad - can be a system icon or local image
countdown=3           # Countdown in seconds before recording starts
archive=true          # Move old gifs into a directory instead of deleting them

DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$DIR"

ctrl_c() {
  echo -ne "\r\033[KRecording canceled\\n"
  rm *.gif 2> /dev/null
  exit
}
trap ctrl_c INT

LRED='\033[1;31m'
NC='\033[0m'

if ! [ -d archives ]; then
  mkdir archives
fi

if $archive; then
  mv *.gif archives 2> /dev/null
else
  rm *.gif 2> /dev/null
fi

echo -ne " Click and drag a selection\\r"

regex="([0-9]+)x([0-9]+)\+([0-9]+)\+([0-9]+)"

if [[ $(slop) =~ $regex ]]; then
  w=${BASH_REMATCH[1]}
  h=${BASH_REMATCH[2]}
  x=${BASH_REMATCH[3]}
  y=${BASH_REMATCH[4]}
fi

for ((i=$countdown;i>0;i--)); do
  countdown_timer="..Starts ${LRED}recording${NC} in $i"
  echo -ne " \r\033[K$countdown_timer"
  sleep 1
done

text="--text Recording"
image="--image=$icon"
yad="yad --notification $text $image"

x="--x=$x"
y="--y=$y"
w="--width=$w"
h="--height=$h"
name="$(date +%s).gif"

byzanz-record --exec="$yad" $x $y $w $h $name 2> /dev/null &

sleep 0.2

cmd="ps aux | grep -v grep | grep \"$yad\" | wc -l "

time_elapsed=0

while [ $(bash -c "$cmd") -gt 0 ]; do
  counter="${LRED}Recording${NC}.. ($time_elapsed)"
  echo -ne " \r\033[K$counter"
  sleep 1; ((time_elapsed+=1))
done

echo -ne "\r\033[K"$name" saved at file://${DIR}\\n"
