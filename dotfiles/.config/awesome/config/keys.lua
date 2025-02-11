local awful = require("awful")
local gears = require("gears")
local hotkeys_popup = require("awful.hotkeys_popup")
local var = require("config.var")

local terminal = var.terminal
local modkey = var.modkey

---@param group string
---@return table
local awesome_keys = function(group)
    local keys = {
        awful.key({var.modkey}, "s", hotkeys_popup.show_help,
                  {description = "show help", group = group}),

        awful.key({var.modkey}, "w", function()
            mymainmenu:show()
        end, {description = "show main menu", group = group}), -- Layout manipulation

        awful.key({var.modkey, "Control"}, "r", awesome.restart,
                  {description = "reload awesome", group = group}),

        awful.key({var.modkey, "Shift"}, "q", awesome.quit,
                  {description = "quit awesome", group = group}),

        awful.key({var.modkey}, "x", function()
            awful.prompt.run {
                prompt = "Run Lua code: ",
                textbox = awful.screen.focused().mypromptbox.widget,
                exe_callback = awful.util.eval,
                history_path = awful.util.get_cache_dir() .. "/history_eval"
            }
        end, {description = "lua execute prompt", group = group})
    }

    return keys
end

---@param group string
---@return table
local tag_keys = function(group)
    local keys = {
        awful.key({var.modkey}, "n", awful.tag.viewprev,
                  {description = "view previous", group = group}),

        awful.key({var.modkey}, "p", awful.tag.viewnext,
                  {description = "view next", group = group}),

        awful.key({var.modkey}, "Escape", awful.tag.history.restore,
                  {description = "go back", group = group})

    }

    -- Bind all key numbers to tags.
    -- Be careful: we use keycodes to make it work on any keyboard layout.
    -- This should map on the top row of your keyboard, usually 1 to 9.
    for i = 1, 9 do
        -- Switch tag display
        table.insert(keys, awful.key({var.modkey}, "#" .. i + 9, function()
            local screen = awful.screen.focused()
            local tag = screen.tags[i]
            if tag then
                tag:view_only()
            end
        end, {description = "view tag #" .. i, group = group}))
        -- Toggle tag display.
        table.insert(keys,
                     awful.key({var.modkey, "Shift"}, "#" .. i + 9, function()
            local screen = awful.screen.focused()
            local tag = screen.tags[i]
            if tag then
                awful.tag.viewtoggle(tag)
            end
        end, {description = "toggle tag #" .. i, group = group}))
        -- Move client to tag.
        table.insert(keys,
                     awful.key({var.modkey, "Control"}, "#" .. i + 9,
                               function()
            if client.focus then
                local tag = client.focus.screen.tags[i]
                if tag then
                    client.focus:move_to_tag(tag)
                end
            end
        end, {description = "move focused client to tag #" .. i, group = group}))
        -- Toggle tag on focused client.
        table.insert(keys,
                     awful.key({var.modkey, "Control", "Shift"}, "#" .. i + 9,
                               function()
            if client.focus then
                local tag = client.focus.screen.tags[i]
                if tag then
                    client.focus:toggle_tag(tag)
                end
            end
        end, {
            description = "toggle focused client on tag #" .. i,
            group = group
        }))
    end

    return keys
end

---@param group string
---@return table
local client_keys = function(group)
    local keys = {
        awful.key({var.modkey}, "j", function()
            awful.client.focus.byidx(1)
        end, {description = "focus next by index", group = group}),

        awful.key({var.modkey}, "k", function()
            awful.client.focus.byidx(-1)
        end, {description = "focus previous by index", group = group}),

        awful.key({var.modkey, "Shift"}, "j", function()
            awful.client.swap.byidx(1)
        end, {description = "swap with next client by index", group = group}),

        awful.key({var.modkey, "Shift"}, "k", function()
            awful.client.swap.byidx(-1)
        end, {description = "swap with previous client by index", group = group}),

        awful.key({var.modkey}, "u", awful.client.urgent.jumpto,
                  {description = "jump to urgent client", group = group}),

        awful.key({var.modkey}, "Tab", function()
            awful.client.focus.history.previous()
            if client.focus then
                client.focus:raise()
            end
        end, {description = "go back", group = group}), -- Standard program

        awful.key({var.modkey, "Control"}, "n", function()
            local c = awful.client.restore()
            -- Focus restored client
            if c then
                c:emit_signal("request::activate", "key.unminimize",
                              {raise = true})
            end
        end, {description = "restore minimized", group = group}), -- Prompt

        awful.key({var.modkey}, "f", function(c)
            c.fullscreen = not c.fullscreen
            c:raise()
        end, {description = "toggle fullscreen", group = group}),

        awful.key({var.modkey}, "q", function(c)
            c:kill()
        end, {description = "close", group = group}),

        awful.key({var.modkey, "Control"}, "space",
                  awful.client.floating.toggle,
                  {description = "toggle floating", group = group}),

        awful.key({var.modkey, "Control"}, "Return", function(c)
            c:swap(awful.client.getmaster())
        end, {description = "move to master", group = group}),

        awful.key({var.modkey}, "o", function(c)
            c:move_to_screen()
        end, {description = "move to screen", group = group}),

        awful.key({var.modkey}, "t", function(c)
            c.ontop = not c.ontop
        end, {description = "toggle keep on top", group = group}),

        awful.key({var.modkey}, "n", function(c)
            -- The client currently has the input focus, so it cannot be
            -- minimized, since minimized clients can't have the focus.
            c.minimized = true
        end, {description = "minimize", group = group}),

        awful.key({var.modkey}, "m", function(c)
            c.maximized = not c.maximized
            c:raise()
        end, {description = "(un)maximize", group = group}),

        awful.key({var.modkey, "Control"}, "m", function(c)
            c.maximized_vertical = not c.maximized_vertical
            c:raise()
        end, {description = "(un)maximize vertically", group = group}),

        awful.key({var.modkey, "Shift"}, "m", function(c)
            c.maximized_horizontal = not c.maximized_horizontal
            c:raise()
        end, {description = "(un)maximize horizontally", group = group})
    }

    return keys
