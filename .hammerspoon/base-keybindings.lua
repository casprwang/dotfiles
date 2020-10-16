local KEYS = require('constants').KEYS

hs.hotkey.bind(KEYS.CC, "e", function()
    hs.alert.show("connecting airpods")
    hs.execute("/bin/zsh -i -c 'blue_on'", true)
end)

hs.hotkey.bind(KEYS.CC, "r", function() hs.reload() end)
hs.alert.show("Config loaded")

hs.hotkey.bind(KEYS.ALT, "j", function()
    local win = hs.window.focusedWindow()
    local y = win:frame().y
    local x = win:frame().x
    if win then
        win:setTopLeft(hs.geometry.point(x, y))
        win:setSize(win:size():scale({1, 1.33}))
    end
end)

hs.hotkey.bind(KEYS.ALT, "k", function()
    local win = hs.window.focusedWindow()
    local y = win:frame().y
    local x = win:frame().x
    if win then
        win:setTopLeft(hs.geometry.point(x, y))
        win:setSize(win:size():scale({1, 0.75}))
    end
end)
