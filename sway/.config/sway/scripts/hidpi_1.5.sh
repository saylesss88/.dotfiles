#!/bin/bash

# By default, Sway sets HiDPI displays to 2.0 scaling.
# This script checks for outputs with scale 2.0 and sets them to 1.5 instead.

# Iterate over each output with scale 2.0
# swaymsg -t get_outputs | jq -r '.[] | select(.scale == 2.0) | .name' | while read -r output; do
#     # Set scale factor to 1.5 for the found output
#     swaymsg output "$output" scale 1.5
# done


output DP-1 {
  mode 3840x2160@65Hz
  scale 1.5
  pos 0 0
}

output HDMI-A-1 {
  mode 1920x1080@100Hz
  scale 1
  pos 2560 0
}
