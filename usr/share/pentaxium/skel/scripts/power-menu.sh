#!/bin/bash

lock="Lock\0icon\x1fsystem-lock-screen"
logout="Logout\0icon\x1fsystem-log-out"
reload="Reload Hyprland\0icon\x1fview-refresh"
suspend="Suspend\0icon\x1fsystem-suspend"
reboot="Reboot\0icon\x1fsystem-reboot"
shutdown="Shutdown\0icon\x1fsystem-shutdown"

options="$lock\n$logout\n$reload\n$suspend\n$reboot\n$shutdown"

chosen="$(echo -e "$options" | rofi -dmenu -i -show-icons -p "" -theme ~/.config/rofi/power-menu.rasi)"

case $chosen in
    "Lock")
        $LOCK
        ;;
    "Logout")
        $LOGOUT
        ;;
    "Reload Hyprland")
        $RELOAD_SHELL
        ;;
    "Suspend")
        $SUSPEND
        ;;
    "Reboot")
        $REBOOT
        ;;
    "Shutdown")
        $SHUTDOWN
        ;;
esac
