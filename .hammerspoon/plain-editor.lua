local KEYS = require('constants').KEYS
local PlainEditor = {bindings = {}}

PlainEditor.bindings.cW = hs.hotkey.bind(KEYS.C, "w", function()
    hs.eventtap.keyStroke({"alt"}, "delete", 0)
end)

PlainEditor.bindings.cM = hs.hotkey.bind(KEYS.C, "m", function()
    hs.eventtap.keyStroke({""}, "return", 0)
end)

PlainEditor.bindings.cE = hs.hotkey.bind(KEYS.C, "e", function()
    hs.eventtap.keyStroke({"cmd"}, "right", 0)
end)

PlainEditor.bindings.cB = hs.hotkey.bind(KEYS.C, "b", function()
    hs.eventtap.keyStroke({"alt"}, "left", 0)
end)

PlainEditor.bindings.cF = hs.hotkey.bind(KEYS.C, "f", function()
    hs.eventtap.keyStroke({"alt"}, "right", 0)
end)

function PlainEditor:enable() for _, v in pairs(self.bindings) do v:enable() end end

function PlainEditor:disable()
    for _, v in pairs(self.bindings) do v:disable() end
end

return PlainEditor
