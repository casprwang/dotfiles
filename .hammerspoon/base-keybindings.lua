local KEYS = require('constants').KEYS

hs.hotkey.bind(KEYS.CC, "e", function()
    hs.alert.show("connecting airpods")
    hs.execute("/bin/zsh -i -c 'blue_on'", true)
end, 0)

hs.hotkey.bind(KEYS.CC, "r", function() hs.reload() end, 0)

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

