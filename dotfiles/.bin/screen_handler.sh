#!/usr/bin/env bash
if [[ -z $(xrandr | grep "HDMI1 disconnected") ]]
then
  # Turn on HDMI and turn off built in display
  xrandr --output eDP1 --off --output HDMI1 --auto --primary
else
  # Turn on laptop display and turn off HDMI1
  xrandr --output eDP1 --auto --primary --output HDMI1 --off --output "DP1-1" --off --output "DP1-2" --off
fi
