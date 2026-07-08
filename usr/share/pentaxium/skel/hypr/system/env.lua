-- system/env.lua

-- Base Path --
local base_path = "/usr/share/pentaxium/skel"

-- Cursor --
hl.env("XCURSOR_SIZE", "20")
hl.env("HYPRCURSOR_SIZE", "20")

-- Dark Mode --

-- GTK
hl.env("GTK_THEME", "Adwaita:dark")
hl.env("WEBKIT_FORCE_DARK_MODE", "1")

-- QT
hl.env("QT_QPA_PLATFORM", "wayland")
hl.env("QT_QPA_PLATFORMTHEME", "qt5ct")
hl.env("QT_QUICK_CONTROLS_STYLE", "org.kde.desktop")
hl.env("QT_IMAGEIO_TOGGLE_DARK_MODE", "1")

-- Hyprland
hl.env("XDG_CURRENT_DESKTOP", "Hyprland")
hl.env("XDG_SESSION_DESKTOP", "Hyprland")

-- Input Method --
hl.env("XMODIFIERS", "@im=fcitx")
hl.env("QT_IM_MODULE", "fcitx")
hl.env("GTK_IM_MODULE", "fcitx")
hl.env("SDL_IM_MODULE", "fcitx")

-- Desktop Components --

-- Components
hl.env("LAUNCH_DOCK", 'waybar -c /usr/share/pentaxium/skel/waybar/dock')
hl.env("TOGGLE_CC", 'eww --config "' .. base_path .. '/eww/" open --toggle control_center')
hl.env("TOGGLE_NOTI", "swaync-client -t -sw")
hl.env("LAUNCHPAD", "rofi -show drun -theme " .. base_path .. "/rofi/launchpad.rasi")
hl.env("SPOTLIGHT", "rofi -show drun -theme " .. base_path .. "/rofi/spotlight-dark.rasi")
hl.env("WALLPAPER_PICKER", base_path .. "/scripts/wp-picker.sh")
hl.env("LOCKSCREEN", base_path .. "/scripts/lockscreen.sh")
hl.env("POWER_MENU", base_path .. "/scripts/power-menu.sh")
hl.env("IME", base_path .. "/scripts/switch_ime.sh")

-- Daemon
hl.env("NOTI_DAEMON", "swaync")
hl.env("OSD_SERVER", "swayosd-server")
hl.env("BAR_CMD", "waybar")
hl.env("BG_DAEMON", "awww-daemon")

-- Power Option
hl.env("SHUTDOWN", "shutdown now")
hl.env("REBOOT", "reboot")
hl.env("LOGOUT", base_path .. "/scripts/logout.sh")
hl.env("RELOAD_SHELL", base_path .. "/scripts/reload-shell.sh")
hl.env("LOCK", "$LOCKSCREEN")
hl.env("SUSPEND", base_path .. "/scripts/suspend.sh")

-- Config
hl.env("WALLPAPER", base_path .. "/wallpapers")

-- Apps --
hl.env("TERMINAL", "kitty")
hl.env("FILEMANAGER", "dolphin")
hl.env("BROWSER", "firefox")
hl.env("EDITOR", "text-editor")