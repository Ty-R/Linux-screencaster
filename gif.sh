#! /bin/bash

DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$DIR"

ctrl_c() {
  echo -ne "\r\033[KRecording canceled\\n"
  rm $name.gif 2> /dev/null
  exit
}
trap ctrl_c INT

LRED='\033[1;31m'
NC='\033[0m'

# each time a new recording is started
# all existing gifs are moved to archives
if ! [ -d archives ]; then
  mkdir archives
fi

mv *.gif archives 2> /dev/null

if ! [ -f xrectsel ]; then
  if ! [ -f xrectsel.c ]; then
    echo "Missing xrectsel.c"
    exit
  fi
  gcc -Wall xrectsel.c -o xrectsel -lX11 && rm xrectsel.c
fi

echo -ne " Click and drag a selection\\r"

regex="([0-9]+)x([0-9]+)\+([0-9]+)\+([0-9]+)"

if [[ $(./xrectsel) =~ $regex ]]; then
  w=${BASH_REMATCH[1]}
  h=${BASH_REMATCH[2]}
  x=${BASH_REMATCH[3]}
  y=${BASH_REMATCH[4]}
fi

for i in {3..1}; do
  countdown="..Starts ${LRED}recording${NC} in $i"
  echo -ne " \r\033[K$countdown"
  sleep 1
done

text="--text Recording"
image="--image=record.png"
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

echo -ne "\r\033[K"$name" saved at ${DIR}\\n"