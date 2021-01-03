local KEYS = require('constants').KEYS

local resizeMappings = {
    h = {x = 0, y = 0, w = 0.5, h = 1},
    j = {x = 0.25, y = 0.35, w = 0.5, h = 0.65},
    u = {x = 0, y = 0, w = 0.5, h = 0.5},
    o = {x = 0.5, y = 0, w = 0.5, h = 0.5},
    m = {x = 0.5, y = 0.5, w = 0.5, h = 0.5},
    l = {x = 0.5, y = 0, w = 0.5, h = 1},
    n = {x = 0, y = 0, w = 1, h = 1},
    i = {x = 0.2, y = 0, w = 0.8, h = 1}
}

for key in pairs(resizeMappings) do
    hs.hotkey.bind(KEYS.A, key, function()
        local win = hs.window.focusedWindow()
        if win then win:moveToUnit(resizeMappings[key]) end
    end, 0)
end
