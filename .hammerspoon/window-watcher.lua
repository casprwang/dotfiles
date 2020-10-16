local events = hs.uielement.watcher
windowWatcher = {}

local watchers = {}

local function drawNumber(n, win)
    local t = {window = win}
    local textStyle = {
        font = {name = hs.styledtext.defaultFonts.boldSystem, size = 72},
        color = {white = 1, alpha = 1}
    }
    local rect = hs.geometry.rect(90, 90, 90, 90)
    t.box = hs.drawing.rectangle(rect)
    t.box:setLevel("overlay")
    t.box:setFillColor({white = 0.125, alpha = 0.7})
    t.box:setFill(true)
    t.box:setStroke(false)
    t.box:setRoundedRectRadii(8, 8)
    t.box:setRoundedRectRadii(8, 8)
    local textRect = hs.geometry.rect(100, 100, 100, 100)
    local styledText = hs.styledtext.new(n, textStyle)
    t.text = hs.drawing.text(textRect, styledText)
    t.text:setLevel("overlay")
    t.box:show()
    t.text:show()
    t.box:hide(1.5)
    t.text:hide(1.5)
end

local function tablelength(T)
    local count = 0
    for _ in pairs(T) do count = count + 1 end
    return count
end

local function handleWindowEvent(win, event, watcher, info)
    if event == events.elementDestroyed then
        -- window close
        --
        local n = tablelength(watchers[info.pid].windows) - 1
        drawNumber(n, win)
        watcher:stop()
        watchers[info.pid].windows[info.id] = nil
        -- hs.alert.show(tablelength(watchers[element:application():pid()].windows))
    end
end

local function watchWindow(win, initializing)
    if win == nil then return end
    if win.application == nil then return end
    local appWindows = watchers[win:application():pid()].windows
    if win:isStandard() and not appWindows[win:id()] then
        local watcher = win:newWatcher(handleWindowEvent, {
            pid = win:pid(),
            id = win:id(),
            app = win.application
        })
        appWindows[win:id()] = watcher
        watcher:start({
            events.elementDestroyed, events.windowResized, events.windowMoved
        })
        if not initializing then
            -- window create
            -- hs.alert.show('window created: '..win:id()..' with title: '..win:title())
            local n = tablelength(watchers[win:application():pid()].windows)
            drawNumber(n, win)
        end
    end
end

local function handleAppEvent(element, event)
    if event == events.windowCreated then
        watchWindow(element)
    elseif event == events.mainWindowChanged then
        if element:isWindow() then
            -- hs.alert.show(tablelength(watchers[element:application():pid()].windows))
            -- print(watchers[element:application():pid()])
        end
    end
end

local function watchApp(app, initializing)
    if watchers[app:pid()] then return end
    local watcher = app:newWatcher(handleAppEvent)
    watchers[app:pid()] = {watcher = watcher, windows = {}}
    watcher:start({
        events.windowCreated, events.focusedWindowChanged,
        events.mainWindowChanged
    })
    -- Watch any windows that already exist
    for _, window in pairs(app:allWindows()) do
        watchWindow(window, initializing)
    end
end

local function handleGlobalAppEvent(_, event, app)
    if event == hs.application.watcher.launched then
        watchApp(app)
    elseif event == hs.application.watcher.terminated then
        -- Clean up
        local appWatcher = watchers[app:pid()]
        if appWatcher then
            appWatcher.watcher:stop()
            for _, watcher in pairs(appWatcher.windows) do
                watcher:stop()
            end
            watchers[app:pid()] = nil
        end
    end
end

local function init()
    appsWatcher = hs.application.watcher.new(handleGlobalAppEvent)
    appsWatcher:start()
    -- Watch any apps that already exist
    local apps = hs.application.runningApplications()
    for i = 1, #apps do
        if apps[i]:title() ~= "Hammerspoon" then watchApp(apps[i], true) end
    end
end

windowWatcher.init = init
return windowWatcher
