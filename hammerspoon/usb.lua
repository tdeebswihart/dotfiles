-- ~/.hammerspoon/usb.lua
local module = {}

local evtAdd = "added"
local evtRemove = "removed"
local bluen = "Blue Snowball "
local smodi = "Schiit Modi 3"
module.watcher = nil

function usbDeviceCallback(data)
   pn = data["productName"]
   evt = data["eventType"]
   if (pn == smodi) then
      if evt == evtAdd then
         dac = hs.audiodevice.findOutputByName(pn)
         if dac ~= nil then
            dac:setDefaultOutputDevice()
         end
      end
   elseif (pn == bluen) then
      if evt == evtAdd then
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
