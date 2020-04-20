local enableEdittingKeys, disableEdittingKeys = require('editting')

-- disable alt-v for Adobe's built-in shortcut
local function applicationWatcher(appName, eventType, appObject)
    if (eventType == hs.application.watcher.activated) then
        enableEdittingKeys()
        if (string.find(appName, "iTerm") or (string.find(appName, "VIM")) or
            (string.find(appName, "Alacritty"))) then
            disableEdittingKeys()
        elseif not (string.find(appName, "iTerm") or
            (string.find(appName, "VIM")) or (string.find(appName, "Alacritty"))) then
            enableEdittingKeys()
        end
    end
end

local appWatcher = hs.application.watcher.new(applicationWatcher)

appWatcher:start()
