-- keepit.lua
-- helpers for Keep It

local module = {}
local db = hs.sqlite3.open(os.getenv("HOME") .. "/Library/Group Containers/D75L7R8266.com.reinvented.KeepIt/Keep It/Keep It Library.kptlib/KeepIt.sqlite")

local IDENT_SEL_NOPAR = "select ZIDENTIFIER from ZITEM where ZFILENAME = ?"
local IDENT_SEL_ONEPAR = "select ZIDENTIFIER from ZITEM where ZFOLDER =(SELECT Z_PK from ZGROUP where ZNAME = ?) and ZFILENAME = ?"

function runcmd(cmd)
   local handle = assert(io.popen(cmd, "r"))
   local res = handle:read("*all")
   handle:close()
   return res
end

module.window_filter = hs.window.filter.new{'Keep It'}
module.keybinds = {
   hs.hotkey.bind({"ctrl", "cmd"}, "r", function ()
         hs.osascript.javascriptFromFile("~/.hammerspoon/scripts/keepit-refile.js")
   end),
   hs.hotkey.bind({"ctrl", "cmd"}, "l", function ()
         -- insert Link
         local files = runcmd("cd '" .. os.getenv("HOME") .. "/Library/Group Containers/D75L7R8266.com.reinvented.KeepIt/Keep It/Files' && " .. "/usr/local/bin/fd")
         -- Build the list of emojis to be displayed.
         local choices = {}
         for file in string.gmatch(files, '(.-)[\n\r]') do
            if file ~= nil then
                local path, name = string.match(file, "(.-)/([^/]+)$")
                if name ~= nil and path ~= nil then
                   table.insert(choices,
                                {text=name,
                                 subText=path})
                end
            end
         end

         -- Focus the last used window.
         local function focusLastFocused()
            local wf = hs.window.filter
            local lastFocused = wf.defaultCurrentSpace:getWindows(wf.sortByFocusedLast)
            if #lastFocused > 0 then lastFocused[1]:focus() end
         end

         -- Create the chooser.
         -- On selection, copy the emoji and type it into the focused application.
         local chooser = hs.chooser.new(function(choice)
               if not choice then focusLastFocused(); return end
               local path, folder = string.match(choice.subText, "(.-/)-([^/]+)")
               local name = choice.text
               local stmt = IDENT_SEL_NOPAR
               if path ~= nil then
                  stmt = IDENT_SEL_ONEPAR
               end
               stmt = db:prepare(stmt)
               if path ~= nil then
                  stmt:bind_values(path, name)
               else
                  stmt:bind_values(name)
               end
               -- local ident = runcmd(IDENT_SEL_ONEPAR)
               -- TODO: get identifier from DB
               local ident = nil
               for row in stmt:nrows() do
                  ident = row.ZIDENTIFIER
                  break
               end
               stmt:finalize()
               focusLastFocused()
               if ident ~= nil then
                  hs.eventtap.keyStrokes("[" .. name .. "](keepit://link?item=" .. ident .. ")")
               end
         end)

         chooser:rows(5)
         -- chooser:bgDark(true)


         chooser:searchSubText(true)
         chooser:choices(choices)
         chooser:show()
   end)
}
for k, binding in pairs(module.keybinds) do
    binding:disable()
end
local focus = function ()
   -- set up keybindings, etc
   for k, binding in pairs(module.keybinds) do
      binding:enable()
   end
end

local unfocus = function ()
   -- remove keybindings, etc
   for k, binding in pairs(module.keybinds) do
      binding:disable()
   end
end

module.window_filter:subscribe('windowFocused', focus)
module.window_filter:subscribe('windowUnfocused', unfocus)

return module
