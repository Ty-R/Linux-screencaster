#! /bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd "$DIR"

function ctrl_c() {
        echo -ne "\\rRecording canceled                  \\n"
        rm $name.gif 2> /dev/null
        exit
}
trap ctrl_c INT

LRED='\033[1;31m'
NC='\033[0m'

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

if [[ $(./xrectsel) =~ ([0-9]+)x([0-9]+)\+([0-9]+)\+([0-9]+) ]]; then
  w=${BASH_REMATCH[1]} # width
  h=${BASH_REMATCH[2]} # height
  x=${BASH_REMATCH[3]} # 0x
  y=${BASH_REMATCH[4]} # 0y
fi

for i in {3..1}; do
  echo -ne " ..Starts ${LRED}recording${NC} in $i   \\r"
  sleep 1
done

name=$(date +%s)

yad="yad --notification --text 'Recording, click to stop' --image=record.png"

# start recording and get PID to detect when it stops
byzanz-record --exec="$yad" --x=$x --y=$y --width=$w --height=$h $name.gif 2> /dev/null & ID=$!

time_elapsed=0

while $(kill -0 $ID 2> /dev/null); do
  echo -ne " ${LRED}Recording${NC} .. ($time_elapsed)       \\r"
  sleep 1; ((time_elapsed+=1))
done

echo -ne "Saving "$name".gif at ${DIR}                \\r\\n"
