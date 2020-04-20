local Keys = require('constants')
local trim = require('utils')

-- For testing
hs.hotkey.bind(
  Keys.CC,
  "e",
  function()
    hs.alert.show(trim("etst"))
  end
)


hs.hotkey.bind(
  Keys.CS,
  "b",
  function()
    hs.eventtap.keyStroke({"alt", "shift"}, "left")
  end
)

hs.hotkey.bind(
  Keys.CS,
  "f",
  function()
    hs.eventtap.keyStroke({"alt", "shift"}, "right")
  end
)

hs.hotkey.bind(
  Keys.CS,
  "h",
  function()
    hs.eventtap.keyStroke({"shift"}, "left")
  end
)

hs.hotkey.bind(
  Keys.CS,
  "l",
  function()
    hs.eventtap.keyStroke({"shift"}, "right")
  end
)

hs.hotkey.bind(
  Keys.C,
  "i",
  function()
    hs.eventtap.keyStroke({}, "delete")
  end
)


hs.hotkey.bind(
  Keys.C,
  "q",
  function()
    hs.eventtap.keyStroke({}, "delete")
  end
)



hs.hotkey.bind(
  Keys.CC,
  "w",
  function()
    local output = hs.execute("/usr/local/bin/zsh -i -c 'wifi toggle'", true)
    hs.alert.show(trim(output))
  end
)


hs.hotkey.bind(
  Keys.CC,
  "r",
  function()
    hs.reload()
  end
)

