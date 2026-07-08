-- hyprland.lua

-------------------------------
---- ENVIRONMENT VARIABLES ----
-------------------------------

require("system.env")

-------------------
---- AUTOSTART ----
-------------------

local system_core = require("system.compoment")
local user_apps   = require("users.autostart")

hl.on("hyprland.start", function () 
    for _, cmd in ipairs(system_core) do
        hl.exec_cmd(cmd)
    end
    
    for _, app in ipairs(user_apps) do
        hl.exec_cmd(app)
    end
    
    hl.exec_cmd("/usr/share/pentaxium/skel/scripts/welcome.sh")
end)

------------------
---- MONITORS ----
------------------

hl.monitor({
    output   = "",
    mode     = "1366x768@60",
    position = "auto",
    scale    = "1.0",
})

-----------------------
----- PERMISSIONS -----
-----------------------

-- for security reasons

-- hl.config({
--   ecosystem = {
--     enforce_permissions = true,
--   },
-- })

-- hl.permission("/usr/(bin|local/bin)/grim", "screencopy", "allow")
-- hl.permission("/usr/(lib|libexec|lib64)/xdg-desktop-portal-hyprland", "screencopy", "allow")
-- hl.permission("/usr/(bin|local/bin)/hyprpm", "plugin", "allow")

-----------------------
---- LOOK AND FEEL ----
-----------------------

require("users.style")

hl.config({
    general = {
        gaps_in  = 5,
        gaps_out = 20,

        border_size = 1,

        col = {
            active_border   = { colors = {"rgba(33ccffee)", "rgba(00ff99ee)"}, angle = 45 },
            inactive_border = "rgba(595959aa)",
        },

        resize_on_border = false,

        allow_tearing = false,

        layout = "dwindle",
    },

    decoration = {
        rounding       = 12,
        rounding_power = 2,

        active_opacity   = 0.76,
        inactive_opacity = 0.76,

        shadow = {
            enabled      = true,
            range        = 4,
            render_power = 3,
            color        = 0xee1a1a1a,
        },

        blur = {
            enabled   = os.getenv("BLUR") == "true",
            size      = 3,
            passes    = 3,
            vibrancy  = 0.1696,
        },
    },

    animations = {
        enabled = true,
    },
})

hl.curve("easeOutQuint",   { type = "bezier", points = { {0.23, 1},    {0.32, 1}    } })
hl.curve("easeInOutCubic", { type = "bezier", points = { {0.65, 0.05}, {0.36, 1}    } })
hl.curve("linear",         { type = "bezier", points = { {0, 0},       {1, 1}       } })
hl.curve("almostLinear",   { type = "bezier", points = { {0.5, 0.5},   {0.75, 1}    } })
hl.curve("quick",          { type = "bezier", points = { {0.15, 0},    {0.1, 1}     } })

-- Default springs
hl.curve("easy",           { type = "spring", mass = 1, stiffness = 71.2633, dampening = 15.8273644 })

