local KEYS = require('constants').KEYS

local M = {}
local editting = {} -- lua array list

editting.cW = hs.hotkey.bind(KEYS.C, "w", function()
    hs.eventtap.keyStroke({"alt"}, "delete", 0)
end)

editting.cM = hs.hotkey.bind(KEYS.C, "m", function()
    hs.eventtap.keyStroke({""}, "return", 0)
end)

editting.cE = hs.hotkey.bind(KEYS.C, "e", function()
    hs.eventtap.keyStroke({"cmd"}, "right", 0)
end)

editting.cB = hs.hotkey.bind(KEYS.C, "b", function()
    hs.eventtap.keyStroke({"alt"}, "left", 0)
end)

editting.cF = hs.hotkey.bind(KEYS.C, "f", function()
    hs.eventtap.keyStroke({"alt"}, "right", 0)
end)

-- selecting words
hs.hotkey.bind(KEYS.CS, "b", function()
    hs.eventtap.keyStroke({"alt", "shift"}, "left", 0)
end)

hs.hotkey.bind(KEYS.CS, "f", function()
    hs.eventtap.keyStroke({"alt", "shift"}, "right", 0)
end)

hs.hotkey.bind(KEYS.CS, "h",
               function() hs.eventtap.keyStroke({"shift"}, "left", 0) end)

hs.hotkey.bind(KEYS.CS, "l",
               function() hs.eventtap.keyStroke({"shift"}, "right", 0) end)

local obsidian = hs.hotkey.bind({"cmd"}, "return", function()
    hs.eventtap.keyStroke({"alt"}, "return", 0)
    hs.eventtap.keyStroke({"alt"}, "return", 0)
end)

-- disable alt-v for Adobe's built-in shortcut
local function applicationWatcher(appName, eventType)
    if (eventType == hs.application.watcher.activated) then
        if (appName == "Obsidian") then obsidian:enable() end
        for _, v in pairs(editting) do v:enable() end
        if (appName == "iTerm") or (appName == "VIM") or
            (appName == "Alacritty") then
            for _, v in pairs(editting) do v:disable() end
        elseif not (appName == "iTerm") or (appName == "VIM") or
            (appName == "Alacritty") then
            for _, v in pairs(editting) do v:enable() end
        end
    elseif (eventType == hs.application.watcher.deactivated) then
        if (appName == "Obsidian") then obsidian:disable() end
    end
end

local function init()
    watcher = hs.application.watcher.new(applicationWatcher)
    watcher:start()
end

M.init = init
return M
