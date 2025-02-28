local wezterm = require("wezterm")
local config = wezterm.config_builder()
-- local brightness = 0.03
local theme = require('lua/rose_pine').dawn

config.colors = theme.colors()
config.window_frame = theme.window_frame()


-- config.window_background_image_hsb = {
--     -- Darken the background image by reducing it
--     brightness = brightness,
--     hue = 1.0,
--     saturation = 0.8,
-- }


-- window setting
-- config.window_background_opacity = 0.90
-- config.macos_window_background_blur = 85

-- config.window_padding = {
--     left = 0,
--     right = 0,
--     top = 0,
--     bottom = 0,
-- }

config.font = wezterm.font("Iosevka Nerd Font Mono", { weight = "Medium", stretch = "Expanded" })
config.font_size = 14

config.window_decorations = "RESIZE"
config.enable_tab_bar = false


-- keys
config.keys = {
    {
        key = "L",
        mods = "CTRL|SHIFT",
        action = wezterm.action.OpenLinkAtMouseCursor,
    },
}


return config
