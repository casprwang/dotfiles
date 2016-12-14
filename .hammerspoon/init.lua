local function keyCode(key)
  modifiers = modifiers or {}
  return function()
    hs.eventtap.event.newKeyEvent(modifiers, string.lower(key), true):post()
    hs.timer.usleep(1000)
    hs.eventtap.event.newKeyEvent(modifiers, string.lower(key), false):post()
  end
end

hs.hotkey.bind({"ctrl"}, 'h', keyCode('left') ,  nil,   keyCode('left'))
hs.hotkey.bind({"ctrl"}, 'j', keyCode('down') ,  nil,   keyCode('down') )
hs.hotkey.bind({"ctrl"}, 'k', keyCode('up')   ,  nil,   keyCode('up') )
hs.hotkey.bind({"ctrl"}, 'l', keyCode('right'),  nil,   keyCode('right') )

hs.hotkey.bind({"cmd", "alt", "ctrl"}, "W", function()
  hs.alert.show("!!!!!!!!!!  Fuck the Fuck off  !!!!!!!!!!")
end)


function reloadConfig(files)
    doReload = false
    for _,file in pairs(files) do
        if file:sub(-4) == ".lua" then
            doReload = true
        end
    end
    if doReload then
        hs.reload()
    end
end
local myWatcher = hs.pathwatcher.new(os.getenv("HOME") .. "/.hammerspoon/", reloadConfig):start()
hs.alert.show("Config loaded")

-- hs.hotkey.bind({"cmd", "alt", "ctrl"}, "Left", function()
--   local win = hs.window.focusedWindow()
--   local f = win:frame()
--   local screen = win:screen()
--   local max = screen:frame()
--
--   f.x = max.x
--   f.y = max.y
--   f.w = max.w / 2
--   f.h = max.h
--   win:setFrame(f)
-- end)
--
-- hs.hotkey.bind({"cmd", "alt", "ctrl"}, "Right", function()
--   local win = hs.window.focusedWindow()
--   local f = win:frame()
--   local screen = win:screen()
--   local max = screen:frame()
--
--   f.x = max.x + (max.w / 2)
--   f.y = max.y
--   f.w = max.w / 2
--   f.h = max.h
--   win:setFrame(f)
-- end)
local modalKey = {"alt"}

local resizeMappings = {
  h={x=0, y=0, w=0.5, h=1},
  j={x=0, y=0.5, w=1, h=0.5},
  k={x=0, y=0, w=1, h=0.5},
  l={x=0.5, y=0, w=0.5, h=1},
  m={x=0, y=0, w=1, h=1},
  u={x=0, y=0, w=0.33, h=1},
  i={x=0.33, y=0, w=0.33, h=1},
  o={x=0.66, y=0, w=0.33, h=1},

}

for key in pairs(resizeMappings) do
  hs.hotkey.bind(modalKey, key, function()
    local win = hs.window.focusedWindow()
    if win then win:moveToUnit(resizeMappings[key]) end
  end)
end
