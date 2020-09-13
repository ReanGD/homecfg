local awful = require("awful")
local beautiful = require("beautiful")

-- Initialize tables and vars for module
--------------------------------------------------------------------------------
local signals = {}

-- Constructor
--------------------------------------------------------------------------------
function signals:init(args)
    args = args or {}

    -- Signal function to execute when a new client appears
    client.connect_signal("manage", function(c)
        -- startup placement
        if awesome.startup
            and not c.size_hints.user_position
            and not c.size_hints.program_position
            then
                -- Prevent clients from being unreachable after screen count changes.
                awful.placement.no_offscreen(c)
            end
        end
    )

    -- Enable sloppy focus, so that focus follows mouse.
    client.connect_signal("mouse::enter", function(c)
        c:emit_signal("request::activate", "mouse_enter", {raise = false})
    end)

    client.connect_signal("focus", function(c) c.border_color = beautiful.border_focus end)
    client.connect_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)
end

return signals