hl.animation({ leaf = "global",        enabled = true,  speed = 12,   bezier = "default" })
hl.animation({ leaf = "border",        enabled = true,  speed = 5.39, bezier = "easeOutQuint" })
hl.animation({ leaf = "windows",       enabled = true,  speed = 7.79, spring = "easy" })
hl.animation({ leaf = "windowsIn",     enabled = true,  speed = 7.1,  spring = "easy",         style = "popin 87%" })
hl.animation({ leaf = "windowsOut",    enabled = true,  speed = 7.49, bezier = "easeOutQuint",       style = "popin 87%" })
hl.animation({ leaf = "fadeIn",        enabled = true,  speed = 1.73, bezier = "almostLinear" })
hl.animation({ leaf = "fadeOut",       enabled = true,  speed = 1.46, bezier = "almostLinear" })
hl.animation({ leaf = "fade",          enabled = true,  speed = 3.03, bezier = "quick" })
hl.animation({ leaf = "layers",        enabled = true,  speed = 3.81, bezier = "easeOutQuint" })
hl.animation({ leaf = "layersIn",      enabled = true,  speed = 4,    bezier = "easeOutQuint", style = "fade" })
hl.animation({ leaf = "layersOut",     enabled = true,  speed = 1.5,  bezier = "linear",       style = "fade" })
hl.animation({ leaf = "fadeLayersIn",  enabled = true,  speed = 1.79, bezier = "almostLinear" })
hl.animation({ leaf = "fadeLayersOut", enabled = true,  speed = 1.39, bezier = "almostLinear" })
hl.animation({ leaf = "workspaces",    enabled = true,  speed = 6.94, bezier = "easeOutQuint", style = "slide" })
hl.animation({ leaf = "workspacesIn",  enabled = true,  speed = 6.21, bezier = "easeOutQuint", style = "slide" })
hl.animation({ leaf = "workspacesOut", enabled = true,  speed = 6.94, bezier = "easeOutQuint", style = "slide" })
hl.animation({ leaf = "zoomFactor",    enabled = true,  speed = 7,    bezier = "quick" })

hl.config({
    dwindle = {
        preserve_split = true, -- You probably want this
    },
})

hl.config({
    master = {
        new_status = "master",
    },
})

hl.config({
    scrolling = {
        fullscreen_on_one_column = true,
    },
})

----------------
----  MISC  ----
----------------

