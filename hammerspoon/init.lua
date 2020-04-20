dofile('override-defaults.lua')
dofile('key-mappings.lua')
dofile('window-resize.lua')

require('application-watcher'):start()

hs.alert.show("Config loaded")
