-- key mappings for fast writting and editting text
local Keys = require('constants')
local Module = {}
local keyMap = {}

keyMap.cW = hs.hotkey.bind(Keys.C, "w", function()
    hs.eventtap.keyStroke({"alt"}, "delete")
end)

keyMap.cM = hs.hotkey.bind(Keys.C, "m", function()
    hs.eventtap.keyStroke({""}, "return")
end)

keyMap.cE = hs.hotkey.bind(Keys.C, "e", function()
    hs.eventtap.keyStroke({"cmd"}, "right")
end)

keyMap.cR = hs.hotkey.bind(Keys.C, "r",
                            function() hs.eventtap.keyStroke({}, "delete") end)

keyMap.cB = hs.hotkey.bind(Keys.C, "b", function()
    hs.eventtap.keyStroke({"alt"}, "left")
end)

keyMap.cF = hs.hotkey.bind(Keys.C, "f", function()
    hs.eventtap.keyStroke({"alt"}, "right")
end)


Module.enableEdittingKeys = function () for _, v in pairs(keyMap) do v:enable() end end

Module.disableEdittingKeys = function()
    for _, v in pairs(keyMap) do v:disable() end
end

return Module