hl.config({
    misc = {
        force_default_wallpaper = -1,    -- Set to 0 or 1 to disable the anime mascot wallpapers
        disable_hyprland_logo   = false, -- If true disables the random hyprland logo / anime girl background. :(
    },
})


---------------
---- INPUT ----
---------------

hl.config({
    input = {
        kb_layout  = "us",
        kb_variant = "",
        kb_model   = "",
        kb_options = "",
        kb_rules   = "",

        follow_mouse = 1,

        sensitivity = 0, -- -1.0 - 1.0, 0 means no modification.

        touchpad = {
            natural_scroll = false,
        },
    },
})

hl.gesture({
    fingers = 3,
    direction = "horizontal",
    action = "workspace"
})

hl.device({
    name        = "epic-mouse-v1",
    sensitivity = -0.5,
})


---------------------
---- KEYBINDINGS ----
---------------------

local mainMod = "SUPER"

hl.bind(mainMod .. " + Return", hl.dsp.exec_cmd(os.getenv("TERMINAL") or "kitty"))
local closeWindowBind = hl.bind(mainMod .. " + Q", hl.dsp.window.close())
-- closeWindowBind:set_enabled(false)
hl.bind(mainMod .. " + M", hl.dsp.exec_cmd(os.getenv("LOGOUT") or ""))
hl.bind(mainMod .. " + N", hl.dsp.exec_cmd("notify-send -i /home/ngmvix2010_/.icons/Colloid-Light/apps/scalable/appimagekit-supertux2.svg 'HyprTux' 'This is my own dotfile.'"))
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd(os.getenv("FILEMANAGER") or "dolphin"))
hl.bind(mainMod .. " + B", hl.dsp.exec_cmd(os.getenv("BROWSER") or "firefox"))
hl.bind(mainMod .. " + V", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + R", hl.dsp.exec_cmd(os.getenv("RELOAD_SHELL") or ""))

hl.bind(mainMod .. " + A", hl.dsp.exec_cmd(os.getenv("LAUNCHPAD") or ""))
hl.bind(mainMod .. " + SPACE", hl.dsp.exec_cmd(os.getenv("SPOTLIGHT") or ""))
hl.bind(mainMod .. " + W", hl.dsp.exec_cmd(os.getenv("WALLPAPER_PICKER") or ""))
hl.bind(mainMod .. " + L", hl.dsp.exec_cmd(os.getenv("LOCKSCREEN") or ""))
hl.bind(mainMod .. " + P", hl.dsp.exec_cmd(os.getenv("POWER_MENU") or ""))
hl.bind(mainMod .. " + SHIFT + SPACE", hl.dsp.exec_cmd(os.getenv("IME") or ""))

hl.bind(mainMod .. " + SHIFT + 3",  hl.dsp.exec_cmd("hyprshot -m output -c -o ~/Pictures/Screenshots"))

hl.bind(mainMod .. " + left",  hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + right", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + up",    hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + down",  hl.dsp.focus({ direction = "down" }))

for i = 1, 10 do
    local key = i % 10 -- 10 maps to key 0
    hl.bind(mainMod .. " + " .. key,             hl.dsp.focus({ workspace = i}))
    hl.bind(mainMod .. " + ALT + " .. key,     hl.dsp.window.move({ workspace = i }))
end

hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_up",   hl.dsp.focus({ workspace = "e-1" }))

hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(),   { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("swayosd-client --output-volume raise"), { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("swayosd-client --output-volume lower"), { locked = true, repeating = true })
hl.bind("XF86AudioMute",        hl.dsp.exec_cmd("swayosd-client --output-volume mute-toggle"), { locked = true, repeating = true })
hl.bind("XF86AudioMicMute",     hl.dsp.exec_cmd("swayosd-client --input-volume mute-toggle"), { locked = true, repeating = true })
hl.bind("XF86MonBrightnessUp",  hl.dsp.exec_cmd("swayosd-client --brightness raise"), { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown",hl.dsp.exec_cmd("swayosd-client --brightness lower"), { locked = true, repeating = true })

hl.bind("XF86AudioNext",  hl.dsp.exec_cmd("playerctl next"),       { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPlay",  hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev",  hl.dsp.exec_cmd("playerctl previous"),   { locked = true })


--------------------------------
---- WINDOWS AND WORKSPACES ----
--------------------------------

local suppressMaximizeRule = hl.window_rule({
    -- Ignore maximize requests from all apps. You'll probably like this.
    name  = "suppress-maximize-events",
    match = { class = ".*" },

    suppress_event = "maximize",
})

hl.window_rule({
    -- Fix some dragging issues with XWayland
    name  = "fix-xwayland-drags",
    match = {
        class      = "^$",
        title      = "^$",
        xwayland   = true,
        float      = true,
        fullscreen = false,
        pin        = false,
    },

    no_focus = true,
})

hl.window_rule({
    name  = "move-hyprland-run",
    match = { class = "hyprland-run" },

    move  = "20 monitor_h-120",
    float = true,
})

hl.window_rule({
    name  = "firefox-opaque",
    match = { class = "^firefox$" },

    opaque         = true,
})

hl.window_rule({
    name  = "discord-opaque",
    match = { class = "^discord$" },

    opaque         = true,
})

hl.window_rule({
    name  = "code-opaque",
    match = { class = "^code-oss$" },

    opaque         = true,
})

hl.layer_rule({
    name = "rofi-blur",
    match = { namespace = "rofi" },
    blur = true,
})

hl.layer_rule({
    name = "waybar-blur",
    match = { namespace = "waybar" },
    blur = true,
    ignore_alpha = 0.2,
})

hl.layer_rule({
    name = "swaync-blur",
    match = { namespace = "swaync-control-center" },
    blur = true,
    ignore_alpha = 0,
})

hl.layer_rule({
    name = "swaynct-blur",
    match = { namespace = "swaync-notification-window" },
    blur = true,
    ignore_alpha = 0,
})

hl.layer_rule({
    name = "swayosd-blur",
    match = { namespace = "swayosd" },
    blur = true,
    ignore_alpha = 0,
})

hl.layer_rule({
    name = "eww-control-center-blur",
    match = { namespace = "eww-control-center" },
    blur = true,
    ignore_alpha = 0.2,
})

hl.layer_rule({
    name = "eww-dock-blur",
    match = { namespace = "eww-dock" },
    blur = true,
    ignore_alpha = 0.2,
})