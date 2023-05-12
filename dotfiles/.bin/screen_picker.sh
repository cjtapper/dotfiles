#!/usr/bin/env bash

# Count connected screens
num_connected_screens=$(xrandr --dryrun | grep -c " connected")

if [ "$num_connected_screens" -eq 1 ]; then
  # If only one screen is connected, it must be the Laptop screen
  screen_selection="Laptop"
else
  screen_selection=$(printf "Laptop\nMonitor\nHDMI" | dmenu -i -l 3)
fi

case "$screen_selection" in
    "Monitor")
        xrandr \
          --output eDP1 --off \
          --output DP1 --primary --mode 3840x2160 --pos 0x0 --rotate normal \
          --output DP2 --off \
          --output HDMI1 --off \
          --output VIRTUAL1 --off
        dpi="144"
        ;;
    "HDMI")
        xrandr \
          --output eDP1 --off \
          --output DP1 --off \
          --output DP2 --off \
          --output HDMI1 --primary --mode 1920x1080 --pos 0x0 --rotate normal \
          --output VIRTUAL1 --off
        dpi="96"
        ;;
    "Laptop")
        xrandr \
          --output eDP1 --primary --mode 1920x1080 --pos 0x0 --rotate normal \
          --output DP1 --off \
          --output DP2 --off \
          --output HDMI1 --off \
          --output VIRTUAL1 --off
        dpi="96"
        ;;
    *)
      exit 0
      ;;
esac

echo "Xft.dpi: $dpi" | xrdb -merge
i3-msg restart > /dev/null
