require("try-not-to-code")

hs.window.animationDuration = 0.1 -- shorten animations

keys = {
  a   = { "alt"  },
  c   = { "ctrl" },
  cs  = { "ctrl", "shift" },
  ca  = { "ctrl", "alt"},
  hyper = {"cmd", "alt", "shift"}
}

-- for testing new bindings
hs.hotkey.bind(keys.ca, "8", function()
  hs.alert.show(hs.window.focusedWindow():isFrontmost())
end)

appPath = {
  iTerm2="/Applications/iTerm.app",
  Tweetbot="/Applications/Tweetbot.app",
}

-- showing the current time
hs.hotkey.bind(keys.hyper, "6", function()
  local time = hs.timer.localTime()
  local x = math.floor(time/3600)
  local y = math.floor((time - x * 3600)/60)
  hs.alert.show(tostring(x)..":"..tostring(y))
end)

--Predicate that checks if a window belongs to a screen
function isInScreen(screen, win)
  return win:screen() == screen
end


function focusScreen(screen)
  --Get windows within screen, ordered from front to back.
  --If no windows exist, bring focus to desktop. Otherwise, set focus on
  --front-most application window.
  local windows = hs.fnutils.filter(
    hs.window.orderedWindows(),
    hs.fnutils.partial(isInScreen, screen))
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

local showtime =hs.hotkey.bind({"cmd","ctrl", "shift"}, "r", function()
  local time = hs.timer.localTime()
  local x = math.floor(time/3600)
  local y = math.floor((time - x * 3600)/60)
  hs.alert.show(tostring(x)..":"..tostring(y))
  hs.alert.show(hs.eventtap.keyRepeatDelay())
  -- hs.alert.show(tostring(y))
end)


hs.hotkey.bind({"cmd", "ctrl"}, "r", function()
  hs.reload()
end)
hs.alert.show("Config loaded")


hs.hotkey.bind(keys.a, 'j', function ()
  local win=hs.window.focusedWindow()
  local y = win:frame().y
  local x = win:frame().x
  if win then
    win:setTopLeft(hs.geometry.point(x,y))
    win:setSize(win:size():scale({1, 1.33}))
  end
end)


hs.hotkey.bind(keys.a, 'k', function ()
  local win=hs.window.focusedWindow()
  local y = win:frame().y
  local x = win:frame().x
  if win then
    win:setTopLeft(hs.geometry.point(x,y))
    win:setSize(win:size():scale({1, 0.75}))
  end
end)


local resizeMappings = {
  h={x=0, y=0, w=0.5, h=1},
  -- j={x=0, y=0.5, w=1, h=0.5},
  -- J={x=0, y=0.2, w=1, h=0.5},
  -- k={x=0, y=0, w=1, h=0.5},
  -- K={x=0, y=0, w=1, h=0.5},
  l={x=0.5, y=0, w=0.5, h=1},
  n={x=0, y=0, w=1, h=1},
  -- u={x=0, y=0, w=0.33, h=1},
  i={x=0.2, y=0, w=0.6, h=1},
-- o={x=0.33, y=0, w=0.67, h=0.5},
}


for key in pairs(resizeMappings) do
  hs.hotkey.bind(keys.a, key, function()
    local win = hs.window.focusedWindow()
    if win then win:moveToUnit(resizeMappings[key]) end
  end)
end

editting = {}

editting.cW= hs.hotkey.bind(keys.c, "w", function()
  hs.eventtap.keyStroke({'alt'}, "delete")
end)

editting.cM= hs.hotkey.bind(keys.c, "m", function()
  hs.eventtap.keyStroke({''}, "return")
end)

editting.cE = hs.hotkey.bind(keys.c, "e", function()
  hs.eventtap.keyStroke({'cmd'}, "right")
end)

editting.cQ = hs.hotkey.bind(keys.c, "q", function()
  hs.eventtap.keyStroke({'cmd'}, "delete")
end)
-- editting.cQ:enable(postgresq)

editting.cB = hs.hotkey.bind(keys.c, "b", function()
  hs.eventtap.keyStroke({'alt'}, "left")
end)

editting.cF = hs.hotkey.bind(keys.c, "f", function()
  hs.eventtap.keyStroke({'alt'}, "right")
end)



ctrl_shift = { 'ctrl', 'shift' }
-- selecting words
hs.hotkey.bind(keys.cs, "b", function()
  hs.eventtap.keyStroke({'alt', 'shift'}, "left")
end)

hs.hotkey.bind(keys.cs, "f", function()
  hs.eventtap.keyStroke({'alt', 'shift'}, "right")
end)

hs.hotkey.bind(keys.cs, "h", function()
  hs.eventtap.keyStroke({'shift'}, "left")
end)

hs.hotkey.bind(keys.cs, "l", function()
  hs.eventtap.keyStroke({'shift'}, "right")
end)


function toggle_application(_app, path)
  -- Finds running applications
  local app = hs.application.find(_app)
  if app:isFrontmost() then
    app:hide()
    -- hs.alert.show(app:isRunning())
  elseif not app:isFrontmost() then
    -- hs.alert.show('haha')
    hs.application.launchOrFocus(path)
  end
end


hs.hotkey.bind(keys.a, "t", function()
  toggle_application('Tweetbot', appPath.Tweetbot)
end)


-- disable alt-v for Adobe's built-in shortcut
function applicationWatcher(appName, eventType, appObject)
  if (eventType == hs.application.watcher.activated) then
    for i,v in pairs(editting) do
      v:enable()
    end
    if (string.find(appName, 'iTerm') or (string.find(appName, 'VIM'))) then
      for i,v in pairs(editting) do
        v:disable()
      end
    elseif not (string.find(appName, 'Emacs')) then
      for i,v in pairs(editting) do
        v:enable()
      end
    end
    if (string.find(appName, 'Emacs')) or (string.find(appName, 'Atom')) then
      editting.cW:disable()
    elseif not (string.find(appName, 'iTerm') or ( string.find(appName, 'VIM') )) then
      for i,v in pairs(editting) do
        v:enable()
      end
    end
  end
end

appWatcher = hs.application.watcher.new(applicationWatcher)
appWatcher:start()
