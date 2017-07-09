-- local music = require("hs-music")
hs.window.animationDuration = 0.1 -- shorten animations

-- stroing the leader keys
keys = {
    a   = { "alt"  },
    c   = { "ctrl" },
    cs  = { "ctrl", "shift" },
    ca  = { "ctrl", "alt"},
}


-- for testing new bindings 
hs.hotkey.bind(keys.ca, "t", function()
    -- hs.alert.show(hs.window.focusedWindow().title())

    -- hs.messages.iMessage('wangsongiam@gmail.com', 'hellow')
    -- hs.spotify.displayCurrentTrack()

    -- hs.osascript.javascript('let a = 1;')
end)

appPath = {
    -- Code="/Applications/Visual Studio Code.app",
    iTerm2="/Applications/iTerm.app",
    Tweetbot="/Applications/Tweetbot.app",
}

-- print(hs.application:title())

-- print(hs.application.runningApplications())

-- switching between screens
hs.hotkey.bind({"ctrl"}, 'escape', function ()
  focusScreen(hs.window.focusedWindow():screen():next())
end)

-- showing the current time
hs.hotkey.bind({"cmd", "alt", "shift"}, "t", function()
  local time = hs.timer.localTime()
  local x = math.floor(time/3600)
  local y = math.floor((time - x * 3600)/60)
  hs.alert.show(tostring(x)..":"..tostring(y))
end)


--Predicate that checks if a window belongs to a screen
function isInScreen(screen, win)
  return win:screen() == screen
end

function focusScreen(screen)
  --Get windows within screen, ordered from front to back.
  --If no windows exist, bring focus to desktop. Otherwise, set focus on
  --front-most application window.
  local windows = hs.fnutils.filter(
      hs.window.orderedWindows(),
      hs.fnutils.partial(isInScreen, screen))
  local windowToFocus = #windows > 0 and windows[1] or hs.window.desktop()
  windowToFocus:focus()

  -- Move mouse to center of screen
  local pt = hs.geometry.rectMidPoint(screen:fullFrame())
  hs.mouse.setAbsolutePosition(pt)
end


hs.screen.mainScreen():name()
-- shortcut for general test

-- Toggle an application between being the frontmost app, and being hidden
-- Application hotkeys
-- hyperalts = {
--     -- a="Airmail",
--     -- e="Finder",
--     v="Code",
--     -- s="Safari",
--     -- m="iTunes",
--     -- t="Tweetbot",
-- }

-- function altFunctions(keys)
-- end

-- -- Nudge window by grid
-- -- hs.hotkey.bind(keys.ca, "right", function() hs.grid.pushWindowRight() end)
-- -- hs.hotkey.bind(keys.ca, "left", function() hs.grid.pushWindowLeft() end)
-- -- hs.hotkey.bind(keys.ca, "up", function() hs.grid.pushWindowUp() end)
-- -- hs.hotkey.bind(keys.ca, "down", function() hs.grid.pushWindowDown() end)
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


-- delay = hs.eventtap.keyRepeatDelay()
delay = 0.1
-- local hs.eventtap.keyRepeatDelay() = 0.1

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

local showtime =hs.hotkey.bind({"cmd","ctrl", "shift"}, "r", function()
    local time = hs.timer.localTime()
    local x = math.floor(time/3600)
    local y = math.floor((time - x * 3600)/60)
    hs.alert.show(tostring(x)..":"..tostring(y))
    hs.alert.show(hs.eventtap.keyRepeatDelay()
        )
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


hs.hotkey.bind(keys.a, 'j', function ()
    local win=hs.window.focusedWindow()
    if win then
        win:setSize(win:size():scale({1, 1.5}))
    end
end)

hs.hotkey.bind(keys.a, 'k', function ()
    local win=hs.window.focusedWindow()
    if win then
        win:setSize(win:size():scale({1, 0.75}))
    end
end)


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

-- editting = {
--   cW = {hs.hotkey.bind(keys.c, "w", function()
--     hs.eventtap.keyStroke({'alt'}, "delete")
-- end)},
--   cD = {hs.hotkey.bind(keys.c, "d", function()
--     hs.eventtap.keyStroke({'alt'}, "right", 0)
--     hs.eventtap.keyStroke({'alt'}, "delete", 0)
-- end)}
-- }

editting = {
}

editting.cW= hs.hotkey.bind(keys.c, "w", function()
    hs.eventtap.keyStroke({'alt'}, "delete")
end)

editting.cM= hs.hotkey.bind(keys.c, "m", function()
    hs.eventtap.keyStroke("return")
end)

-- editting.cD = hs.hotkey.bind(keys.c, "d", function()
--     hs.eventtap.keyStroke({'alt'}, "right", 0)
--     hs.eventtap.keyStroke({'alt'}, "delete", 0)
-- end)

editting.cQ = hs.hotkey.bind(keys.c, "q", function()
    hs.eventtap.keyStroke({'cmd'}, "delete")
end)
-- editting.cQ:enable(postgresq)

editting.cB = hs.hotkey.bind(keys.c, "b", function()
    hs.eventtap.keyStroke({'alt'}, "left")
end)

editting.cF = hs.hotkey.bind(keys.c, "f", function()
    hs.eventtap.keyStroke({'alt'}, "right")
end)



ctrl_shift = { 'ctrl', 'shift' }
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

function toggle_application(_app, path)
    -- Finds running applications
    local app = hs.application.find(_app)
    if app:isFrontmost() then
        app:hide()
        -- hs.alert.show(app:isRunning())
    elseif not app:isFrontmost() then
        -- hs.alert.show('haha')
        hs.application.launchOrFocus(path)
    end
end

-- altV =hs.hotkey.bind(keys.a, "v", function()
--     toggle_application("Code",appPath.Code)
-- end)

hs.hotkey.bind(keys.a, "t", function()
    toggle_application('Tweetbot', appPath.Tweetbot)
end)


-- disable alt-v for Adobe's built-in shortcut
function applicationWatcher(appName, eventType, appObject)
    if (eventType == hs.application.watcher.activated) then
      for i,v in pairs(editting) do
        v:enable()
      end
        if (string.find(appName, 'iTerm') or (string.find(appName, 'VIM'))) then
            for i,v in pairs(editting) do
                v:disable()
            end
        elseif not (string.find(appName, 'Emacs')) then
            for i,v in pairs(editting) do
                v:enable()
            end
        end
        if (string.find(appName, 'Emacs')) then
            for i,v in pairs(editting) do
                v:disable()
            end
        elseif not (string.find(appName, 'iTerm') or ( string.find(appName, 'VIM') )) then
            for i,v in pairs(editting) do
                v:enable()
            end
        end
    end
end

appWatcher = hs.application.watcher.new(applicationWatcher)
appWatcher:start()
