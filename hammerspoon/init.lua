dofile('override-defaults.lua')
dofile('key-mappings.lua')
dofile('window-resize.lua')
dofile('window-watcher.lua')

require('application-watcher'):start()

hs.alert.show("Config loaded")

