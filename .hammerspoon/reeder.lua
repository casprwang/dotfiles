local Reeder = {bindings = {}}

-- Reeder.bindings.c1 = hs.hotkey.bind({"cmd"}, "1", function()
--     hs.eventtap.keyStroke({"alt"}, "2", 0)
--     hs.eventtap.keyStroke({"alt"}, "2", 0)
-- end)

-- Reeder.bindings.c2 = hs.hotkey.bind({"cmd"}, "2", function()
--     hs.eventtap.keyStroke({"alt"}, "1", 0)
--     hs.eventtap.keyStroke({"alt"}, "1", 0)
-- end)

-- Reeder.bindings.c3 = hs.hotkey.bind({"cmd"}, "3", function()
--     hs.eventtap.keyStroke({"alt"}, "3", 0)
--     hs.eventtap.keyStroke({"alt"}, "3", 0)
-- end)

function Reeder:enable() for _, v in pairs(self.bindings) do v:enable() end end
function Reeder:disable() for _, v in pairs(self.bindings) do v:disable() end end

return Reeder
