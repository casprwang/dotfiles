local Keys = require('constants')

local ResizeMappings = {
    h = {x = 0, y = 0, w = 0.5, h = 1},
    u = {x = 0, y = 0, w = 0.5, h = 0.5},
    o = {x = 0.5, y = 0, w = 0.5, h = 0.5},
    m = {x = 0.15, y = 0.15, w = 0.7, h = 0.7},
    k = {x = 0, y = 0, w = 1, h = 0.5},
    j = {x = 0, y = 0.5, w = 1, h = 0.5},
    l = {x = 0.5, y = 0, w = 0.5, h = 1},
    n = {x = 0, y = 0, w = 1, h = 1},
    i = {x = 0.2, y = 0, w = 0.6, h = 1}
}

for key in pairs(ResizeMappings) do
    hs.hotkey.bind(Keys.ALT, key, function()
        local win = hs.window.focusedWindow()
        if win then win:moveToUnit(ResizeMappings[key]) end
    end)
end
