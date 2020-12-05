local Shift = {bindings = {}}


Shift.bindings.right = hs.hotkey.bind({'ctrl'}, "tab", function()
    -- https://github.com/Hammerspoon/hammerspoon/issues/1984
    hs.eventtap.event.newKeyEvent(hs.keycodes.map.cmd, true):post()
    hs.eventtap.event.newKeyEvent(hs.keycodes.map.alt, true):post()
    hs.eventtap.event.newKeyEvent("down", true):post()
    hs.eventtap.event.newKeyEvent("down", false):post()
    hs.eventtap.event.newKeyEvent(hs.keycodes.map.alt, false):post()
    hs.eventtap.event.newKeyEvent(hs.keycodes.map.cmd, false):post()
end)


Shift.bindings.left = hs.hotkey.bind({'ctrl', 'shift'}, "tab", function()
    hs.eventtap.event.newKeyEvent(hs.keycodes.map.cmd, true):post()
    hs.eventtap.event.newKeyEvent(hs.keycodes.map.alt, true):post()
    hs.eventtap.event.newKeyEvent("up", true):post()
    hs.eventtap.event.newKeyEvent("up", false):post()
    hs.eventtap.event.newKeyEvent(hs.keycodes.map.alt, false):post()
    hs.eventtap.event.newKeyEvent(hs.keycodes.map.cmd, false):post()
end)

function Shift:enable() for _, v in pairs(self.bindings) do v:enable() end end
function Shift:disable() for _, v in pairs(self.bindings) do v:disable() end end

return Shift
