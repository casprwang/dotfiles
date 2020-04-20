local editting, enableEdittingKeys, disableEdittingKeys = require('editting')

-- disable alt-v for Adobe's built-in shortcut
local function applicationWatcher(appName, eventType, appObject)
  if (eventType == hs.application.watcher.activated) then
    for i, v in pairs(editting) do v:enable() end
    if (string.find(appName, "iTerm") or (string.find(appName, "VIM")) or
      (string.find(appName, "Alacritty"))) then
      for i, v in pairs(editting) do v:disable() end
    elseif not (string.find(appName, "iTerm") or
      (string.find(appName, "VIM")) or (string.find(appName, "Alacritty"))) then
      for i, v in pairs(editting) do v:enable() end
    end
  end
end


local appWatcher = hs.application.watcher.new(applicationWatcher)
appWatcher:start()
