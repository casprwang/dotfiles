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



hs.hotkey.bind({'ctrl'}, ";",
               function() 
                    hs.eventtap.leftClick(hs.mouse.getAbsolutePosition(), 0)
               end)


-- Mouse side buttons
local ev = hs.eventtap.event

mouseButton = hs.eventtap.new(
    {ev.types.otherMouseDown},
    function(e)
      local button = e:getProperty(
        hs.eventtap.event.properties['mouseEventButtonNumber']
      )
      if button == 4 then
          hs.eventtap.event.newKeyEvent("j", true):post()
          hs.eventtap.event.newKeyEvent("j", false):post()
      elseif button == 3 then
        hs.eventtap.event.newKeyEvent("k", true):post()
        hs.eventtap.event.newKeyEvent("k", false):post()
      end
    end
):start()
