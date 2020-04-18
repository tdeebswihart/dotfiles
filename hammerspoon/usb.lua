-- ~/.hammerspoon/usb.lua
local module = {}
module.watcher = nil

function usbDeviceCallback(data)
   pn = data["productName"]
   evt = data["eventType"]
   if (pn == "Schiit Modi 3") then
      if evt == "added" then
         dac = hs.audiodevice.findOutputByName(pn)
         if dac ~= nil then
            dac:setDefaultOutputDevice()
         end
      end
   elseif (pn == "Blue Snowball ") then
      if evt == "added" then
         mic = hs.audiodevice.findAudioDeviceByName(pn)
         if mic ~= nil then
            mic:setDefaultInputDevice()
         end
      end
   end
end

module.watcher = hs.usb.watcher.new(usbDeviceCallback)
module.watcher:start()
return module
