-- mail.lua
-- helpers for mail

local module = {}
module.keybinds = {
   hs.hotkey.bind({"ctrl", "cmd"}, "a", function ()
         hs.osascript.applescriptFromFile("~/.hammerspoon/collection-scripts/keepit-com.apple.Mail.scpt")
end)}

for k, binding in pairs(module.keybinds) do
    binding:disable()
end
module.window_filter = hs.window.filter.new{'Mail'}
local focus = function ()
   for k, binding in pairs(module.keybinds) do
      binding:enable()
   end
end

local unfocus = function ()
   for k, binding in pairs(module.keybinds) do
      binding:disable()
   end
end

module.window_filter:subscribe('windowFocused', focus)
module.window_filter:subscribe('windowUnfocused', unfocus)

return module
