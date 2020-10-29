local KEYS = require('constants').KEYS

hs.hotkey.bind(KEYS.CC, "e", function()
    hs.alert.show("connecting airpods")
    hs.execute("/bin/zsh -i -c 'blue_on'", true)
end, 0)

hs.hotkey.bind(KEYS.CC, "r", function() hs.reload() end, 0)

-- hs.hotkey.bind(KEYS.A, "j", function()
--     local win = hs.window.focusedWindow()
--     local y = win:frame().y
--     local x = win:frame().x
--     if win then
--         win:setTopLeft(hs.geometry.point(x, y))
--         win:setSize(win:size():scale({1, 1.33}))
--     end
-- end, 0)

-- hs.hotkey.bind(KEYS.A, "k", function()
--     local win = hs.window.focusedWindow()
--     local y = win:frame().y
--     local x = win:frame().x
--     if win then
--         win:setTopLeft(hs.geometry.point(x, y))
--         win:setSize(win:size():scale({1, 0.75}))
--     end
-- end, 0)

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

