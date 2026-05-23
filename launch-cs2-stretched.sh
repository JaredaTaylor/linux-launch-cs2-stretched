#!/bin/bash

# Assuming DP-0 is your preferred display and 4:3 is the stretched aspect ratio you want
xrandr --output DP-0 --scale 0.6666x1

# Run CS2
steam steam://rungameid/730 &

# Wait up to 10 minutes for CS2 to actually start
for i in {1..300}; do
    if pgrep -x cs2 >/dev/null || pgrep -x cs2_linux64 >/dev/null; then
        break
    fi
    sleep 2
done

# Now wait until CS2 closes
while pgrep -x cs2 >/dev/null || pgrep -x cs2_linux64 >/dev/null; do
    sleep 2
done

# Restore scale when game closes
xrandr --output DP-0 --scale 1x1