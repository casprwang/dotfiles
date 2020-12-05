local reeder = require('reeder')
local plainEditor = require('plain-editor')
local utils = require('utils')
local obsidian = require('obsidian')
local shift = require('shift')

local M = {}

hs.hotkey.bind({'ctrl'}, "j", function()
    hs.eventtap.keyStroke({}, 'down', 0)
end)

hs.hotkey.bind({'ctrl'}, "k", function()
    hs.eventtap.keyStroke({}, 'up', 0)
end)

hs.hotkey.bind({'ctrl'}, "h", function()
    hs.eventtap.keyStroke({}, 'left', 0)
end)

hs.hotkey.bind({'ctrl'}, "l", function()
    hs.eventtap.keyStroke({}, 'right', 0)
end)

-- disable alt-v for Adobe's built-in shortcut
local function applicationWatcher(appName, eventType)
    if (eventType == hs.application.watcher.activated) then
        -- obsidian
        if (appName == "Obsidian") then
            obsidian:enable()
        else
            obsidian:disable()
        end


        if (appName == "Shift") then
            shift:enable()
        else
            shift:disable()
        end

        -- terminal
        if not utils.isTerm(appName) then
            plainEditor:enable()
        else
            plainEditor:disable()
        end

        -- reeder
        if (appName == "Reeder") then
            reeder:enable()
        else
            reeder:disable()
        end
    end
end

local function init()
    watcher = hs.application.watcher.new(applicationWatcher)
    watcher:start()
end

M.init = init
return M
