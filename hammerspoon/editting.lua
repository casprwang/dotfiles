-- key mappings for fast writting and editting text
local Keys = require('constants')

local editting = {}

editting.cW = hs.hotkey.new(Keys.C, "w", function()
    hs.eventtap.keyStroke({"alt"}, "delete")
end)

editting.cM = hs.hotkey.new(Keys.C, "m", function()
    hs.eventtap.keyStroke({""}, "return")
end)

editting.cE = hs.hotkey.new(Keys.C, "e", function()
    hs.eventtap.keyStroke({"cmd"}, "right")
end)

editting.cR = hs.hotkey.new(Keys.C, "r",
                             function() hs.eventtap.keyStroke({}, "delete") end)

editting.cB = hs.hotkey.new(Keys.C, "b", function()
    hs.eventtap.keyStroke({"alt"}, "left")
end)

editting.cF = hs.hotkey.new(Keys.C, "f", function()
    hs.eventtap.keyStroke({"alt"}, "right")
end)

local function enableEdittingKeys()
  for _, v in pairs(editting) do v:enable() end
end


local function disableEdittingKeys()
  for _, v in pairs(editting) do v:disable() end
end

