-- system/components.lua

local noti    = os.getenv("NOTI_DAEMON") or "swaync"
local osd     = os.getenv("OSD_SERVER") or "swayosd-server"
local bg      = os.getenv("BG_DAEMON") or "awww-daemon"
local bar     = os.getenv("BAR_CMD") or "waybar"
local dock    = os.getenv("LAUNCH_DOCK") or "eww open dock"

local system_daemons = {
    noti .. " &",
    osd .. " &",
    bg .. " &",
    "fcitx5 -d --replace",
    bar .. " &",
    dock
}

return system_daemons