dofile('override-defaults.lua')
dofile('key-mappings.lua')
dofile('window-resize.lua')

local Keys = require('constants')

local editting = {}

editting.cW = hs.hotkey.bind(Keys.C, "w", function()
    hs.eventtap.keyStroke({"alt"}, "delete")
end)

editting.cM = hs.hotkey.bind(Keys.C, "m", function()
    hs.eventtap.keyStroke({""}, "return")
end)

editting.cE = hs.hotkey.bind(Keys.C, "e", function()
    hs.eventtap.keyStroke({"cmd"}, "right")
end)

editting.cR = hs.hotkey.bind(Keys.C, "r",
                             function() hs.eventtap.keyStroke({}, "delete") end)

editting.cB = hs.hotkey.bind(Keys.C, "b", function()
    hs.eventtap.keyStroke({"alt"}, "left")
end)

editting.cF = hs.hotkey.bind(Keys.C, "f", function()
    hs.eventtap.keyStroke({"alt"}, "right")
end)

-- disable alt-v for Adobe's built-in shortcut
function applicationWatcher(appName, eventType, appObject)
    if (eventType == hs.application.watcher.activated) then
        for i, v in pairs(editting) do v:enable() end
        if (string.find(appName, "iTerm") or (string.find(appName, "VIM")) or
            (string.find(appName, "Alacritty"))) then
            for i, v in pairs(editting) do v:disable() end
        elseif not (string.find(appName, "iTerm") or
            (string.find(appName, "VIM")) or (string.find(appName, "Alacritty"))) then
            for i, v in pairs(editting) do v:enable() end
        end
    end
end

appWatcher = hs.application.watcher.new(applicationWatcher)

appWatcher:start()

hs.alert.show("Config loaded")
