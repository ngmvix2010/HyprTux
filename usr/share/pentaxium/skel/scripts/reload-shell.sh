#!/bin/bash

hyprctl reload

swaync-client -R && swaync-client -rs

pkill waybar
pkill eww
sleep 0.3
$BAR_CMD
$LAUNCH_DOCK

notify-send -e 'Pentaxium Shell' 'Pentaxium Shell has been reloaded!' -i /usr/share/pentaxium/skel/logo.svg