end

---@param group string
---@return table
local screen_keys = function(group)
    local keys = {
        awful.key({var.modkey, "Control"}, "j", function()
            awful.screen.focus_relative(1)
        end, {description = "focus the next screen", group = group}),

        awful.key({var.modkey, "Control"}, "k", function()
            awful.screen.focus_relative(-1)
        end, {description = "focus the previous screen", group = group})
    }
    return keys
end

---@param group string
---@return table
local layout_keys = function(group)
    local keys = {
        awful.key({var.modkey}, "l", function()
            awful.tag.incmwfact(0.05)
        end, {description = "increase master width factor", group = group}),

        awful.key({var.modkey}, "h", function()
            awful.tag.incmwfact(-0.05)
        end, {description = "decrease master width factor", group = group}),

        awful.key({var.modkey, "Shift"}, "h", function()
            awful.tag.incnmaster(1, nil, true)
        end, {
            description = "increase the number of master clients",
            group = group
        }),

        awful.key({var.modkey, "Shift"}, "l", function()
            awful.tag.incnmaster(-1, nil, true)
        end, {
            description = "decrease the number of master clients",
            group = group
        }),

        awful.key({var.modkey, "Control"}, "h", function()
            awful.tag.incncol(1, nil, true)
        end, {description = "increase the number of columns", group = group}),

        awful.key({var.modkey, "Control"}, "l", function()
            awful.tag.incncol(-1, nil, true)
        end, {description = "decrease the number of columns", group = group}),

        awful.key({var.modkey}, "space", function()
            awful.layout.inc(1)
        end, {description = "select next", group = group}),

        awful.key({var.modkey, "Shift"}, "space", function()
            awful.layout.inc(-1)
        end, {description = "select previous", group = group})

    }
    return keys
end

---@param group string
---@return table
local launcher_keys = function(group)
    local keys = {
        awful.key({var.modkey}, "Return", function()
            awful.spawn(terminal)
        end, {description = "open a terminal", group = group}),

        awful.key({var.modkey}, "r", function()
            awful.spawn("rofi -show drun")
        end, {description = "run prompt", group = group})
    }
    return keys
end

---@param volume VolumeWidget
---@param group string
---@return table
local volume_keys = function(volume, group)
    local keys = {
        awful.key({var.modkey}, "=", function()
            volume:increase(5)
        end, {description = "Increase volume", group = group}),

        awful.key({var.modkey}, "-", function()
            volume:decrease(5)
        end, {description = "Decrease volume", group = group}),

        awful.key({var.modkey}, "0", function()
            volume:toggle_mute()
        end, {description = "Toggle mute", group = group})
    }

    return keys
end

local clientbuttons = {
    awful.button({}, 1, function(c)
        c:emit_signal("request::activate", "mouse_click", {raise = true})
    end),
    awful.button({modkey}, 1, function(c)
        c:emit_signal("request::activate", "mouse_click", {raise = true})
        awful.mouse.client.move(c)
    end),
    awful.button({modkey}, 3, function(c)
        c:emit_signal("request::activate", "mouse_click", {raise = true})
        awful.mouse.client.resize(c)
    end)
}

local join = function(t1, t2)
    for _, v in ipairs(t2) do
        t1[#t1 + 1] = v
    end
end

local M = {
    clientkeys = gears.table.join(table.unpack(client_keys("client"))),
    clientbuttons = gears.table.join(table.unpack(clientbuttons)),
    ---@param wibar MyWibar
    globalkeys = function(wibar)
        local keys = {}

        join(keys, awesome_keys("awesome"))
        join(keys, tag_keys("tag"))
        join(keys, screen_keys("screen"))
        join(keys, layout_keys("layout"))
        join(keys, launcher_keys("launcher"))
        join(keys, volume_keys(wibar:get_volume_widget(), "volume"))

        return gears.table.join(table.unpack(keys))
    end
}

return M
