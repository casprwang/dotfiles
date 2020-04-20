local editting= require('editting')

-- disable alt-v for Adobe's built-in shortcut
local function applicationWatcher(appName, eventType, appObject)
  if (eventType == hs.application.watcher.activated) then
    if (string.find(appName, "iTerm") or (string.find(appName, "VIM")) or
      (string.find(appName, "Alacritty"))) then
      editting.disableEdittingKeys()
    else
      editting.enableEdittingKeys()
    end
  end
end


editting.enableEdittingKeys()
local appWatcher = hs.application.watcher.new(applicationWatcher)
appWatcher:start()
