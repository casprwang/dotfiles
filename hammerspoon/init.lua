-- require("reload-config")

hs.window.animationDuration = 0 -- shorten animations
hs.alert.defaultStyle.radius = 2
hs.alert.defaultStyle.textSize = 55
hs.alert.defaultStyle.textFont = "Monaco"
hs.alert.defaultStyle.strokeColor = {black = 0, alpha = 0}
hs.alert.defaultStyle.strokeWidth = 0
hs.alert.defaultStyle.textStyle = {paragraphStyle = {alignment = "center"}}

KEYS = {
  ALT = {"alt"},
  C   =   {"ctrl"},
  CS = {"ctrl", "shift"},
  CA = {"ctrl", "alt"},
  HYPER = {"cmd", "alt", "shift"}
}

-- for testing new bindings
hs.hotkey.bind(
  KEYS.CA,
  "8",
  function()
    hs.alert.show(hs.window.focusedWindow())
  end
)


-- showing the current time
local id
hs.hotkey.bind(
  KEYS.HYPER,
  "6",
  function()
    local display = "Be back in a minute"
    id = hs.alert.show(display, 10000)
  end
)

-- remove trailing and leading whitespace from string.
-- http://en.wikipedia.org/wiki/Trim_(programming)
function trim(s)
  -- from PiL2 20.4
  return (s:gsub("^%s*(.-)%s*$", "%1"))
end

hs.hotkey.bind(
  {"cmd", "ctrl"},
  "w",
  function()
    local output = hs.execute("/usr/local/bin/zsh -i -c 'wifi toggle'", true)
    hs.alert.show(trim(output))
  end
)


hs.hotkey.bind(
  {"cmd", "ctrl"},
  "e",
  function()
    local output = hs.execute("/usr/local/bin/zsh -i -c 'check_network'", true)
    hs.alert.show(trim(output))
  end
)


--Predicate that checks if a window belongs to a screen
function isInScreen(screen, win)
  return win:screen() == screen
end

function focusScreen(screen)
  --Get windows within screen, ordered from front to back.
  --If no windows exist, bring focus to desktop. Otherwise, set focus on
  --front-most application window.
  local windows = hs.fnutils.filter(hs.window.orderedWindows(), hs.fnutils.partial(isInScreen, screen))
  local windowToFocus = #windows > 0 and windows[1] or hs.window.desktop()
  windowToFocus:focus()

  -- Move mouse to center of screen
  local pt = hs.geometry.rectMidPoint(screen:fullFrame())
  hs.mouse.setAbsolutePosition(pt)
end

hs.screen.mainScreen():name()

local function keyCode(key)
  modifiers = modifiers or {}
  return function()
    hs.eventtap.event.newKeyEvent(modifiers, string.lower(key), true):post()
    hs.timer.usleep(1000)
    hs.eventtap.event.newKeyEvent(modifiers, string.lower(key), false):post()
  end
end

local delay = 0.1

local showtime =
  hs.hotkey.bind(
  {"cmd", "ctrl"},
  "t",
  function()
    local time = hs.timer.localTime()
    local x = math.floor(time / 3600)
    local y = math.floor((time - x * 3600) / 60)
    hs.alert.show(tostring(x) .. ":" .. tostring(y))
  end
)

hs.hotkey.bind(
  {"cmd", "ctrl"},
  "r",
  function()
    hs.reload()
  end
)
hs.alert.show("Config loaded")

hs.hotkey.bind(
  KEYS.ALT,
  "j",
  function()
    local win = hs.window.focusedWindow()
    local y = win:frame().y
    local x = win:frame().x
    if win then
      win:setTopLeft(hs.geometry.point(x, y))
      win:setSize(win:size():scale({1, 1.33}))
    end
  end
)

hs.hotkey.bind(
  KEYS.ALT,
  "k",
  function()
    local win = hs.window.focusedWindow()
    local y = win:frame().y
    local x = win:frame().x
    if win then
      win:setTopLeft(hs.geometry.point(x, y))
      win:setSize(win:size():scale({1, 0.75}))
    end
  end
)

local resizeMappings = {
  h = {x = 0, y = 0, w = 0.5, h = 1},
  u = {x = 0, y = 0, w = 0.5, h = 0.5},
  o = {x = 0.5, y = 0, w = 0.5, h = 0.5},
  -- b={x=0, y=0.5, w=0.5, h=0.5},
  m = {x = 0.5, y = 0.5, w = 0.5, h = 0.5},
  -- k={x=0, y=0, w=1, h=0.5},
  -- K={x=0, y=0, w=1, h=0.5},
  l = {x = 0.5, y = 0, w = 0.5, h = 1},
  n = {x = 0, y = 0, w = 1, h = 1},
  -- u={x=0, y=0, w=0.33, h=1},
  i = {x = 0.2, y = 0, w = 0.6, h = 1}
  -- o={x=0.33, y=0, w=0.67, h=0.5},
}

-- hs.hotkey.bind({"cmd"}, "h", function()
--   hs.eventtap.keyStroke({''}, "delete")
-- end)

for key in pairs(resizeMappings) do
  hs.hotkey.bind(
    KEYS.ALT,
    key,
    function()
      local win = hs.window.focusedWindow()
      if win then
        win:moveToUnit(resizeMappings[key])
      end
    end
  )
end

editting = {}

editting.cW =
  hs.hotkey.bind(
  KEYS.C,
  "w",
  function()
    hs.eventtap.keyStroke({"alt"}, "delete")
  end
)

editting.cM =
  hs.hotkey.bind(
  KEYS.C,
  "m",
  function()
    hs.eventtap.keyStroke({""}, "return")
  end
)

editting.cE =
  hs.hotkey.bind(
  KEYS.C,
  "e",
  function()
    hs.eventtap.keyStroke({"cmd"}, "right")
  end
)


editting.cB =
  hs.hotkey.bind(
  KEYS.C,
  "b",
  function()
    hs.eventtap.keyStroke({"alt"}, "left")
  end
)

editting.cF =
  hs.hotkey.bind(
  KEYS.C,
  "f",
  function()
    hs.eventtap.keyStroke({"alt"}, "right")
  end
)

ctrl_shift = {"ctrl", "shift"}
-- selecting words
hs.hotkey.bind(
  KEYS.CS,
  "b",
  function()
    hs.eventtap.keyStroke({"alt", "shift"}, "left")
  end
)

hs.hotkey.bind(
  KEYS.CS,
  "f",
  function()
    hs.eventtap.keyStroke({"alt", "shift"}, "right")
  end
)

hs.hotkey.bind(
  KEYS.CS,
  "h",
  function()
    hs.eventtap.keyStroke({"shift"}, "left")
  end
)

hs.hotkey.bind(
  KEYS.CS,
  "l",
  function()
    hs.eventtap.keyStroke({"shift"}, "right")
  end
)


-- disable alt-v for Adobe's built-in shortcut
function applicationWatcher(appName, eventType, appObject)
  if (eventType == hs.application.watcher.activated) then
    for i, v in pairs(editting) do
      v:enable()
    end
    if (string.find(appName, "iTerm") or (string.find(appName, "VIM")) or (string.find(appName, "Alacritty")) or (string.find(appName, "Chromium"))) then
      for i, v in pairs(editting) do
        v:disable()
      end
    elseif not (string.find(appName, "iTerm") or (string.find(appName, "VIM")) or (string.find(appName, "Alacritty"))) then
      for i, v in pairs(editting) do
        v:enable()
      end
    end
  end
end

appWatcher = hs.application.watcher.new(applicationWatcher)
appWatcher:start()

