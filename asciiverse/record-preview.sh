#!/bin/sh
# Records the catalog preview at 100x30 the way av starts ternimal
# (fit=true: the whole window, on the alternate screen), ended by SIGTERM,
# which quits the way a key does. Needs asciinema 3.
#
#   asciiverse/record-preview.sh out/ternimal asciiverse/ternimal.cast [seed] [seconds]
set -eu
binary=$(cd "$(dirname "$1")" && pwd)/$(basename "$1")
out=$2
seed=${3:-7}
seconds=${4:-25}
home=$(mktemp -d)
trap 'rm -rf "$home"' EXIT
mkdir "$home/bin" && cp "$binary" "$home/bin/ternimal"
cd "$home"  # nothing in the recording names a local path
HOME="$home" PATH="$home/bin:$PATH" TERM=xterm-256color COLORTERM=truecolor LANG=C.UTF-8 \
asciinema rec --headless --overwrite -q \
  --window-size 100x30 --idle-time-limit 2 \
  --capture-env "TERM,COLORTERM,LANG" --title "ternimal" \
  --command "timeout --foreground -s TERM $seconds ternimal fit=true seed=$seed" \
  "$OLDPWD/$out"
