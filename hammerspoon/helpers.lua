-- Run a command and return its STDOUT
local module = {}
module.runcmd = function(cmd)
   local handle = assert(io.popen(cmd, "r"))
   local res = handle:read("*all")
   handle:close()
   return res
end

module.currentApp = function()
    local wf = hs.window.filter
    local lastFocused = wf.defaultCurrentSpace:getWindows(wf.sortByFocusedLast)
    if #lastFocused > 0 then
       return lastFocused[1]
    else
       return nil
    end
end

-- Focus the last used window.
module.focusLastFocused = function()
    local wf = hs.window.filter
    local lastFocused = wf.defaultCurrentSpace:getWindows(wf.sortByFocusedLast)
    if #lastFocused > 0 then lastFocused[1]:focus() end
end

-- Configure a chooser with default arguments
module.configureChooser = function(chooser, choices)
   chooser:rows(5)
   chooser:bgDark(true)
   chooser:searchSubText(true)
   chooser:choices(choices)
end

module.fexists = function(file)
   return hs.fs.attributes(file) ~= nil
end

return module
