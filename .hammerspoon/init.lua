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
