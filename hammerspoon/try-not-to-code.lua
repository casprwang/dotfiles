-- -- try not to code

-- -- ref:  https://stackoverflow.com/questions/656199/search-for-an-item-in-a-lua-list
-- function Set(list)
--   local set = {}
--   for _, l in ipairs(list) do set[l] = true end
--   return set
-- end


-- function postLast(appName, startTime, endTime, duration, isEnded)
--   local url1 = "https://first-touch-d70f5.firebaseio.com/periods.json"
--   local url2 = "https://first-touch-d70f5.firebaseio.com/editors/" .. appName ..".json"

--   local data1 = {
--     ["timestamp"] = { [".sv"] = "timestamp" },
--     ["editor"]= appName,
--     ["start"] = startTime,
--     ["duration"] = duration,
--     ["isEnded"] = isEnded
--   }
--   local json1 = hs.json.encode(data1)

--   local data2 = {
--     ["timestamp"] = { [".sv"] = "timestamp" },
--     ["start"] = startTime,
--     ["end"] = endTime,
--     ["duration"] = duration
--   }
--   local json2 = hs.json.encode(data2)

--   hs.http.asyncPost(url1, json1, nil, function(status, data)
--     if(status ~= 200)then
--       hs.alert.show("post1 fucked up")
--     end
--   end)

--   hs.http.asyncPost(url2, json2, nil, function(status, data)
--     if(status ~= 200)then
--       hs.alert.show("post2 fucked up")
--     end
--   end)
-- end

-- function postPending(appName, startTime)
--   local url = "https://first-touch-d70f5.firebaseio.com/periods.json"

--   local data = {
--     ["timestamp"] = { [".sv"] = "timestamp" },
--     ["editor"]= appName,
--     ["start"] = startTime,
--     ["isEnded"] = false
--   }
--   local json = hs.json.encode(data)


--   hs.http.asyncPost(url, json, nil, function(status, data)
--     if(status ~= 200)then
--       hs.alert.show("post pending fucked up")
--     end
--   end)
-- end

-- function getJSDate()
--   bool, result = hs.javascript("new Date().toISOString()")
--   if(bool == false) then
--     hs.alert.show("Javascript fucked up")
--   end
--   return result
-- end

-- function formatFloat(float)
--   local str =  string.format( "%.5f", float)
--   local bool, result =  hs.javascript("parseFloat(".. str ..")")
--   return result
-- end



-- local startTime = getJSDate()
-- local endTime = getJSDate()
-- local unixTime = hs.timer.secondsSinceEpoch()
-- local lastApp = nil

-- function tryNotToCode(appName, eventType, appObject)
--   local editors = Set { "Code", "Atom", "MacVim", "iTerm2" }

--   if(eventType == hs.application.watcher.activated) then

--     if(editors[appName]) then
--       postPending(appName, startTime)
--       -- last is not editor
--       if(editors[lastApp]) then
--         endTime = getJSDate()
--         local duration = formatFloat(hs.timer.secondsSinceEpoch() - unixTime)
--         postLast(lastApp, startTime, endTime, duration, false)
--       end
--       startTime = getJSDate()
--       unixTime = hs.timer.secondsSinceEpoch()
--     else
--       -- cur is not editor
--       if(editors[lastApp])then
--         endTime = getJSDate()
--         local duration = formatFloat(hs.timer.secondsSinceEpoch() - unixTime)
--         postLast(lastApp, startTime, endTime, duration, true)
--       end
--     end

--     lastApp = appName
--   end
-- end


-- Watcher = hs.application.watcher.new(tryNotToCode)
-- Watcher:start()


-- hs.hotkey.bind({"cmd","ctrl", "shift"}, "w", function()
--     hs.alert.show(formatFloat(1.22))
-- end)
