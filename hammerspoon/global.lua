local helpers = require 'helpers'
local module = {}
module.hyperkey = {"ctrl", "cmd", "alt", "shift"}

module.guiAppFilter = hs.window.filter.new(function(w) return hs.window.filter.isGuiApp(w:title()) end)

function runningApps()
   local apps = {}
   for _,v in pairs(module.guiAppFilter:getWindows()) do
      if v:application() ~= nil then
         local a = v:application()
         if a:name() ~= nil then
            local bid = a:bundleID()
            table.insert(apps, {text=a:name(),
                                image=hs.image.imageFromAppBundle(bid),
                                bundleID=bid})
         end
      end
   end
   return apps
end

function switchApp()
   local choices = runningApps()
   local chooser = hs.chooser.new(function(choice)
         if not choice then helpers.focusLastFocused(); return end
         local app = hs.application.get(choice.bundleID)
         if app then app:activate() end
   end)
   helpers.configureChooser(chooser, choices)
   chooser:show()
end

function collectFromFrontmostApp()
   local app = helpers.currentApp()
   if app == nil then return end
   local bundleID = string.lower(app:bundleID())
   local scpt = os.getenv("HOME") .. "/.hammerspoon/collection-scripts/" .. bundleID .. ".scpt"
   local js = os.getenv("HOME") .. "/.hammerspoon/collection-scripts/" .. bundleID .. ".js"
   if helpers.fexists(scpt) then
      hs.osascript.applescriptFromFile(scpt)
   elseif helpers.fexists(js) then
      hs.osascript.javascriptFromFile(js)
   else
      print("No collection script exists for " .. bundleID)
   end
end

function todoFromFrontmostApp()
   local app = helpers.currentApp()
   if app == nil then return end
   local bundleID = app:bundleID()
   local scpt = os.getenv("HOME") .. "/.hammerspoon/todo-scripts/" .. bundleID .. ".scpt"
   local js = os.getenv("HOME") .. "/.hammerspoon/todo-scripts/" .. bundleID .. ".js"
   if helpers.fexists(scpt) then
      hs.osascript.applescriptFromFile(scpt)
   elseif helpers.fexists(js) then
      hs.osascript.javascriptFromFile(js)
   else
      print("No collection script exists for " .. bundleID)
   end
end


function launcher(bundleID)
   return function() hs.application.launchOrFocusByBundleID(bundleID) end
end

-- LAUNCHERS
hs.hotkey.bind(module.hyperkey, "e", launcher("org.gnu.Emacs"))
hs.hotkey.bind(module.hyperkey, "f", launcher("org.mozilla.firefox")) -- function() hs.applications.launchOrFocus("/Applications/Firefox.app") end)
hs.hotkey.bind(module.hyperkey, "m", launcher("com.microsoft.teams"))
hs.hotkey.bind(module.hyperkey, "n", launcher("notion.id"))
hs.hotkey.bind(module.hyperkey, "c", launcher("com.microsoft.Outlook"))
hs.hotkey.bind(module.hyperkey, "i", launcher("io.alacritty"))
hs.hotkey.bind(module.hyperkey, "p", function()  -- P for Post. It's stupid, I know, but M and E were taken
                  hs.application.launchOrFocusByBundleID('com.microsoft.Outlook')
end)

-- ACTIONS
hs.hotkey.bind(module.hyperkey, "a", collectFromFrontmostApp) -- a for Archive
hs.hotkey.bind(module.hyperkey, "r", todoFromFrontmostApp) -- r for Remember
