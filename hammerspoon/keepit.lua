-- keepit.lua
-- helpers for Keep It
local helpers = require 'helpers'
local module = {}
local keepit = os.getenv("HOME") .. "/Library/Group Containers/D75L7R8266.com.reinvented.KeepIt/Keep It"
local db = hs.sqlite3.open(keepit .. "/Keep It Library.kptlib/KeepIt.sqlite")

local IDENT_SEL_NOPAR = "select ZIDENTIFIER from ZITEM where ZFILENAME = ?"
local IDENT_SEL_ONEPAR = "select ZIDENTIFIER from ZITEM where ZFOLDER =(SELECT Z_PK from ZGROUP where ZNAME = ?) and ZFILENAME = ?"

function chooseFolder()
   -- insert Link
   local files = helpers.runcmd("cd '" .. keepit .. "/Files' && " .. "/usr/local/bin/fd -t d .")
   -- Build the list of emojis to be displayed.
   local choices = {}
   for file in string.gmatch(files, '(.-)[\n\r]') do
      if file ~= nil and string.match(file, "%.kptnote$") == nil then
         if string.match(file, "/") == nil then
            table.insert(choices,
                         {text=file,
                          subText=""})
         else
            local path, name = string.match(file, "(.-/)([^/]+)$")
            if name ~= nil and path ~= nil then
               table.insert(choices,
                            {text=name,
                             subText=path})
            end
         end
      end
   end

   -- Create the chooser.
   -- On selection, move the selected items to the chosen folder.
   local chooser = hs.chooser.new(function(choice)
         if not choice then helpers.focusLastFocused(); return end
         local moveLine = "top level folder"
         local name = string.match(choice.subText, ".-/([^/]+)$")
         if name ~= nil then
            moveLine = 'folder "' .. name .. '" of ' .. moveLine
         end
         for folder in string.gmatch(choice.subText, "(.-)/") do
            moveLine = 'folder "' .. folder .. '" of ' .. moveLine
         end
         moveLine = 'folder "' .. choice.text .. '" of ' .. moveLine
         local scpt = [[
tell application "Keep It"
  repeat with theItem in (get selected items)
    move theItem to (]] .. moveLine .. [[)
  end repeat
end tell]]
         hs.osascript.applescript(scpt)
   end)
   helpers.configureChooser(chooser, choices)
   chooser:show()
end

function chooseLink()
   -- insert Link
   local files = helpers.runcmd("cd '" .. keepit .. "/Files' && " .. "/usr/local/bin/fd")
   -- Build the list of emojis to be displayed.
   local choices = {}
   for file in string.gmatch(files, '(.-)[\n\r]') do
      if file ~= nil then
         local path, name = string.match(file, "(.-/)([^/]+)$")
         if name ~= nil then
            if path == nil then
               path = ""
            end
            table.insert(choices,
                         {text=name,
                          subText=path})
         end
      end
   end

   -- Create the chooser.
   local chooser = hs.chooser.new(function(choice)
         if not choice then helpers.focusLastFocused(); return end
         local path, folder = string.match(choice.subText, "(.-/)([^/]+)")
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
         -- local ident = helpers.runcmd(IDENT_SEL_ONEPAR)
         -- TODO: get identifier from DB
         local ident = nil
         for row in stmt:nrows() do
            ident = row.ZIDENTIFIER
            break
         end
         stmt:finalize()
         helpers.focusLastFocused()
         if ident ~= nil then
            hs.eventtap.keyStrokes("[" .. name .. "](keepit://link?item=" .. ident .. ")")
         end
   end)
   helpers.configureChooser(chooser, choices)
   chooser:show()
end

module.window_filter = hs.window.filter.new{'Keep It'}
module.keybinds = {
   hs.hotkey.bind({"ctrl", "cmd"}, "r", function ()
         hs.osascript.javascriptFromFile(os.getenv("HOME") .. "/.hammerspoon/scripts/keepit-refile.js")
   end),
   hs.hotkey.bind({"ctrl", "cmd"}, "l", chooseLink),
   hs.hotkey.bind({"ctrl", "cmd"}, "m", chooseFolder)
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
