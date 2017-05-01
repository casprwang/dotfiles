-- local music = require("hs-music")
hs.window.animationDuration = 0.1 -- shorten animations


keys = {
    a   = { "alt"  },
    c   = { "ctrl" },
    cs  = { "ctrl", "shift" },
    ca  = { "ctrl", "alt"},
}

-- Toggle an application between being the frontmost app, and being hidden
function toggle_application(_app)
    local app = hs.appfinder.appFromName(_app)
    if not app then
        hs.application.launchOrFocus(_app)
        return
    end
    local mainwin = app:mainWindow()
    if mainwin then
        if mainwin == hs.window.focusedWindow() then
            mainwin:application():hide()
        else
            mainwin:application():activate(true)
            mainwin:application():unhide()
            mainwin:focus()
        end
    end
end

-- Application hotkeys
-- hyperalts = {
--     a="Airmail",
--     -- e="Finder",
--     -- v="Code",
--     s="Safari",
--     m="iTunes",
--     t="Tweetbot",
-- }

-- function altFunctions(keys)
-- end


-- Nudge window by grid
-- hs.hotkey.bind(keys.ca, "right", function() hs.grid.pushWindowRight() end)
-- hs.hotkey.bind(keys.ca, "left", function() hs.grid.pushWindowLeft() end)
-- hs.hotkey.bind(keys.ca, "up", function() hs.grid.pushWindowUp() end)
-- hs.hotkey.bind(keys.ca, "down", function() hs.grid.pushWindowDown() end)
-- for _hotkey in pairs(hyperalts) do
--     hs.hotkey.bind({"alt"}, _hotkey, function() toggle_application(hyperalts[_hotkey]) end)
-- end

local function keyCode(key)
    modifiers = modifiers or {}
    return function()
        hs.eventtap.event.newKeyEvent(modifiers, string.lower(key), true):post()
        hs.timer.usleep(1000)
        hs.eventtap.event.newKeyEvent(modifiers, string.lower(key), false):post()
    end
end


delay = hs.eventtap.keyRepeatDelay()
delay = 0.1

hs.hotkey.bind(keys.c, 'h', keyCode('left') ,  nil,   keyCode('left'))
hs.hotkey.bind(keys.c, 'j', keyCode('down') ,  nil,   keyCode('down') )
hs.hotkey.bind(keys.c, 'k', keyCode('up')   ,  nil,   keyCode('up') )
hs.hotkey.bind(keys.c, 'l', keyCode('right'),  nil,   keyCode('right') )


-------------------------------------------------------------------------------
hs.hotkey.bind({"cmd","ctrl", "shift"}, "w", function()
    hs.grid.show()
    -- hs.alert.show("!!!!!!!!!!⚠️  Fuck the Fuck off  ⚠️!!!!!!!!!!")
    -- hs.alert.show(delay)
end)

hs.hotkey.bind({"cmd","ctrl", "shift"}, "r", function()
    local time = hs.timer.localTime()
    local x = math.floor(time/3600)
    local y = math.floor((time - x * 3600)/60)
    hs.alert.show(tostring(x)..":"..tostring(y))
    -- hs.alert.show(hs.window.focusedWindow())
    -- hs.alert.show(tostring(y))
end)

function reloadConfig(files)
    doReload = false
    for _,file in pairs(files) do
        if file:sub(-4) == ".lua" then
            doReload = true
        end
    end
    if doReload then
        hs.reload()
    end
end
local myWatcher = hs.pathwatcher.new(os.getenv("HOME") .. "/.hammerspoon/", reloadConfig):start()
hs.alert.show("Config loaded")



-- resizing window
-- local altKey = {"alt"}

-- local resizeMappings = {
--     h={0.5, 1},
--     l={1, 0.5},
-- }

-- for key in pairs(resizeMappings) do
--     hs.hotkey.bind(altKey, key, function()
--         local win = hs.window.focusedWindow()
--         if win then win:setSize(win:size():scale(resizeMappings[key])) end
--     end)
-- end

-- hs.hotkey.bind(altKey, key, function()
--     local win = hs.window.focusedWindow()
--     if win then win:setSize(win:size():scale({1, 0.5}))
--     end
-- end)

hs.hotkey.bind(keys.a, 'j', function ()
    local win=hs.window.focusedWindow()
    if win then
        win:setSize(win:size():scale({1, 2}))
    end
end)

hs.hotkey.bind(keys.a, 'k', function ()
    local win=hs.window.focusedWindow()
    if win then
        win:setSize(win:size():scale({1, 0.5}))
    end
end)


