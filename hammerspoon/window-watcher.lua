local events = hs.uielement.watcher
local utils = require('utils')

local watchers = {}

function init()
  appsWatcher = hs.application.watcher.new(handleGlobalAppEvent)
  appsWatcher:start()

  -- Watch any apps that already exist
  local apps = hs.application.runningApplications()
  for i = 1, #apps do
    if apps[i]:title() ~= "Hammerspoon" then
      watchApp(apps[i], true)
    end
  end
end


function windowCnt(win)
  return tablelength(watchers[win:application():pid()].windows)
end

function drawWindowCount(win)
  local t = { window = win }
  local textStyle = {
    font = {
      name = hs.styledtext.defaultFonts.boldSystem,
      size = 82,
    },
    color = {white = 1, alpha = 1},
  }
  local rect = hs.geometry.rect(
    100,
    100,
    100,
    100
  )
  t.box = hs.drawing.rectangle(rect)
  t.box:setLevel("overlay")
  t.box:setFillColor({white = 0.125, alpha = 0.7})
  t.box:setFill(true)
  t.box:setStroke(false)
  t.box:setRoundedRectRadii(8, 8)
  t.box:setRoundedRectRadii(8, 8)
  local textRect = hs.geometry.rect(100, 100, 100, 100)
  local styledText = hs.styledtext.new(windowCnt(win), textStyle)
  t.text = hs.drawing.text(textRect, styledText)
  t.text:setLevel("overlay")
  t.box:show()
  t.text:show()
  t.box:hide(1.5)
  t.text:hide(1.5)
end

function handleGlobalAppEvent(name, event, app)
  if event == hs.application.watcher.launched then
    watchApp(app)
  elseif event == hs.application.watcher.terminated then
    -- Clean up
    local appWatcher = watchers[app:pid()]
    if appWatcher then
      appWatcher.watcher:stop()
      for id, watcher in pairs(appWatcher.windows) do
        watcher:stop()
      end
      watchers[app:pid()] = nil
    end
  end
end

function watchApp(app, initializing)
  if watchers[app:pid()] then return end

  local watcher = app:newWatcher(handleAppEvent)
  watchers[app:pid()] = {watcher = watcher, windows = {}}

  watcher:start({events.windowCreated, events.focusedWindowChanged, events.mainWindowChanged})

  -- Watch any windows that already exist
  for i, window in pairs(app:allWindows()) do
    watchWindow(window, initializing)
  end
end


function getWindowCount(appId)
end

function tablelength(T)
  local count = 0
  for _ in pairs(T) do count = count + 1 end
  return count
end


function handleAppEvent(element, event)
  if event == events.windowCreated then
    watchWindow(element)
  elseif event == events.mainWindowChanged then
    if element:isWindow() then
      -- hs.alert.show(tablelength(watchers[element:application():pid()].windows))
    end
    -- print(element:id())
    -- print(utils.print_table(watchers[1318]))
    -- Handle window change
  end
end


function watchWindow(win, initializing)
  if win == nil then return end
  if win.application == nil then return end
  local appWindows = watchers[win:application():pid()].windows
  if win:isStandard() and not appWindows[win:id()] then
    local watcher = win:newWatcher(handleWindowEvent, {pid=win:pid(), id=win:id()})
    appWindows[win:id()] = watcher

    watcher:start({events.elementDestroyed, events.windowResized, events.windowMoved})

    if not initializing then
      -- window created
      -- drawWindowCount(win)
      -- hs.alert.show('window created: '..win:id()..' with title: '..win:title())
      -- hs.alert.show(tablelength(watchers[win:application():pid()].windows), .3)
    end
  end
end

function handleWindowEvent(win, event, watcher, info)
  if event == events.elementDestroyed then
    -- drawWindowCount(win)
    watcher:stop()
    watchers[info.pid].windows[info.id] = nil
  else
    -- Handle other events...
  end
  -- hs.alert.show('window event '..event..' on '..info.id)
end

-- init()
