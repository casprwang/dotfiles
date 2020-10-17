hs.window.animationDuration = 0 -- shorten animations
hs.alert.defaultStyle.radius = 2
hs.alert.defaultStyle.textSize = 55
hs.alert.defaultStyle.textFont = "Monaco"
hs.alert.defaultStyle.strokeColor = {black = 0, alpha = 0}
hs.alert.defaultStyle.strokeWidth = 0
hs.alert.defaultStyle.textStyle = {paragraphStyle = {alignment = "center"}}

require('editting-shortcuts-watcher').init()
require('window-watcher').init()
require('window-resizers')
require('base-keybindings')

hs.alert.show("Config loaded")