-- hs.hotkey.bind(keys.a, 'l', function ()
--     local win=hs.window.focusedWindow()
--     if win then
--         win:setSize(win:size():scale({0.5, 1}))
--     end
-- end)


-- hs.hotkey.bind(keys.a, 'h', function ()
--     local win=hs.window.focusedWindow()
--     if win then
--         win:setSize(win:size():scale({1, 0.5}))
--     end
-- end)

local resizeMappings = {
    h={x=0, y=0, w=0.5, h=1},
    -- j={x=0, y=0.5, w=1, h=0.5},
    -- J={x=0, y=0.2, w=1, h=0.5},
    -- k={x=0, y=0, w=1, h=0.5},
    -- K={x=0, y=0, w=1, h=0.5},
    l={x=0.5, y=0, w=0.5, h=1},
    n={x=0, y=0, w=1, h=1},
    -- u={x=0, y=0, w=0.33, h=1},
    i={x=0.2, y=0, w=0.6, h=1},
    -- o={x=0.33, y=0, w=0.67, h=0.5},
}


for key in pairs(resizeMappings) do
    hs.hotkey.bind(keys.a, key, function()
        local win = hs.window.focusedWindow()
        if win then win:moveToUnit(resizeMappings[key]) end
    end)
end

---------------------------------------------------------------------------------

--   hs.eventtap.keyStroke({}, 'delete')
--   lastCommand = dWordBack
--   dMode.exit()
-- end





-- hs.hotkey.bind({"cmd", "ctrl"}, "R", function()
--   hs.reload()
-- end)
-- hs.alert.show("Config loaded")

-- hs.eventtap.keyRepeatInterval() = 0.03
-- hs.eventtap.keyRepeatInterval = 0.1
-- hs.alert.show(hs.eventtap.keyRepeatInterval())

-- hs.eventtap.keyRepeatInterval() -> 1

-- ctrl-w to delete the word left
--
-- hs.hotkey.bind({"alt"}, 'delete', delete_word_backward, nil, delete_word_backward)
--
-- local function delete_word_backward()
--   hs.eventtap.keyStroke({"alt", "shift"}, "Left")
--   hs.eventtap.keyStroke({}, "delete")
-- end




-- -- bind ctrl-w to delete word backward
-- hs.hotkey.bind({'ctrl'}, "w", function()
--     hs.eventtap.keyStroke({'alt'}, "delete")
-- end)

hs.hotkey.bind(keys.c, "w", function()
    hs.eventtap.keyStroke({'alt'}, "delete")
end)

hs.hotkey.bind(keys.c, "q", function()
    hs.eventtap.keyStroke({'cmd'}, "delete")
end)

hs.hotkey.bind(keys.c, "b", function()
    hs.eventtap.keyStroke({'alt'}, "left")
end)

hs.hotkey.bind(keys.c, "f", function()
    hs.eventtap.keyStroke({'alt'}, "right")
end)



local ctrl_shift = { 'ctrl', 'shift' }
-- selecting words
hs.hotkey.bind(keys.cs, "b", function()
    hs.eventtap.keyStroke({'alt', 'shift'}, "left")
end)

hs.hotkey.bind(keys.cs, "f", function()
    hs.eventtap.keyStroke({'alt', 'shift'}, "right")
end)

hs.hotkey.bind(keys.cs, "h", function()
    hs.eventtap.keyStroke({'shift'}, "left")
end)

hs.hotkey.bind(keys.cs, "l", function()
    hs.eventtap.keyStroke({'shift'}, "right")
end)

hs.hotkey.bind(keys.c, "g", function()
    hs.eventtap.keyStroke({}, "delete")
end)

-- disable alt-v for Adobe's built-in shortcut
function applicationWatcher(appName, eventType, appObject)
    if (eventType == hs.application.watcher.activated) then
        if (string.find(appName, 'Adobe')) then
            hs.hotkey.bind(keys.a, "v", function()
                hs.eventtap.keyStroke(keys.a, "v")
            end)
        else
            hs.hotkey.bind(keys.a, 'v', function() toggle_application("Code") end)
            -- hs.hotkey.bind({"alt"}, _hotkey, function() toggle_application(hyperalts[_hotkey]) end)
        end
        -- hs.alert.show(appName)
        -- hs.alert.show(hyperalts['a'])
        -- hs.alert.show(os.date("!%Y-%m-%d-%T"))
        -- Bring all Finder windows forward when one gets activated
        -- appObject:selectMenuItem({"Window", "Bring All to Front"})
    end
end
-- end
local appWatcher = hs.application.watcher.new(applicationWatcher)
appWatcher:start()
